extends Node
## Setzt Hairlem aus dem Prototyp-Export zusammen und speichert scenes/world/hairlem.tscn.
## Alles Erzeugte liegt unter „Generiert“. „Handgebaut“ bleibt beim Neubau erhalten.
## Aufruf: godot --headless --path . res://tools/build_hairlem.tscn

const ZIEL := "res://scenes/world/hairlem.tscn"
const TEILE := "res://assets/world/hairlem/teile/"
const SPRITES := "res://assets/world/hairlem/sprites/"
var wurzel: Node3D

func _own(n: Node) -> void:
	if n != wurzel: n.owner = wurzel
	if n.scene_file_path != "" and n != wurzel: return    # Inhalte instanzierter Szenen nicht übernehmen
	for c in n.get_children(): _own(c)

func _add(parent: Node, n: Node, name_: String) -> Node:
	n.name = name_.validate_node_name(); parent.add_child(n); return n

func _farbe(h: String) -> Color: return Color(h)

func _ready() -> void:
	var bereich: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/levels/hairlem/bereich.json"))
	var welt: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/levels/welt_prototyp.json"))
	var pre: Dictionary = welt.presets["dusk"]
	# Bestehende Szene laden, damit „Handgebaut“ erhalten bleibt
	var alt_hand: Node = null
	if ResourceLoader.exists(ZIEL):
		var alt := (load(ZIEL) as PackedScene).instantiate()
		alt_hand = alt.get_node_or_null("Handgebaut")
		if alt_hand: alt.remove_child(alt_hand)
	wurzel = Node3D.new(); wurzel.name = "Hairlem"; wurzel.set_script(load("res://scripts/world/level.gd"))
	wurzel.set("standard_spawn", "Strasse"); wurzel.set("bereichsname", "Hairlem · Whisker Avenue")

	# ---------- Licht und Stimmung (Prototyp-Voreinstellung „Abend“) ----------
	var env := WorldEnvironment.new(); var e := Environment.new()
	e.background_mode = Environment.BG_COLOR; e.background_color = _farbe(pre.sky).darkened(0.35)
	e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR; e.ambient_light_color = _farbe(pre.sky).lerp(_farbe(pre.gnd), 0.35); e.ambient_light_energy = pre.hemiI
	e.fog_enabled = true; e.fog_light_color = _farbe(pre.fog); e.fog_density = pre.fogD * 0.6
	e.tonemap_mode = Environment.TONE_MAPPER_FILMIC; e.tonemap_exposure = pre.exp
	e.glow_enabled = true; e.glow_intensity = pre.bloom; e.glow_bloom = 0.05; e.glow_hdr_threshold = 0.9
	env.environment = e; _add(wurzel, env, "Umgebung")
	var sonne := DirectionalLight3D.new(); sonne.light_color = _farbe(pre.sun); sonne.light_energy = pre.sunI * 0.35
	sonne.shadow_enabled = true; sonne.directional_shadow_max_distance = 80.0
	_add(wurzel, sonne, "Sonne")
	var d: Array = pre.dir; sonne.look_at_from_position(Vector3(d[0], d[1], d[2]) * 50.0, Vector3.ZERO, Vector3.UP)

	var gen := _add(wurzel, Node3D.new(), "Generiert")
	# ---------- Bauteile (je eine GLB-Datei) ----------
	var teile := _add(gen, Node3D.new(), "Bauteile")
	for g in bereich.gruppen:
		var ps: PackedScene = load(TEILE + g.datei)
		if ps == null: print("fehlt ", g.datei); continue
		var inst := ps.instantiate()
		_add(teile, inst, g.name)
		inst.position = Vector3(g.anker[0], g.anker[1], g.anker[2])
	# ---------- Sprites (Bäume, Hydranten, Müllsäcke …) ----------
	var sp := _add(gen, Node3D.new(), "Sprites")
	var i := 0
	for s in bereich.sprites:
		if s.png == null: continue
		var tex: Texture2D = load(SPRITES + s.png)
		var spr := Sprite3D.new(); spr.texture = tex
		var px: float = s.breite / tex.get_width()
		spr.pixel_size = px; spr.offset = Vector2(0, tex.get_height() / 2.0 + s.unten / px)
		spr.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST; spr.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
		spr.shaded = true; spr.double_sided = true
		spr.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON if s.schatten else GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		spr.position = Vector3(s.pos[0], s.pos[1], s.pos[2]); spr.add_to_group("billboard", true)
		_add(sp, spr, "Sprite_%03d" % i); i += 1
	# ---------- Lichter ----------
	var li := _add(gen, Node3D.new(), "Lichter")
	i = 0
	for l in bereich.lichter:
		var o: Light3D = OmniLight3D.new() if l.typ == "punkt" else SpotLight3D.new()
		o.light_color = _farbe(l.farbe); o.light_energy = l.staerke / 14.0
		if o is OmniLight3D:
			o.omni_range = l.reichweite if l.reichweite > 0 else 12.0; o.omni_attenuation = 1.4
		o.position = Vector3(l.pos[0], l.pos[1], l.pos[2])
		_add(li, o, "Licht_%02d" % i); i += 1
	# ---------- Kollision (wie im Prototyp: Rechtecke und Kreise am Boden) ----------
	var ko := _add(gen, StaticBody3D.new(), "Kollision")
	var B: Dictionary = welt.areas.street
	i = 0
	for b in welt.aabb:
		if b.area != "street": continue
		var cs := CollisionShape3D.new(); var bs := BoxShape3D.new(); bs.size = Vector3(b.x1 - b.x0, 4, b.z1 - b.z0); cs.shape = bs
		cs.position = Vector3((b.x0 + b.x1) / 2.0, 2, (b.z0 + b.z1) / 2.0); _add(ko, cs, "Box_%03d" % i); i += 1
	for c in welt.circ:
		if c.area != "street": continue
		var cs := CollisionShape3D.new(); var cy := CylinderShape3D.new(); cy.radius = c.r; cy.height = 4; cs.shape = cy
		cs.position = Vector3(c.x, 2, c.z); _add(ko, cs, "Rund_%03d" % i); i += 1
	# Bereichsgrenzen
	for w in [[B.x0 - 0.5, (B.z0 + B.z1) / 2.0, 1.0, B.z1 - B.z0], [B.x1 + 0.5, (B.z0 + B.z1) / 2.0, 1.0, B.z1 - B.z0],
			[(B.x0 + B.x1) / 2.0, B.z0 - 0.5, B.x1 - B.x0, 1.0], [(B.x0 + B.x1) / 2.0, B.z1 + 0.5, B.x1 - B.x0, 1.0]]:
		var cs := CollisionShape3D.new(); var bs := BoxShape3D.new(); bs.size = Vector3(w[2], 4, w[3]); cs.shape = bs
		cs.position = Vector3(w[0], 2, w[1]); _add(ko, cs, "Rand_%03d" % i); i += 1
	# ---------- Türen und Übergänge ----------
	var tu := _add(gen, Node3D.new(), "Tueren")
	i = 0
	for t in welt.doors:
		if t.area != "street": continue
		var n := Node3D.new(); n.set_script(load("res://scripts/world/tuer.gd"))
		n.set("beschriftung", String(t.label).replace("E – ", ""))
		n.set("meldung", "(Dieser Übergang wird gerade nach Godot übertragen.)")
		n.position = Vector3(t.x, 0, t.z); _add(tu, n, "Tuer_%02d" % i); i += 1
	# ---------- Figuren aus dem Prototyp ----------
	var fi := _add(gen, Node3D.new(), "Figuren")
	var alt_npcs := DirAccess.get_files_at("res://assets/characters/npcs_alt/")
	i = 0
	for n in welt.npcs:
		if n.area != "street" or not n.sichtbar: continue
		var npc := Node3D.new(); npc.set_script(load("res://scripts/characters/npc.gd"))
		var fig := ""
		if n.atlas: fig = "atlas:" + n.atlas
		elif n.sheet: fig = "npc:" + n.sheet
		elif n.key and (n.key + ".png") in alt_npcs: fig = "npc:" + n.key
		elif n.key == "antonia": fig = "npc:ant"
		else: fig = "atlas:Fuchs"
		npc.set("anzeigename", n.name); npc.set("figur", fig); npc.set("blick", Vector2(n.fx, n.fz))
		npc.position = Vector3(n.x, n.y, n.z)
		_add(fi, npc, ("%s" % (n.key if n.key else n.name)).replace(" ", "_"))
		i += 1
	# ---------- Spawnpunkte ----------
	var spn := _add(wurzel, Node3D.new(), "Spawnpunkte")
	for s in [["Strasse", Vector3(33, 0, 5)], ["Gasse", Vector3(43.4, 0, 6.4)], ["Bar", Vector3(13.3, 0, -2.1)]]:
		var m := Marker3D.new(); m.position = s[1]; _add(spn, m, s[0])
	# ---------- Gruppe ----------
	var gr := _add(wurzel, Node3D.new(), "Gruppe")
	var prev := ""
	for w in [["Ren", "ren"], ["BigDig", "dig"], ["Corvin", "corvin"]]:
		var p := CharacterBody3D.new(); p.set_script(load("res://scripts/characters/spieler.gd"))
		var cs := CollisionShape3D.new(); var cy := CylinderShape3D.new(); cy.radius = 0.3; cy.height = 1.0; cs.shape = cy; cs.position.y = 0.5
		p.add_child(cs); cs.name = "Kollision"
		var f := PixelFigur.new(); f.name = "Figur"; f.figur = w[1]; p.add_child(f)
		p.set("anfuehrer", w[1] == "ren")
		if prev != "": p.set("folgt", NodePath("../" + prev))
		p.position = Vector3(33, 0, 5); _add(gr, p, w[0]); prev = w[0]
	# ---------- Kamera ----------
	var kr := _add(wurzel, Node3D.new(), "Kamerasystem"); kr.set_script(load("res://scripts/world/kamera.gd")); kr.add_to_group("kamera", true)
	kr.set("ziel_pfad", NodePath("../Gruppe/Ren"))
	var cam := Camera3D.new(); cam.current = true; cam.fov = 30; cam.far = 400; _add(kr, cam, "Kamera")
	var host := PhantomCameraHost.new(); _add(cam, host, "PhantomCameraHost")
	var pc := PhantomCamera3D.new(); pc.priority = 10; var cr := Camera3DResource.new(); cr.fov = 30; cr.far = 400; pc.camera_3d_resource = cr
	_add(kr, pc, "SpielKamera")
	# ---------- Oberfläche ----------
	var hud := CanvasLayer.new(); hud.set_script(load("res://scripts/ui/hud.gd")); _add(wurzel, hud, "HUD")
	# ---------- Handgebaut (gehört dem Nutzer) ----------
	if alt_hand: wurzel.add_child(alt_hand)
	else: _add(wurzel, Node3D.new(), "Handgebaut")
	_own(wurzel)
	if alt_hand: _own_hand(alt_hand)
	var ps := PackedScene.new(); var err := ps.pack(wurzel)
	print("pack ", err, " save ", ResourceSaver.save(ps, ZIEL))
	get_tree().quit()

func _own_hand(n: Node) -> void:
	n.owner = wurzel
	if n.scene_file_path != "" and n != wurzel: return
	for c in n.get_children(): _own_hand(c)
