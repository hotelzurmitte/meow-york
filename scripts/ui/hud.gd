extends CanvasLayer
## Anzeige: Geld, Steuerungshinweis, „F – …“-Hinweis in der Nähe, Einblendungen und Meldungen.

var _geld: Label
var _hinweis: Label
var _meldung: Label
var _toasts: VBoxContainer
var _meldung_zeit := 0.0

func _ready() -> void:
	_geld = _label(Vector2(16, 12), 16); _geld.text = "¢ %d Collar" % GameState.geld
	var hilfe := _label(Vector2(16, 0), 13); hilfe.anchor_top = 1; hilfe.anchor_bottom = 1; hilfe.offset_top = -30
	hilfe.text = "Linksklick laufen · Doppelklick rennen · F sprechen/benutzen · Q/E oder Mittelmaus drehen · Mittelmaus hoch/runter Kamerahöhe · Rad zoomen · WASD Kamera schwenken · Pos1 zentrieren"
	hilfe.modulate = Color(1, 1, 1, 0.75)
	_hinweis = _label(Vector2.ZERO, 16); _hinweis.anchor_left = 0.5; _hinweis.anchor_right = 0.5; _hinweis.anchor_top = 1; _hinweis.anchor_bottom = 1
	_hinweis.offset_left = -300; _hinweis.offset_right = 300; _hinweis.offset_top = -80; _hinweis.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_meldung = _label(Vector2.ZERO, 18); _meldung.anchor_left = 0.5; _meldung.anchor_right = 0.5; _meldung.anchor_top = 0.2
	_meldung.offset_left = -420; _meldung.offset_right = 420; _meldung.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; _meldung.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_toasts = VBoxContainer.new(); _toasts.position = Vector2(16, 44); add_child(_toasts)
	EventBus.geld_geaendert.connect(func(g): _geld.text = "¢ %d Collar" % g)
	EventBus.meldung.connect(_zeige_meldung)
	EventBus.hinweis.connect(_toast)

func _label(pos: Vector2, groesse: int) -> Label:
	var l := Label.new(); l.position = pos; l.add_theme_font_size_override("font_size", groesse)
	l.add_theme_color_override("font_outline_color", Color(0, 0, 0)); l.add_theme_constant_override("outline_size", 5)
	add_child(l); return l

func _zeige_meldung(t: String) -> void:
	_meldung.text = t; _meldung_zeit = 3.5

func _toast(t: String, art: String) -> void:
	var l := Label.new(); l.text = t; l.add_theme_font_size_override("font_size", 14)
	l.add_theme_color_override("font_outline_color", Color(0, 0, 0)); l.add_theme_constant_override("outline_size", 4)
	l.modulate = {"gut": Color(0.6, 1, 0.6), "schlecht": Color(1, 0.6, 0.55), "quest": Color(1, 0.85, 0.4)}.get(art, Color.WHITE)
	_toasts.add_child(l)
	get_tree().create_timer(4.0).timeout.connect(l.queue_free)

func _process(dt: float) -> void:
	_meldung_zeit -= dt; _meldung.visible = _meldung_zeit > 0
	var s := get_tree().get_first_node_in_group("spieler") as Node3D
	_hinweis.text = ""
	if s and not Dialog.aktiv:
		var best: Node = null; var bd := 2.2
		for n in get_tree().get_nodes_in_group("interaktiv"):
			if not n.is_visible_in_tree(): continue
			var d: float = Vector2(n.global_position.x - s.global_position.x, n.global_position.z - s.global_position.z).length()
			if d < bd: bd = d; best = n
		if best: _hinweis.text = "F – " + best.hinweis
