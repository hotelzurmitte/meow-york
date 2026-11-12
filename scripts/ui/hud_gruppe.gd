extends VBoxContainer
## Gruppenkarten unten links (#partyUI im Prototyp): Gesicht 48 px, Name, „Art · Klasse“, LP-Balken.
## Die gesteuerte Figur (Ren) ist golden umrandet.

var _karten := {}

func _ready() -> void:
	anchor_left = 0; anchor_right = 0; anchor_top = 1; anchor_bottom = 1
	grow_vertical = Control.GROW_DIRECTION_BEGIN
	offset_left = 14; offset_right = 234; offset_top = -14; offset_bottom = -14
	add_theme_constant_override("separation", 6)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	for id in GameState.gruppe: _karte(id)
	EventBus.lp_geaendert.connect(_aktualisieren)
	_aktualisieren()

func _karte(id: String) -> void:
	var d: Dictionary = GameState.gruppen_daten().get(id, {})
	if d.is_empty(): return
	var k := PanelContainer.new(); k.custom_minimum_size = Vector2(220, 0)
	k.mouse_filter = Control.MOUSE_FILTER_STOP; k.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var sb := Stil.kasten(Color(10 / 255.0, 10 / 255.0, 18 / 255.0, 0.78), Color("#ffd070") if id == "ren" else Color("#2a2a3a"), 2, 0, Vector4(4, 4, 8, 4))
	sb.shadow_color = Color(1, 0.78, 0.35, 0.3) if id == "ren" else Color(0, 0, 0, 0); sb.shadow_size = 6 if id == "ren" else 0
	k.add_theme_stylebox_override("panel", sb)
	k.tooltip_text = "%s – %s · %s" % [d.name, d.art, d.klasse]
	var h := HBoxContainer.new(); h.add_theme_constant_override("separation", 8); h.mouse_filter = Control.MOUSE_FILTER_IGNORE; k.add_child(h)
	var bildbox := PanelContainer.new(); bildbox.custom_minimum_size = Vector2(48, 48); bildbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	bildbox.add_theme_stylebox_override("panel", Stil.kasten(Color("#16141e"), Color(0, 0, 0, 0), 0, 0, Vector4.ZERO))
	var bild := TextureRect.new(); bild.texture = Portraet.fuer_figur(id); bild.custom_minimum_size = Vector2(48, 48)
	bild.expand_mode = TextureRect.EXPAND_IGNORE_SIZE; bild.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	bild.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST; bild.mouse_filter = Control.MOUSE_FILTER_IGNORE
	bildbox.add_child(bild); h.add_child(bildbox)
	var v := VBoxContainer.new(); v.size_flags_horizontal = Control.SIZE_EXPAND_FILL; v.add_theme_constant_override("separation", 0)
	v.mouse_filter = Control.MOUSE_FILTER_IGNORE; h.add_child(v)
	var n := Stil.label(d.name, 14); n.add_theme_font_override("font", Stil.schrift(Stil.SCHRIFT, 700)); v.add_child(n)
	var s := Stil.label("%s · %s" % [d.art, d.klasse], 10); s.modulate.a = 0.6; v.add_child(s)
	# LP-Balken
	var balken := Control.new(); balken.custom_minimum_size = Vector2(150, 12); balken.mouse_filter = Control.MOUSE_FILTER_IGNORE; v.add_child(balken)
	var rahmen := Panel.new(); rahmen.set_anchors_preset(Control.PRESET_FULL_RECT); rahmen.offset_top = 3; rahmen.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rahmen.add_theme_stylebox_override("panel", Stil.kasten(Color.BLACK, Color("#2a2a36"), 1, 0, Vector4.ZERO))
	balken.add_child(rahmen)
	var fuell := TextureRect.new(); fuell.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var g := GradientTexture2D.new(); g.fill_from = Vector2(0, 0); g.fill_to = Vector2(0, 1); g.width = 4; g.height = 8
	var gr := Gradient.new(); gr.set_color(0, Color("#ff6a5a")); gr.set_color(1, Color("#b02020")); g.gradient = gr
	fuell.texture = g; fuell.expand_mode = TextureRect.EXPAND_IGNORE_SIZE; fuell.stretch_mode = TextureRect.STRETCH_SCALE
	fuell.position = Vector2(1, 4); fuell.size = Vector2(148, 7); balken.add_child(fuell)
	var zahl := Stil.label("", 10); zahl.set_anchors_preset(Control.PRESET_TOP_RIGHT); zahl.grow_horizontal = Control.GROW_DIRECTION_BEGIN
	zahl.offset_right = -3; zahl.offset_top = -5; zahl.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT; balken.add_child(zahl)
	add_child(k)
	_karten[id] = {"fuell": fuell, "zahl": zahl, "balken": balken}

func _aktualisieren() -> void:
	for id in _karten:
		var w: Array = GameState.lp.get(id, [1, 1])
		var e: Dictionary = _karten[id]
		e.fuell.size.x = max(0.0, (e.balken.size.x - 2.0) * float(w[0]) / max(1.0, float(w[1])))
		e.zahl.text = "%d / %d" % [w[0], w[1]]

func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN or what == NOTIFICATION_RESIZED:
		_aktualisieren.call_deferred()
