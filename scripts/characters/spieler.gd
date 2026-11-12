extends CharacterBody3D
## Gruppenmitglied. Der Anführer (Ren) läuft per Mausklick wie im Prototyp:
##  Linksklick: hingehen · Doppelklick: rennen · Klick auf eine Figur oder Tür: hingehen und ansprechen
##  F: mit dem Nächsten in Reichweite sprechen bzw. benutzen
## Die anderen folgen dem Vordermann.

@export var anfuehrer := false
@export var folgt: NodePath
@export var gehen := 5.2
@export var rennen := 8.5

@onready var figur: PixelFigur = $Figur
var _ziel = null
var _rennt := false
var _aktion: Node = null      ## Interaktion, die nach dem Hinlaufen ausgelöst wird
var _bild := 0.0
var _letzter_klick := 0
var _fest := 0.0               ## wie lange der Anführer schon festhängt
var gesperrt := false          ## während Dialogen und Zwischensequenzen

func _ready() -> void:
	motion_mode = CharacterBody3D.MOTION_MODE_FLOATING
	add_to_group("gruppe")
	if anfuehrer: add_to_group("spieler")
	EventBus.dialog_gestartet.connect(_sperren)
	EventBus.dialog_beendet.connect(func(): gesperrt = false)

func _sperren(_s) -> void:
	gesperrt = true
	_ziel = null

func _unhandled_input(e: InputEvent) -> void:
	if not anfuehrer or gesperrt: return
	if e is InputEventMouseButton and e.pressed and e.button_index == MOUSE_BUTTON_LEFT:
		var jetzt := Time.get_ticks_msec(); _rennt = jetzt - _letzter_klick < 300; _letzter_klick = jetzt
		var kam = get_tree().get_first_node_in_group("kamera")
		var p = kam.boden_unter_maus(e.position) if kam else null
		if p == null: return
		_markieren(p)
		# Figur oder Tür unter der Maus? Dann hingehen und ansprechen/benutzen
		var z = get_tree().get_first_node_in_group("zeiger")
		_aktion = z.ziel if z and z.ziel else _interaktiv_bei(p, 1.3)
		_ziel = p if _aktion == null else _aktion.global_position
		get_viewport().set_input_as_handled()
	elif e is InputEventKey and e.pressed and e.keycode == KEY_F:
		var n := _interaktiv_bei(global_position, 2.2)
		if n: n.benutzen(self)

## Klickmarke am Boden (goldener Ring, der verblasst) wie showClickMark im Prototyp
var _marke: MeshInstance3D
func _markieren(p: Vector3) -> void:
	if _marke == null:
		_marke = MeshInstance3D.new()
		var t := TorusMesh.new(); t.inner_radius = 0.28; t.outer_radius = 0.38; t.rings = 24; t.ring_segments = 4
		_marke.mesh = t; _marke.scale = Vector3(1, 0.05, 1)
		var m := StandardMaterial3D.new(); m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA; m.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
		m.albedo_color = Color("#ffe08a"); _marke.material_override = m
		_marke.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		get_parent().add_child(_marke)
	_marke.global_position = Vector3(p.x, 0.05, p.z)
	_marke.visible = true
	var m: StandardMaterial3D = _marke.material_override
	var tw := _marke.create_tween().set_parallel(true)
	m.albedo_color.a = 0.9; _marke.scale = Vector3(1, 0.05, 1)
	tw.tween_property(m, "albedo_color:a", 0.0, 0.75)
	tw.tween_property(_marke, "scale", Vector3(1.4, 0.05, 1.4), 0.8)

func _interaktiv_bei(p: Vector3, r: float) -> Node:
	var best: Node = null; var bd := r
	for n in get_tree().get_nodes_in_group("interaktiv"):
		if not n.is_visible_in_tree(): continue
		var d: float = Vector2(n.global_position.x - p.x, n.global_position.z - p.z).length()
		if d < bd: bd = d; best = n
	return best

func _physics_process(dt: float) -> void:
	var v := Vector3.ZERO; var tempo := 0.0
	if anfuehrer:
		if _ziel != null and not gesperrt:
			var d: Vector3 = _ziel - global_position; d.y = 0
			var stopp := (1.9 if _ist_figur(_aktion) else 1.0) if _aktion else 0.12
			if d.length() > stopp:
				tempo = rennen if _rennt else gehen
				v = d.normalized() * tempo
			else:
				_ziel = null
				if _aktion:
					var a := _aktion
					_aktion = null
					a.benutzen(self)
	else:
		var f := get_node_or_null(folgt) as Node3D
		if f:
			var d: Vector3 = f.global_position - global_position; d.y = 0
			if d.length() > 1.9:
				tempo = min(d.length() * 2.6, 8.5)
				v = d.normalized() * tempo
	velocity = v
	var vorher := global_position
	move_and_slide()
	global_position.y = 0.0
	# Hängt der Anführer an einem Hindernis fest (noch keine Wegfindung):
	# nah genug am Ziel → trotzdem ansprechen, sonst nach kurzer Zeit aufgeben.
	if anfuehrer and _ziel != null and v.length() > 0.1:
		var weg := (global_position - vorher).length()
		_fest = _fest + dt if weg < v.length() * dt * 0.2 else 0.0
		if _fest > 0.3:
			var rest: Vector3 = _ziel - global_position; rest.y = 0
			var a := _aktion
			_ziel = null; _aktion = null; _fest = 0.0
			if a and rest.length() < 3.4: a.benutzen(self)
	if v.length() > 0.1:
		figur.schaue(v.x, v.z)
		_bild += dt * (13.0 if tempo > 6.0 else 9.0)
		figur.zeige("run" if tempo > 6.0 else "jog", _bild)
	else:
		_bild += dt * 6.0
		figur.zeige("idle", _bild)

static func _ist_figur(n: Node) -> bool:
	return n != null and n.has_node("Figur") and "hoehe" in n
