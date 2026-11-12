extends Control
## Menüfenster über dem Spiel: Questlog (J), Speichern/Laden, Einstellungen (Esc).
## Questlog wie im Prototyp: links Aufgaben mit Verlauf, rechts gesammelte Hinweise.

const PLAETZE := 4

var _offen: Control = null

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _schliessen() -> void:
	if _offen: _offen.queue_free()
	_offen = null

## Abdunkelnder Hintergrund + Kasten; Klick daneben oder Esc schließt
func _rahmen(titel: String, breite: float, rand := Color("#3a3050")) -> VBoxContainer:
	_schliessen()
	var dunkel := ColorRect.new(); dunkel.color = Color(4 / 255.0, 4 / 255.0, 8 / 255.0, 0.72)
	dunkel.set_anchors_preset(Control.PRESET_FULL_RECT); dunkel.mouse_filter = Control.MOUSE_FILTER_STOP
	dunkel.gui_input.connect(func(e): if e is InputEventMouseButton and e.pressed: _schliessen())
	add_child(dunkel); _offen = dunkel
	var mitte := CenterContainer.new(); mitte.set_anchors_preset(Control.PRESET_FULL_RECT); mitte.mouse_filter = Control.MOUSE_FILTER_IGNORE
	dunkel.add_child(mitte)
	var p := PanelContainer.new(); p.custom_minimum_size = Vector2(breite, 0); p.mouse_filter = Control.MOUSE_FILTER_STOP
	p.add_theme_stylebox_override("panel", Stil.kasten(Color("#0e0e16"), rand, 2, 0, Vector4(20, 16, 20, 16)))
	mitte.add_child(p)
	var v := VBoxContainer.new(); v.add_theme_constant_override("separation", 8); p.add_child(v)
	if titel != "":
		var h := Stil.label(titel, 18, Color("#ffe0a0")); v.add_child(h)
	return v

func _schliessen_knopf(v: Control, text := "Schließen (Esc)") -> void:
	var b := Button.new(); b.text = text; b.focus_mode = Control.FOCUS_NONE; b.size_flags_horizontal = Control.SIZE_SHRINK_END
	b.pressed.connect(_schliessen); v.add_child(b)

# ---------- Questlog ----------
func questlog() -> void:
	if _offen and _offen.has_meta("questlog"): _schliessen(); return
	var v := _rahmen("", 880, Color("#6a5a3a")); _offen.set_meta("questlog", true)
	var spalten := HBoxContainer.new(); spalten.add_theme_constant_override("separation", 16); v.add_child(spalten)
	var links := _spalte(spalten, "Aufgaben", 1.3)
	var rechts := _spalte(spalten, "Hinweise", 1.0)
	var liste: Array = GameState.quests.keys()
	liste.sort_custom(func(a, b):
		var qa: Dictionary = GameState.quests[a]; var qb: Dictionary = GameState.quests[b]
		if qa.erledigt != qb.erledigt: return not qa.erledigt
		if qa.neben != qb.neben: return not qa.neben
		return qa.get("nr", 0) > qb.get("nr", 0))
	if liste.is_empty(): links.add_child(_leer("Noch keine Aufgaben."))
	for id in liste: links.add_child(_quest_eintrag(GameState.quests[id]))
	if GameState.notizen.is_empty(): rechts.add_child(_leer("Noch keine Hinweise."))
	for n in GameState.notizen:
		var l := Stil.label(n, 13); l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; l.add_theme_constant_override("outline_size", 0)
		rechts.add_child(l); rechts.add_child(HSeparator.new())
	_schliessen_knopf(v, "Schließen (J)")

func _spalte(eltern: Control, titel: String, gewicht: float) -> VBoxContainer:
	var s := ScrollContainer.new(); s.size_flags_horizontal = Control.SIZE_EXPAND_FILL; s.size_flags_stretch_ratio = gewicht
	s.custom_minimum_size = Vector2(0, 500); s.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	eltern.add_child(s)
	var v := VBoxContainer.new(); v.size_flags_horizontal = Control.SIZE_EXPAND_FILL; v.add_theme_constant_override("separation", 10); s.add_child(v)
	v.add_child(Stil.label(titel, 18, Color("#ffe0a0")))
	return v

