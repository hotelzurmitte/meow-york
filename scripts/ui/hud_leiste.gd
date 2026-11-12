extends VBoxContainer
## Knopfleiste oben rechts (#panel im Prototyp) samt Tastenkürzeln.
##  Morgen/Tag/Abend/Nacht · Regen
##  Unschärfe · Bloom · Spiegelungen
##  Gruppe (K) · Iso-Kamera (O) · Einstellungen (Esc) · Speichern/Laden (F5/F9) · Questlog (J)
##  Qualität · Leistung (F3) · Ausrüstung (Tab)

const ZEITEN := [["Morgen", "morning"], ["Tag", "day"], ["Abend", "dusk"], ["Nacht", "night"]]
const QUALITAET := [["Hoch", 1.0], ["Mittel", 0.8], ["Niedrig", 0.6]]

var _zeit_knoepfe := {}
var _schalter := {}
var _iso: Button
var _fps: Label
var _q := 0

func _ready() -> void:
	set_anchors_preset(Control.PRESET_TOP_RIGHT)
	grow_horizontal = Control.GROW_DIRECTION_BEGIN
	offset_right = -12; offset_top = 12
	alignment = BoxContainer.ALIGNMENT_BEGIN
	add_theme_constant_override("separation", 5)
	var r1 := _reihe()
	for z in ZEITEN:
		var b := _knopf(r1, z[0], func(): _zeit(z[1]))
		_zeit_knoepfe[z[1]] = b
	_schalter["regen"] = _knopf(r1, "Regen", func(): Einstellungen.umschalten("regen"))
	var r2 := _reihe()
	_schalter["unschaerfe"] = _knopf(r2, "Unschärfe", func(): Einstellungen.umschalten("unschaerfe"))
	_schalter["bloom"] = _knopf(r2, "Bloom", func(): Einstellungen.umschalten("bloom"))
	_schalter["spiegelungen"] = _knopf(r2, "Spiegelungen", func(): Einstellungen.umschalten("spiegelungen"))
	var r3 := _reihe()
	_knopf(r3, "Gruppe (K)", _gruppe)
	_iso = _knopf(r3, "Iso-Kamera (O)", _iso_umschalten)
	_knopf(r3, "Einstellungen (Esc)", func(): _fenster().einstellungen())
	_knopf(r3, "Speichern/Laden (F5/F9)", func(): _fenster().speichern_laden())
	_knopf(r3, "Questlog (J)", func(): _fenster().questlog())
	var r4 := _reihe()
	_knopf(r4, "Qualität", _qualitaet)
	_schalter["fps_anzeigen"] = _knopf(r4, "Leistung (F3)", func(): Einstellungen.umschalten("fps_anzeigen"))
	_knopf(r4, "Ausrüstung (Tab)", _ausruestung)
	_fps = Stil.label("", 12, Color("#c8f0c8")); _fps.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT; add_child(_fps)
	EventBus.einstellung_geaendert.connect(func(_n): _anzeigen())
	_anzeigen.call_deferred()

func _reihe() -> HBoxContainer:
	var r := HBoxContainer.new(); r.alignment = BoxContainer.ALIGNMENT_END; r.add_theme_constant_override("separation", 4)
	add_child(r); return r

func _knopf(r: HBoxContainer, text: String, aktion: Callable) -> Button:
	var b := Button.new(); b.text = text; b.toggle_mode = true; b.focus_mode = Control.FOCUS_NONE
	b.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	b.pressed.connect(func(): aktion.call(); _anzeigen())
	r.add_child(b); return b

func _stimmung() -> Node:
	return get_tree().get_first_node_in_group("stimmung")

func _kamera() -> Node:
	return get_tree().get_first_node_in_group("kamera")

func _fenster() -> Node:
	return get_parent().get_node("Fenster")

func _zeit(name: String) -> void:
	var s := _stimmung()
	if s: s.setze(name, 1.2)

func _anzeigen() -> void:
	var s := _stimmung()
	for k in _zeit_knoepfe: _zeit_knoepfe[k].set_pressed_no_signal(s != null and s.voreinstellung == k)
	for k in _schalter: _schalter[k].set_pressed_no_signal(Einstellungen.an(k))
	var kam := _kamera()
	_iso.set_pressed_no_signal(kam != null and kam.iso > 0.5)
	_fps.visible = Einstellungen.an("fps_anzeigen")

func _iso_umschalten() -> void:
	var kam := _kamera()
	if kam == null: return
	kam.iso = 0.0 if kam.iso > 0.5 else 1.0
	EventBus.meldung.emit("Kamera: isometrisch (O)" if kam.iso > 0.5 else "Kamera: nah (O)")

func _qualitaet() -> void:
	_q = (_q + 1) % QUALITAET.size()
	get_viewport().scaling_3d_scale = QUALITAET[_q][1]
	EventBus.hinweis.emit("Qualität: " + QUALITAET[_q][0], "info")

func _gruppe() -> void:
	EventBus.hinweis.emit("Charakterbogen (K) wird mit dem Kampfsystem übertragen", "info")

func _ausruestung() -> void:
	EventBus.hinweis.emit("Ausrüstung (Tab) wird mit dem Kampfsystem übertragen", "info")

func _process(_dt: float) -> void:
	if _fps.visible:
		_fps.text = "%d FPS · %d Draw Calls" % [Engine.get_frames_per_second(), RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_DRAW_CALLS_IN_FRAME)]
	# Zeit-Knöpfe folgen auch Wechseln durch die Geschichte (z. B. Abend beim Verlassen der Gasse)
	var s := _stimmung()
	if s and _zeit_knoepfe.has(s.voreinstellung) and not _zeit_knoepfe[s.voreinstellung].button_pressed: _anzeigen()

func _unhandled_input(e: InputEvent) -> void:
	if not (e is InputEventKey and e.pressed and not e.echo) or Dialog.aktiv or not visible: return
	match e.keycode:
		KEY_O: _iso_umschalten(); _anzeigen()
		KEY_J: _fenster().questlog()
		KEY_F3: Einstellungen.umschalten("fps_anzeigen")
		KEY_F5: Spielstand.speichern(0, get_tree().current_scene.scene_file_path)
		KEY_F9: Spielstand.laden(0, get_tree())
		KEY_ESCAPE: _fenster().einstellungen()
		KEY_K: _gruppe()
		KEY_TAB: _ausruestung()
		_: return
	get_viewport().set_input_as_handled()
