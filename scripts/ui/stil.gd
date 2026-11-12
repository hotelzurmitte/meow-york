class_name Stil
extends RefCounted
## Gemeinsamer Look der Oberfläche, übernommen aus dem Prototyp (shell.html):
## Pixelify Sans, dunkle halbtransparente Kästen, pinke Rahmen, goldene Namen.

const SCHRIFT := "res://assets/fonts/PixelifySans.ttf"
const SCHRIFT_NAME := "res://assets/fonts/Yellowtail.ttf"
const SCHRIFT_TITEL := "res://assets/fonts/Monoton.ttf"

const TEXT := Color("#ece4d4")
const PINK := Color("#ff6ad8")
const PINK_HELL := Color("#ffc8f0")
const GOLD := Color("#ffe08a")
const BLAU := Color("#8ad0ff")
const ROT := Color("#ff7a6a")
const GRUEN := Color("#9aff9a")

static var _theme: Theme
static var _fonts := {}

static func schrift(pfad := SCHRIFT, gewicht := 400) -> Font:
	var k := "%s#%d" % [pfad, gewicht]
	if not _fonts.has(k):
		var basis: FontFile = load(pfad)
		if gewicht == 400:
			_fonts[k] = basis
		else:
			var v := FontVariation.new(); v.base_font = basis
			v.variation_opentype = {TextServerManager.get_primary_interface().name_to_tag("wght"): gewicht}
			_fonts[k] = v
	return _fonts[k]

## Kursiv: Pixelify Sans hat keinen Kursivschnitt, daher leicht geneigt (wie der Browser im Prototyp)
static func kursiv() -> Font:
	if not _fonts.has("kursiv"):
		var v := FontVariation.new(); v.base_font = load(SCHRIFT)
		v.variation_transform = Transform2D(Vector2(1, 0), Vector2(0.22, 1), Vector2.ZERO)
		_fonts["kursiv"] = v
	return _fonts["kursiv"]

static func kasten(bg: Color, rand: Color, breite := 1, radius := 2, innen := Vector4(9, 5, 9, 5)) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = bg; s.border_color = rand; s.set_border_width_all(breite)
	s.set_corner_radius_all(radius)
	s.content_margin_left = innen.x; s.content_margin_top = innen.y; s.content_margin_right = innen.z; s.content_margin_bottom = innen.w
	return s

static func theme() -> Theme:
	if _theme: return _theme
	var t := Theme.new()
	t.default_font = schrift()
	t.default_font_size = 14
	t.set_color("font_color", "Label", TEXT)
	t.set_color("font_outline_color", "Label", Color(0, 0, 0, 0.85))
	t.set_constant("outline_size", "Label", 4)
	t.set_color("default_color", "RichTextLabel", TEXT)
	# Knöpfe wie im Prototyp (button / button.on / button:hover)
	t.set_font_size("font_size", "Button", 13)
	for f in ["font_color", "font_focus_color"]: t.set_color(f, "Button", Color("#e8e0d0"))
	for f in ["font_hover_color", "font_pressed_color", "font_hover_pressed_color"]: t.set_color(f, "Button", Color.WHITE)
	t.set_stylebox("normal", "Button", kasten(Color(12 / 255.0, 12 / 255.0, 20 / 255.0, 0.7), Color(1, 90 / 255.0, 210 / 255.0, 0.35)))
	t.set_stylebox("hover", "Button", kasten(Color(12 / 255.0, 12 / 255.0, 20 / 255.0, 0.7), Color("#ff9ae6")))
	var an := kasten(Color(120 / 255.0, 30 / 255.0, 100 / 255.0, 0.55), PINK)
	t.set_stylebox("pressed", "Button", an); t.set_stylebox("hover_pressed", "Button", an)
	t.set_stylebox("focus", "Button", StyleBoxEmpty.new())
	t.set_stylebox("disabled", "Button", kasten(Color(12 / 255.0, 12 / 255.0, 20 / 255.0, 0.5), Color(1, 1, 1, 0.12)))
	t.set_stylebox("panel", "PanelContainer", kasten(Color(14 / 255.0, 12 / 255.0, 22 / 255.0, 0.97), Color("#3a3050"), 2, 0, Vector4(26, 22, 26, 22)))
	_theme = t
	return t

## Label mit Umriss (Text wie im Prototyp mit text-shadow)
static func label(text := "", groesse := 14, farbe := TEXT) -> Label:
	var l := Label.new(); l.text = text
	l.add_theme_font_size_override("font_size", groesse)
	l.add_theme_color_override("font_color", farbe)
	l.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return l