func _leer(t: String) -> Label:
	var l := Stil.label(t, 12); l.modulate.a = 0.6; return l

func _quest_eintrag(q: Dictionary) -> Control:
	var p := PanelContainer.new()
	var sb := StyleBoxFlat.new(); sb.bg_color = Color(1, 1, 1, 0.03); sb.border_width_left = 3
	sb.border_color = Color("#4a6a4a") if q.erledigt else (Color("#5a8ac0") if q.neben else Color("#c8a050"))
	sb.content_margin_left = 10; sb.content_margin_right = 10; sb.content_margin_top = 6; sb.content_margin_bottom = 6
	p.add_theme_stylebox_override("panel", sb)
	if q.erledigt: p.modulate.a = 0.6
	var t := RichTextLabel.new(); t.bbcode_enabled = true; t.fit_content = true; t.scroll_active = false
	t.add_theme_font_override("bold_font", Stil.schrift(Stil.SCHRIFT, 700))
	t.add_theme_font_size_override("normal_font_size", 12); t.add_theme_font_size_override("bold_font_size", 14)
	var art := "erledigt" if q.erledigt else ("Nebenaufgabe" if q.neben else "Hauptaufgabe")
	var s := "[b]%s[/b]  [font_size=10][color=#a0a0b0][%s][/color][/font_size]\n" % [q.name, art]
	var log: Array = q.get("log", [q.ziel])
	for i in log.size():
		var jetzt: bool = i == log.size() - 1 and not q.erledigt
		s += ("[color=#fff0c8]◆ %s[/color]\n" if jetzt else "[color=#b8b0a8]· %s[/color]\n") % log[i]
	t.text = s.strip_edges()
	p.add_child(t)
	return p

# ---------- Speichern / Laden ----------
func speichern_laden() -> void:
	var v := _rahmen("Speichern / Laden", 520)
	for i in PLAETZE:
		var h := HBoxContainer.new(); h.add_theme_constant_override("separation", 8); v.add_child(h)
		var info := Spielstand.info(i)
		var name := "Schnellspeicher" if i == 0 else "Platz %d" % i
		var l := Stil.label("%s – %s" % [name, info.get("zeit", "leer").replace("T", " ")], 14)
		l.size_flags_horizontal = Control.SIZE_EXPAND_FILL; h.add_child(l)
		var s := Button.new(); s.text = "Speichern"; s.focus_mode = Control.FOCUS_NONE
		s.pressed.connect(func(): Spielstand.speichern(i, get_tree().current_scene.scene_file_path); speichern_laden())
		h.add_child(s)
		var ld := Button.new(); ld.text = "Laden"; ld.focus_mode = Control.FOCUS_NONE; ld.disabled = info.is_empty()
		ld.pressed.connect(func(): _schliessen(); Spielstand.laden(i, get_tree()))
		h.add_child(ld)
	_schliessen_knopf(v)

# ---------- Einstellungen ----------
func einstellungen() -> void:
	if _offen: _schliessen(); return
	var v := _rahmen("Einstellungen", 420)
	for paar in [["unschaerfe", "Tiefenunschärfe"], ["bloom", "Bloom"], ["spiegelungen", "Spiegelungen (nasse Straßen)"], ["fps_anzeigen", "Leistung anzeigen"]]:
		var c := CheckButton.new(); c.text = paar[1]; c.button_pressed = Einstellungen.an(paar[0]); c.focus_mode = Control.FOCUS_NONE
		c.toggled.connect(func(_an): Einstellungen.umschalten(paar[0]))
		v.add_child(c)
	var vb := CheckButton.new(); vb.text = "Vollbild"; vb.focus_mode = Control.FOCUS_NONE
	vb.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	vb.toggled.connect(func(an): DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if an else DisplayServer.WINDOW_MODE_WINDOWED))
	v.add_child(vb)
	var ende := Button.new(); ende.text = "Spiel beenden"; ende.focus_mode = Control.FOCUS_NONE
	ende.pressed.connect(func(): get_tree().quit()); v.add_child(ende)
	_schliessen_knopf(v)

func _unhandled_input(e: InputEvent) -> void:
	if _offen and e is InputEventKey and e.pressed and e.keycode == KEY_ESCAPE:
		_schliessen(); get_viewport().set_input_as_handled()
