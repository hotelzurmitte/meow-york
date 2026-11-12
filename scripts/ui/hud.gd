extends CanvasLayer
## HUD wie im Prototyp (shell.html):
##  oben links  Geld und aktuelle Aufgabe (#shud)
##  oben rechts Knopfleiste (#panel)          → hud_leiste.gd
##  unten links Gruppenkarten mit LP (#partyUI) → hud_gruppe.gd
##  unten rechts Steuerungshilfe (#hint)
##  oben Mitte  Einblendungen (#toasts), Bildmitte Meldungen (#msg)
##  Maus über Figuren/Türen: Namensschild und Hervorhebung → zeiger.gd
## Dazu Kapitelkarte, Abblenden und „Szene überspringen“ für Zwischensequenzen.

signal ueberspringen

const HILFE := "Linksklick laufen/sprechen/benutzen · Doppelklick rennen · F interagieren · Alt alles hervorheben\nWASD Kamera schwenken · Q/E oder Mittelmaus drehen · Mittelmaus hoch/runter Kamerahöhe · Rad zoomen · Pos1 zentrieren · O Draufsicht\nJ Questlog · F5/F9 Schnellspeichern/-laden · F3 Leistung"

var wurzel: Control
var _geld: Label
var _quest: PanelContainer
var _quest_text: RichTextLabel
var _hilfe: Label
var _meldung: Label
var _toasts: VBoxContainer
var _gruppe: Control
var _leiste: Control
var _kino := false
var _meldung_tw: Tween

func _ready() -> void:
	layer = 10
	wurzel = Control.new(); wurzel.name = "Wurzel"; wurzel.set_anchors_preset(Control.PRESET_FULL_RECT)
	wurzel.mouse_filter = Control.MOUSE_FILTER_IGNORE; wurzel.theme = Stil.theme(); add_child(wurzel)
	# Geld + Aufgabe
	var shud := VBoxContainer.new(); shud.position = Vector2(14, 40); shud.custom_minimum_size = Vector2(330, 0)
	shud.mouse_filter = Control.MOUSE_FILTER_IGNORE; shud.add_theme_constant_override("separation", 6); wurzel.add_child(shud)
	_geld = Stil.label("", 13, Stil.GOLD); shud.add_child(_geld)
	_quest = PanelContainer.new(); _quest.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var qs := StyleBoxFlat.new(); qs.bg_color = Color(10 / 255.0, 8 / 255.0, 14 / 255.0, 0.6); qs.border_width_left = 2; qs.border_color = Color("#ffb060")
	qs.content_margin_left = 8; qs.content_margin_right = 8; qs.content_margin_top = 4; qs.content_margin_bottom = 4
	_quest.add_theme_stylebox_override("panel", qs); shud.add_child(_quest)
	_quest_text = RichTextLabel.new(); _quest_text.bbcode_enabled = true; _quest_text.fit_content = true; _quest_text.scroll_active = false
	_quest_text.custom_minimum_size = Vector2(314, 0); _quest_text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_quest_text.add_theme_font_size_override("normal_font_size", 13); _quest_text.add_theme_font_size_override("bold_font_size", 13)
	_quest_text.add_theme_font_override("bold_font", Stil.schrift(Stil.SCHRIFT, 700))
	_quest.add_child(_quest_text)
	# Hilfe unten rechts
	_hilfe = Stil.label(HILFE, 13); _hilfe.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_hilfe.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT); _hilfe.grow_horizontal = Control.GROW_DIRECTION_BEGIN; _hilfe.grow_vertical = Control.GROW_DIRECTION_BEGIN
	_hilfe.offset_right = -14; _hilfe.offset_bottom = -12; _hilfe.modulate.a = 0.7
	_hilfe.add_theme_constant_override("line_spacing", 3)
	wurzel.add_child(_hilfe)
	# Meldung (Bildmitte, 40 % von oben)
	_meldung = Stil.label("", 24); _meldung.anchor_left = 0.5; _meldung.anchor_right = 0.5; _meldung.anchor_top = 0.4
	_meldung.offset_left = -480; _meldung.offset_right = 480; _meldung.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_meldung.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; _meldung.add_theme_constant_override("outline_size", 7)
	_meldung.modulate.a = 0.0; wurzel.add_child(_meldung)
	# Einblendungen oben Mitte
	_toasts = VBoxContainer.new(); _toasts.anchor_left = 0.5; _toasts.anchor_right = 0.5; _toasts.offset_left = -400; _toasts.offset_right = 400
	_toasts.offset_top = 64; _toasts.alignment = BoxContainer.ALIGNMENT_BEGIN; _toasts.add_theme_constant_override("separation", 4)
	_toasts.mouse_filter = Control.MOUSE_FILTER_IGNORE; wurzel.add_child(_toasts)
	# Teile
	_gruppe = preload("res://scripts/ui/hud_gruppe.gd").new(); _gruppe.name = "Gruppe"; wurzel.add_child(_gruppe)
	_leiste = preload("res://scripts/ui/hud_leiste.gd").new(); _leiste.name = "Leiste"; wurzel.add_child(_leiste)
	var z := preload("res://scripts/ui/zeiger.gd").new(); z.name = "Zeiger"; wurzel.add_child(z)
	var f := preload("res://scripts/ui/fenster.gd").new(); f.name = "Fenster"; wurzel.add_child(f)
	EventBus.geld_geaendert.connect(func(_g): _aktualisieren())
	EventBus.quest_geaendert.connect(func(_q): _aktualisieren())
	EventBus.meldung.connect(_zeige_meldung)
	EventBus.hinweis.connect(_toast)
	_aktualisieren()

