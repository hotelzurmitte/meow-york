extends Node
## Baut scenes/world/fahrt.tscn (Kapitel 1 · Szene 1) aus dem Prototyp-Export.
## Aufruf: godot --headless --path . res://tools/build_fahrt.tscn
const ZIEL := "res://scenes/world/fahrt.tscn"
var wurzel: Node3D

func _add(p: Node, n: Node, name_: String) -> Node:
	n.name = name_.validate_node_name(); p.add_child(n); return n

func _own(n: Node) -> void:
	if n != wurzel: n.owner = wurzel
	if n.scene_file_path != "" and n != wurzel: return
	for c in n.get_children(): _own(c)

func _ready() -> void:
	var teile: Array = JSON.parse_string(FileAccess.get_file_as_string("res://data/levels/fahrt.json"))
	wurzel = Node3D.new(); wurzel.name = "Fahrt"; wurzel.set_script(load("res://scripts/story/fahrt.gd"))
	var env := WorldEnvironment.new(); var e := Environment.new(); e.background_mode = Environment.BG_COLOR
	e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR; e.fog_enabled = true; e.tonemap_mode = Environment.TONE_MAPPER_FILMIC; e.glow_enabled = true
	env.environment = e; env.set_script(load("res://scripts/world/stimmung.gd")); env.set("voreinstellung", "day"); _add(wurzel, env, "Stimmung")
	var sonne := DirectionalLight3D.new(); sonne.shadow_enabled = true; sonne.directional_shadow_max_distance = 80.0; _add(wurzel, sonne, "Sonne")
	var ku := _add(wurzel, Node3D.new(), "Kulissen")
	for t in teile:
		var inst: Node3D = (load("res://assets/world/fahrt/teile/%s.glb" % t.name) as PackedScene).instantiate()
		_add(ku, inst, t.name); inst.set_meta("basis_x", t.pos[0] + 1100.0)   # Position steckt bereits im Modell; 1100 = Lage der Fahrt im Prototyp
		if t.span > 0: inst.set_meta("span", t.span); inst.set_meta("k", t.k)
		if t.stueck: inst.set_meta("stueck", true); inst.set_meta("start_x", t.pos[0] + 1100.0)
	var fokus := Marker3D.new(); fokus.position = Vector3(3, 0, 3.4); _add(wurzel, fokus, "Fokus")
	var kr := _add(wurzel, Node3D.new(), "Kamerasystem"); kr.set_script(load("res://scripts/world/kamera.gd")); kr.add_to_group("kamera", true)
	kr.set("ziel_pfad", NodePath("../Fokus")); kr.set("zoom", 1.4); kr.set("steuerbar", false)
	var cam := Camera3D.new(); cam.current = true; cam.far = 600; _add(kr, cam, "Kamera")
	_add(cam, PhantomCameraHost.new(), "PhantomCameraHost")
	var pc := PhantomCamera3D.new(); pc.priority = 10; var cr := Camera3DResource.new(); cr.fov = 30; cr.far = 600; pc.camera_3d_resource = cr; _add(kr, pc, "SpielKamera")
	var hud := CanvasLayer.new(); hud.set_script(load("res://scripts/ui/hud.gd")); _add(wurzel, hud, "HUD")
	_own(wurzel)
	var ps := PackedScene.new(); print("pack ", ps.pack(wurzel), " save ", ResourceSaver.save(ps, ZIEL)); get_tree().quit()
