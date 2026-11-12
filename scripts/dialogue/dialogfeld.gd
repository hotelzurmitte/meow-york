extends CanvasLayer
## Dialogfeld unten in der Bildmitte – nachgebaut nach #dlg2 im Prototyp:
##  links das Porträt (96 × 96, Pixel), rechts Name (Yellowtail, gold), Text (tippt mit 55 Zeichen/s)
##  und darunter die nummerierten Antworten. Proben erscheinen blau als [Fertigkeit · SG n · Figur ±b].
##  Ohne Antworten: „▼ Weiter (Leertaste)“ bzw. „▼ Ende (Leertaste)“.
## Tasten: 1–9 wählen · Leertaste/Enter/Klick weiter bzw. Text sofort ganz zeigen.
## Wird vom Dialogue Manager über runtime/balloon_path erzeugt (start()).

const ZEICHEN_PRO_S := 55.0

var resource: DialogueResource
var zustaende: Array = []
var zeile: DialogueLine
var _antworten: Array = []
var _sperre := false
var _einzeln := false          ## nur ein einzelner Spruch (NPC ohne Dialog)

var _feld: PanelContainer
var _bild_rahmen: PanelContainer
var _bild: TextureRect
var _name: Label
var _text: DialogueLabel
var _optionen: VBoxContainer

func _ready() -> void:
	layer = 20
	_bauen()
	_feld.hide()

func _bauen() -> void:
	var wurzel := Control.new(); wurzel.set_anchors_preset(Control.PRESET_FULL_RECT)
	wurzel.mouse_filter = Control.MOUSE_FILTER_IGNORE; wurzel.theme = Stil.theme(); add_child(wurzel)
	_feld = PanelContainer.new()
	_feld.anchor_left = 0.5; _feld.anchor_right = 0.5; _feld.anchor_top = 1; _feld.anchor_bottom = 1
	_feld.grow_horizontal = Control.GROW_DIRECTION_BOTH; _feld.grow_vertical = Control.GROW_DIRECTION_BEGIN
	_feld.offset_left = -450; _feld.offset_right = 450; _feld.offset_bottom = -25
	var sb := Stil.kasten(Color(11 / 255.0, 8 / 255.0, 16 / 255.0, 0.95), Color("#5a4630"), 1, 0, Vector4(22, 18, 22, 16))
	sb.shadow_color = Color(0, 0, 0, 0.6); sb.shadow_size = 18; sb.shadow_offset = Vector2(0, 8)
	sb.expand_margin_left = 0
	_feld.add_theme_stylebox_override("panel", sb)
	_feld.gui_input.connect(_feld_klick)
	wurzel.add_child(_feld)
	var reihe := HBoxContainer.new(); reihe.add_theme_constant_override("separation", 16); _feld.add_child(reihe)
	# Porträt
	_bild_rahmen = PanelContainer.new(); _bild_rahmen.custom_minimum_size = Vector2(96, 96)
	_bild_rahmen.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	_bild_rahmen.add_theme_stylebox_override("panel", Stil.kasten(Color("#2a1f18"), Color("#6a5436"), 1, 0, Vector4(0, 0, 0, 0)))
	_bild = TextureRect.new(); _bild.custom_minimum_size = Vector2(96, 96)
	_bild.expand_mode = TextureRect.EXPAND_IGNORE_SIZE; _bild.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	_bild.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_bild_rahmen.add_child(_bild); reihe.add_child(_bild_rahmen)
	# Name, Text, Antworten
	var box := VBoxContainer.new(); box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	box.add_theme_constant_override("separation", 6); reihe.add_child(box)
	_name = Stil.label("", 26, Color("#ffc070"))
	_name.add_theme_font_override("font", Stil.schrift(Stil.SCHRIFT_NAME))
	_name.add_theme_color_override("font_outline_color", Color(1, 0.59, 0.24, 0.25)); _name.add_theme_constant_override("outline_size", 6)
	box.add_child(_name)
	_text = DialogueLabel.new()
	_text.bbcode_enabled = true; _text.fit_content = true; _text.scroll_active = false
	_text.custom_minimum_size = Vector2(0, 48); _text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_text.add_theme_font_size_override("normal_font_size", 16); _text.add_theme_font_size_override("italics_font_size", 16)
	_text.add_theme_font_override("italics_font", Stil.kursiv())
	_text.add_theme_color_override("default_color", Color("#f0e6d8"))
	_text.add_theme_constant_override("line_separation", 6)
	_text.seconds_per_step = 1.0 / ZEICHEN_PRO_S; _text.pause_at_characters = ""
	_text.finished_typing.connect(_zeige_antworten)
	box.add_child(_text)
	_optionen = VBoxContainer.new(); _optionen.add_theme_constant_override("separation", 3); box.add_child(_optionen)

