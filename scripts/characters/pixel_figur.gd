@tool
class_name PixelFigur
extends Node3D
## Darstellung einer Pixel-Figur in der 3D-Welt (ohne Bewegung oder Logik).
## Unterstützt drei Blattarten, alle unverändert aus dem Prototyp bzw. vom Nutzer geliefert:
##   "ren", "dig", "corvin"   – Gruppen-Rigs, 5 Ansichten × 40 Bilder, 8 Richtungen durch Spiegeln
##   "npc:<name>"             – ältere NPC-Blätter (64 × 60), gleicher Aufbau
##   "atlas:<Name>"           – neuer NPC-Atlas, 4 Richtungen (vorne/links/rechts/hinten)
## Pivot ist immer unten mittig: Die Knotenposition ist der Punkt zwischen den Füßen.

@export var figur: String = "atlas:Fuchs":
	set(v):
		figur = v
		if is_inside_tree(): _aufbauen()
## Blickrichtung in der Welt (x, z). (0, 1) schaut zur Standardkamera.
@export var blick: Vector2 = Vector2(0, 1)

## Kamerawerte, von der Spielkamera jedes Bild gesetzt (im Editor feste Werte)
static var kam_yaw := 0.0
static var kam_neigung := 0.5

const RIG_LAYOUT := "res://assets/characters/party/ren/ren_rig_layout.json"
const NPC_LAYOUT := "res://assets/characters/npcs_alt/layout.json"
const ATLAS_JSON := "res://assets/characters/npcs/atlas_npcs.json"
## Blickrichtung (8 Sektoren relativ zur Kamera) → [Ansicht, Spiegeln]
const SECT := [[0, 1], [3, 1], [2, 1], [4, 1], [1, 1], [4, -1], [2, -1], [3, -1]]
const SECT4 := ["vorne", "vorne", "rechts", "hinten", "hinten", "hinten", "links", "vorne"]

static var _json_cache := {}

var spr: Sprite3D
var schatten: MeshInstance3D
var conf := {}
var anim := "idle"
var anim_bild := 0.0          ## fortlaufender Bildzähler (Bruchteile erlaubt)
var umgekippt := false
var _bob := 0.0

static func _json(pfad: String) -> Dictionary:
	if not _json_cache.has(pfad):
		_json_cache[pfad] = JSON.parse_string(FileAccess.get_file_as_string(pfad))
	return _json_cache[pfad]

static func konfig(name: String) -> Dictionary:
	if name in ["ren", "dig", "corvin"]:
		var ren := name == "ren"
		return {"art": "rig", "bild": "res://assets/characters/party/%s/%s_rig.png" % [name, name],
			"zelle": Vector2i(144, 128) if ren else Vector2i(96, 96), "ppm": 41.0 if ren else 29.4,
			"versatz": Vector2(-8, 60) if ren else Vector2(8, 42), "layout": _json(RIG_LAYOUT), "schatten": 1.0}
	if name.begins_with("npc:"):
		return {"art": "rig", "bild": "res://assets/characters/npcs_alt/%s.png" % name.substr(4),
			"zelle": Vector2i(64, 60), "ppm": 16.0, "versatz": Vector2(0, 24), "layout": _json(NPC_LAYOUT), "schatten": 1.0}
	if name.begins_with("atlas:"):
		# Maßstab: Größenverhältnis zu Ren wie im Prototyp (Ren-Referenz 79 px ≙ 113 px / 41 px pro m)
		return {"art": "atlas", "bild": "res://assets/characters/npcs/atlas_npcs.png", "key": name.substr(6),
			"zelle": Vector2i(34, 66), "ppm": 79.0 / (113.0 / 41.0), "versatz": Vector2(0, 33), "schatten": 0.42}
	return {}

func _ready() -> void:
	_aufbauen()

func _aufbauen() -> void:
	for c in get_children():
		if c.has_meta("pixelfigur"): c.queue_free()
	conf = konfig(figur)
	if conf.is_empty(): return
	spr = Sprite3D.new(); spr.set_meta("pixelfigur", true); spr.name = "Sprite"
	spr.texture = load(conf.bild); spr.region_enabled = true
	spr.pixel_size = 1.0 / conf.ppm; spr.offset = conf.versatz
	spr.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	spr.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	spr.shaded = true; spr.double_sided = true
	spr.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	add_child(spr)
	# weicher Bodenschatten
	schatten = MeshInstance3D.new(); schatten.set_meta("pixelfigur", true); schatten.name = "Bodenschatten"
	var q := QuadMesh.new(); q.size = Vector2(1.7, 0.85) * conf.schatten; q.orientation = PlaneMesh.FACE_Y; schatten.mesh = q
	var m := StandardMaterial3D.new(); m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA; m.albedo_color = Color(0, 0, 0, 0.6)
	var g := GradientTexture2D.new(); g.fill = GradientTexture2D.FILL_RADIAL; g.fill_from = Vector2(0.5, 0.5); g.fill_to = Vector2(1, 0.5)
	var gr := Gradient.new(); gr.set_color(0, Color(1, 1, 1, 1)); gr.set_color(1, Color(1, 1, 1, 0)); g.gradient = gr
	m.albedo_texture = g; schatten.material_override = m; schatten.position.y = 0.03
	schatten.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(schatten)
	_aktualisieren()

## Blick setzen (Weltrichtung x/z)
func schaue(dx: float, dz: float) -> void:
	if abs(dx) + abs(dz) < 0.0001: return
	blick = Vector2(dx, dz)

## Animation setzen; bild ist ein fortlaufender Zähler
func zeige(name: String, bild: float) -> void:
	anim = name; anim_bild = bild

func _sektor() -> int:
	var a := atan2(blick.x, blick.y) - kam_yaw
	return (int(round(a / (PI / 4.0))) % 8 + 8) % 8

func _process(dt: float) -> void:
	_bob += dt
	_aktualisieren()

func _aktualisieren() -> void:
	if spr == null or conf.is_empty(): return
	var k := _sektor()
	if conf.art == "atlas":
		var f: Dictionary = _json(ATLAS_JSON).frames.get("%s_%s" % [conf.key, SECT4[k]], {}).get("frame", {"x": 0, "y": 0, "w": 34, "h": 66})
		spr.region_rect = Rect2(f.x, f.y, f.w, f.h); spr.flip_h = false
		# Leerlauf: alle 0,6 s 1 Pixel hoch/runter
		var hoch := 1.0 if (int(_bob / 0.6) % 2 == 1 and anim == "idle") else 0.0
		spr.offset = conf.versatz + Vector2(0, hoch)
	else:
		var s: Array = SECT[k]
		var L: Dictionary = conf.layout
		var A: Array = L.get(anim, L.get("idle"))
		var i := int(floor(anim_bild)) % int(A[1])
		var idx: int = int(A[0]) + i
		var z: Vector2i = conf.zelle
		spr.region_rect = Rect2((idx % 40) * z.x, s[0] * z.y, z.x, z.y)
		spr.flip_h = s[1] < 0
	# zur Kamera drehen und leicht nach hinten neigen (wie im Prototyp)
	spr.rotation = Vector3(-kam_neigung, kam_yaw, PI / 2 * (1 if blick.x < 0 else -1) if umgekippt else 0.0)
