extends Control
## Was liegt unter der Maus? (pickHover/updateHover im Prototyp)
##  Figuren: Treffer auf dem Sprite-Umriss am Bildschirm, Figur leuchtet golden, Schild „Sprechen: Name“
##  Türen/Übergänge: im Umkreis von 46 px um den Punkt 1,1 m über dem Boden, grünes Schild
##  Alt gedrückt: alle ansprechbaren Dinge im Bild beschriften
## Der Spieler fragt beim Klick ziel ab und läuft dann hin.

var ziel: Node3D = null
var _schild: PanelContainer
var _schild_text: Label
var _alt_schilder: Array = []

func _ready() -> void:
	add_to_group("zeiger")
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	_schild = _neues_schild(13)
	_schild_text = _schild.get_child(0)
	_schild.hide()

func _neues_schild(groesse: int) -> PanelContainer:
	var p := PanelContainer.new(); p.mouse_filter = Control.MOUSE_FILTER_IGNORE; p.z_index = 30
	var l := Stil.label("", groesse); l.add_theme_constant_override("outline_size", 0); p.add_child(l)
	add_child(p); return p

func _faerben(p: PanelContainer, tuer: bool) -> void:
	var rand := Color("#3a7a5a") if tuer else Color("#6a5a3a")
	p.add_theme_stylebox_override("panel", Stil.kasten(Color(10 / 255.0, 10 / 255.0, 18 / 255.0, 0.85), rand, 1, 0, Vector4(8, 3, 8, 3)))
	(p.get_child(0) as Label).add_theme_color_override("font_color", Color("#c0ffd8") if tuer else Color("#ffe8b0"))

static func ist_figur(n: Node) -> bool:
	return n.has_node("Figur") and "hoehe" in n

static func beschriftung(n: Node) -> String:
	return String(n.hinweis).trim_prefix("E – ")

func _gesperrt() -> bool:
	if Dialog.aktiv or get_tree().paused: return true
	var f := get_parent().get_node_or_null("Fenster")
	if f and f._offen: return true
	var kam := get_tree().get_first_node_in_group("kamera")
	if kam and not kam.steuerbar: return true
	return get_viewport().gui_get_hovered_control() != null

func _process(_dt: float) -> void:
	var cam := get_viewport().get_camera_3d()
	ziel = null
	if cam and not _gesperrt():
		ziel = _waehle(cam, get_viewport().get_mouse_position())
	if ziel:
		if ist_figur(ziel): ziel.get_node("Figur").gold = max(ziel.get_node("Figur").gold, 0.32)
		_schild_text.text = beschriftung(ziel)
		_faerben(_schild, not ist_figur(ziel))
		_schild.position = get_viewport().get_mouse_position() + Vector2(16, 14)
		_schild.reset_size(); _schild.show()
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		_schild.hide()
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	_alt(cam)

func _waehle(cam: Camera3D, m: Vector2) -> Node3D:
	var best: Node3D = null; var bd := 1e9
	for n in get_tree().get_nodes_in_group("interaktiv"):
		if not (n is Node3D) or not n.is_visible_in_tree(): continue
		var p: Vector3 = n.global_position
		var d := 1e9
		if ist_figur(n):
			if cam.is_position_behind(p): continue
			var fuss := cam.unproject_position(p)
			var kopf := cam.unproject_position(p + Vector3(0, n.hoehe, 0))
			var h := fuss.y - kopf.y; var w := h * 0.36
			var dx: float = abs(m.x - fuss.x)
			if dx < w and m.y > kopf.y - 4 and m.y < fuss.y + 6:
				d = Vector2(dx, (m.y - (fuss.y + kopf.y) / 2.0) * 0.5).length()
		else:
			var q := p + Vector3(0, 1.1, 0)
			if cam.is_position_behind(q): continue
			var dd := cam.unproject_position(q).distance_to(m)
			if dd < 46: d = dd
		if d < bd: bd = d; best = n
	return best

func _alt(cam: Camera3D) -> void:
	var n := 0
	if cam and Input.is_key_pressed(KEY_ALT) and not _gesperrt():
		var groesse := get_viewport_rect().size
		for o in get_tree().get_nodes_in_group("interaktiv"):
			if not (o is Node3D) or not o.is_visible_in_tree(): continue
			var figur := ist_figur(o)
			var p: Vector3 = o.global_position + Vector3(0, (o.hoehe + 0.2) if figur else 2.2, 0)
			if cam.is_position_behind(p): continue
			var s := cam.unproject_position(p)
			if s.x < 0 or s.y < 0 or s.x > groesse.x or s.y > groesse.y: continue
			if n >= _alt_schilder.size(): _alt_schilder.append(_neues_schild(12))
			var sch: PanelContainer = _alt_schilder[n]; n += 1
			(sch.get_child(0) as Label).text = o.anzeigename if figur else beschriftung(o)
			_faerben(sch, not figur)
			sch.reset_size(); sch.position = s - Vector2(sch.size.x / 2.0, sch.size.y); sch.show()
			if figur: o.get_node("Figur").gold = max(o.get_node("Figur").gold, 0.25)
	for i in range(n, _alt_schilder.size()): _alt_schilder[i].hide()
