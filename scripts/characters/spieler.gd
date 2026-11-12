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
		_aktion = _interaktiv_bei(p, 1.3)
		_ziel = p if _aktion == null else _aktion.global_position
	elif e is InputEventKey and e.pressed and e.keycode == KEY_F:
		var n := _interaktiv_bei(global_position, 2.2)
		if n: n.benutzen(self)

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
			var stopp := 1.3 if _aktion else 0.12
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
	move_and_slide()
	global_position.y = 0.0
	if v.length() > 0.1:
		figur.schaue(v.x, v.z)
		_bild += dt * (13.0 if tempo > 6.0 else 9.0)
		figur.zeige("run" if tempo > 6.0 else "jog", _bild)
	else:
		_bild += dt * 6.0
		figur.zeige("idle", _bild)