# ---------- Dialogue Manager ----------
func start(res: DialogueResource, cue: String = "", extra: Array = []) -> void:
	resource = res; zustaende = extra
	_naechste(cue)

func _naechste(id: String) -> void:
	_sperre = true
	var z: DialogueLine = await DialogueManager.get_next_dialogue_line(resource, id, zustaende)
	_sperre = false
	if not is_instance_valid(self) or not is_inside_tree(): return
	if z == null:
		queue_free(); return
	zeile = z
	_zeige(z.character, z.text)
	_text.dialogue_line = z
	_text.type_out()

## Ein einzelner Spruch ohne Dialogdatei (NPCs mit „sprueche“)
func einzeln(name: String, text: String) -> void:
	_einzeln = true
	# Leere Zeile anlegen und Felder setzen (der Konstruktor erwartet interne Compilerdaten)
	var z := DialogueLine.new()
	z.id = "einzeln"; z.type = DMConstants.TYPE_DIALOGUE
	z.character = name; z.text = text; z.next_id = DMConstants.ID_END
	zeile = z
	_zeige(name, text)
	_text.dialogue_line = z
	_text.type_out()

func _zeige(name: String, text: String) -> void:
	_feld.show()
	for c in _optionen.get_children(): c.queue_free()
	_antworten = []
	var erzaehler := name == ""
	_name.text = name; _name.visible = not erzaehler
	var tex := Portraet.fuer_sprecher(name, get_tree(), Dialog.sprecher)
	_bild.texture = tex
	_bild_rahmen.visible = not erzaehler
	_bild.visible = tex != null
	_text.add_theme_color_override("default_color", Color("#d8c8b0") if erzaehler else Color("#f0e6d8"))
	if zeile: zeile.text = _format(text, erzaehler)

## *Handlung* kursiv und gedämpft wie fmt() im Prototyp; Erzähltext ganz kursiv
func _format(t: String, erzaehler: bool) -> String:
	var r := RegEx.create_from_string("\\*([^*]+)\\*")
	t = r.sub(t, "[i][color=#c8b8a0]$1[/color][/i]", true)
	return "[i]%s[/i]" % t if erzaehler else t

func _zeige_antworten() -> void:
	for c in _optionen.get_children(): c.queue_free()
	_antworten = []
	if zeile == null: return
	for r in zeile.responses:
		if r.is_allowed: _antworten.append(r)
	if _antworten.is_empty():
		var ende := _einzeln or zeile.next_id.begins_with("end") or zeile.next_id == ""
		var w := Stil.label("▼ Ende (Leertaste)" if ende else "▼ Weiter (Leertaste)", 13)
		w.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT; w.modulate.a = 0.6
		_optionen.add_child(w); return
	for i in _antworten.size():
		_optionen.add_child(_antwort_knopf(i, _antworten[i]))

func _antwort_knopf(i: int, r: DialogueResponse) -> Control:
	var b := RichTextLabel.new()
	b.bbcode_enabled = true; b.fit_content = true; b.scroll_active = false
	b.mouse_filter = Control.MOUSE_FILTER_STOP; b.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	b.add_theme_font_size_override("normal_font_size", 15); b.add_theme_font_size_override("italics_font_size", 15)
	b.add_theme_font_override("italics_font", Stil.kursiv())
	b.add_theme_color_override("default_color", Color("#e8dcc8"))
	var leer := StyleBoxFlat.new(); leer.bg_color = Color(0, 0, 0, 0); leer.border_width_left = 2; leer.border_color = Color(0, 0, 0, 0)
	leer.content_margin_left = 10; leer.content_margin_right = 10; leer.content_margin_top = 4; leer.content_margin_bottom = 4
	var hell: StyleBoxFlat = leer.duplicate(); hell.bg_color = Color(1, 0.7, 0.35, 0.1); hell.border_color = Color("#ffb060")
	b.add_theme_stylebox_override("normal", leer)
	b.text = "[color=#9a8a70]%d.[/color] %s" % [i + 1, _antwort_text(r)]
	b.mouse_entered.connect(func(): b.add_theme_stylebox_override("normal", hell); b.add_theme_color_override("default_color", Color.WHITE))
	b.mouse_exited.connect(func(): b.add_theme_stylebox_override("normal", leer); b.add_theme_color_override("default_color", Color("#e8dcc8")))
	b.gui_input.connect(func(e):
		if e is InputEventMouseButton and e.pressed and e.button_index == MOUSE_BUTTON_LEFT:
			get_viewport().set_input_as_handled(); _waehle(i))
	return b