func _aktualisieren() -> void:
	_geld.text = "¢ %d Collar" % GameState.geld
	var q: Dictionary = GameState.quests.get(GameState.aktuelle_quest, {})
	_quest.visible = not q.is_empty()
	if q.is_empty(): return
	_quest_text.text = "[b]◆ %s[/b]\n%s" % [q.name, q.ziel]
	var sb: StyleBoxFlat = _quest.get_theme_stylebox("panel")
	sb.border_color = Color("#7aff9a") if q.erledigt else Color("#ffb060")
	_quest.modulate.a = 0.7 if q.erledigt else 1.0

## Zwischensequenz: Gruppe, Hilfe, Leiste und Aufgabe ausblenden (body.cine im Prototyp)
func kino(an: bool) -> void:
	_kino = an
	for c in [_gruppe, _leiste, _hilfe]: c.visible = not an
	_aktualisieren()

func _zeige_meldung(t: String) -> void:
	_meldung.text = t
	if _meldung_tw: _meldung_tw.kill()
	_meldung_tw = create_tween()
	_meldung_tw.tween_property(_meldung, "modulate:a", 1.0, 0.6)
	_meldung_tw.tween_interval(2.6)
	_meldung_tw.tween_property(_meldung, "modulate:a", 0.0, 0.6)

const TOAST_FARBEN := {"gut": ["#9aff9a", "#2a6a3a"], "schlecht": ["#ff9a8a", "#6a2a2a"], "info": ["#d8b0ff", "#5a3a7a"],
	"geld": ["#ffe08a", "#7a6020"], "quest": ["#ffd0a0", "#8a5a2a"]}

func _toast(t: String, art: String) -> void:
	var p := PanelContainer.new(); p.mouse_filter = Control.MOUSE_FILTER_IGNORE
	p.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	var f: Array = TOAST_FARBEN.get(art, ["#ece4d4", "#4a3a50"])
	p.add_theme_stylebox_override("panel", Stil.kasten(Color(10 / 255.0, 8 / 255.0, 14 / 255.0, 0.85), Color(f[1]), 1, 0, Vector4(14, 4, 14, 4)))
	var l := Stil.label(t, 14, Color(f[0])); l.add_theme_constant_override("outline_size", 0); p.add_child(l)
	_toasts.add_child(p)
	p.modulate.a = 0.0
	var tw := p.create_tween()
	tw.tween_property(p, "modulate:a", 1.0, 0.3)
	tw.tween_interval(2.3)
	tw.tween_property(p, "modulate:a", 0.0, 0.5)
	tw.tween_callback(p.queue_free)

# ---------- Kapitelkarte, Abblenden, Überspringen ----------
var _blende: ColorRect
var _skip: Button

func kapitelkarte(titel: String, unter: String) -> void:
	var box := VBoxContainer.new(); box.anchor_left = 0.5; box.anchor_right = 0.5; box.anchor_top = 0.36
	box.offset_left = -500; box.offset_right = 500; box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var u := Stil.label(unter, 17, Color("#ece4d4")); u.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var t := Stil.label(titel, 52, Color("#ffd6f4")); t.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	t.add_theme_font_override("font", Stil.schrift(Stil.SCHRIFT_TITEL))
	t.add_theme_color_override("font_outline_color", Color(1, 0.23, 0.82, 0.55)); t.add_theme_constant_override("outline_size", 12)
	box.add_child(t); box.add_child(u)
	box.modulate.a = 0.0; wurzel.add_child(box)
	var tw := create_tween(); tw.tween_property(box, "modulate:a", 1.0, 0.8); tw.tween_interval(2.0); tw.tween_property(box, "modulate:a", 0.0, 0.6); tw.tween_callback(box.queue_free)

func abblenden(dauer := 0.5) -> void:
	if _blende == null:
		_blende = ColorRect.new(); _blende.color = Color(0, 0, 0, 0); _blende.set_anchors_preset(Control.PRESET_FULL_RECT)
		_blende.mouse_filter = Control.MOUSE_FILTER_IGNORE; wurzel.add_child(_blende)
	var tw := create_tween(); tw.tween_property(_blende, "color:a", 1.0, dauer)
	await tw.finished

func zeige_ueberspringen(an: bool) -> void:
	if _skip == null:
		_skip = Button.new(); _skip.text = "Szene überspringen"; _skip.anchor_left = 1; _skip.anchor_right = 1; _skip.offset_left = -190; _skip.offset_top = 12; _skip.offset_right = -14
		_skip.pressed.connect(func(): ueberspringen.emit()); wurzel.add_child(_skip)
	_skip.visible = an