## „(Einsicht 12) Text“ → blauer Probenhinweis wie im Prototyp, mit Figur und Bonus
func _antwort_text(r: DialogueResponse) -> String:
	var t := r.text
	var m := RegEx.create_from_string("^\\(([^()]+?) (\\d+)\\) ").search(t)
	var vor := ""
	if m:
		var fert := m.get_string(1); var sg := m.get_string(2)
		var wer := _probe_figur(r.next_id)
		var zusatz := ""
		if wer != "":
			var bonus: int = GameState.fertigkeiten.get(wer, {}).get(fert, 0)
			zusatz = " · %s %s%d" % [GameState.gruppen_daten().get(wer, {}).get("name", wer), "+" if bonus >= 0 else "−", absi(bonus)]
		vor = "[font_size=13][color=#8ad0ff][%s · SG %s%s][/color][/font_size] " % [fert, sg, zusatz]
		t = t.substr(m.get_end())
	return vor + _format(t, false)

## Wer würfelt? Steht in der Bedingungszeile direkt hinter der Antwort (GameState.probe("corvin", …)).
func _probe_figur(next_id: String) -> String:
	if resource == null: return ""
	# Bedingungszeilen tragen den Ausdruck nur als Tokenliste: "probe", …, "value": "corvin"
	var r := RegEx.create_from_string("\"probe\".*?\"value\": \"(\\w+)\"")
	var id := next_id.get_slice("@", next_id.get_slice_count("@") - 1)    # Laufzeit-IDs tragen „<datei>@“ davor
	for i in 4:     # davor können noch „do …“-Zeilen der Antwort stehen
		if not resource.lines.has(id): break
		var l: Dictionary = resource.lines[id]
		var m := r.search(str(l.get("condition", "")))
		if m: return m.get_string(1)
		id = String(l.get("next_id", "")).get_slice("@", String(l.get("next_id", "")).get_slice_count("@") - 1)
	return ""

# ---------- Eingabe ----------
func _waehle(i: int) -> void:
	if _sperre or i < 0 or i >= _antworten.size(): return
	if _text.is_typing: _text.skip_typing(); return
	var r: DialogueResponse = _antworten[i]
	for c in _optionen.get_children(): c.queue_free()
	_antworten = []
	_naechste(r.next_id)

func _weiter() -> void:
	if _sperre or zeile == null: return
	if _text.is_typing:
		_text.skip_typing(); return
	if not _antworten.is_empty(): return
	if _einzeln:
		queue_free(); Dialog.einzeln_fertig(); return
	_naechste(zeile.next_id)

func _feld_klick(e: InputEvent) -> void:
	if e is InputEventMouseButton and e.pressed and e.button_index == MOUSE_BUTTON_LEFT:
		get_viewport().set_input_as_handled(); _weiter()

func _unhandled_input(e: InputEvent) -> void:
	if not _feld.visible: return
	if e is InputEventKey and e.pressed and not e.echo:
		if e.keycode in [KEY_SPACE, KEY_ENTER, KEY_KP_ENTER]:
			get_viewport().set_input_as_handled(); _weiter()
		elif e.keycode >= KEY_1 and e.keycode <= KEY_9:
			get_viewport().set_input_as_handled(); _waehle(e.keycode - KEY_1)
	# Klicks in die Welt während des Gesprächs nicht an die Figur weiterreichen
	elif e is InputEventMouseButton and e.pressed and e.button_index == MOUSE_BUTTON_LEFT:
		get_viewport().set_input_as_handled(); _weiter()
