extends SceneTree
# Baut die Probe-Szene als echte Knoten und speichert sie, damit sie im Editor sichtbar und bearbeitbar ist.
# Aufruf: godot --headless --path . --script res://tools/build_probe.gd

func _own(n: Node, root: Node) -> void:
	n.owner = root
	for c in n.get_children(): _own(c, root)

func _init():
	var root := Node3D.new(); root.name = "Probe"
	root.set_script(load("res://scripts/tests/probe.gd"))
	var env := WorldEnvironment.new(); env.name = "Umgebung"; var e := Environment.new()
	e.background_mode = Environment.BG_COLOR; e.background_color = Color(0.12,0.12,0.16)
	e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR; e.ambient_light_color = Color(0.5,0.5,0.6); env.environment = e; root.add_child(env)
	var sun := DirectionalLight3D.new(); sun.name = "Sonne"; sun.rotation_degrees = Vector3(-50, 30, 0); sun.shadow_enabled = true; root.add_child(sun)
	var ground := MeshInstance3D.new(); ground.name = "Boden"; var pm := PlaneMesh.new(); pm.size = Vector2(20,20); ground.mesh = pm
	var gm := StandardMaterial3D.new(); gm.albedo_color = Color(0.35,0.33,0.38); ground.material_override = gm; root.add_child(ground)
	var house := MeshInstance3D.new(); house.name = "Haus"; var bm := BoxMesh.new(); bm.size = Vector3(4,5,3); house.mesh = bm; house.position = Vector3(-1,2.5,-3)
	var hm := StandardMaterial3D.new(); hm.albedo_color = Color(0.55,0.25,0.2); house.material_override = hm; root.add_child(house)
	var tex: Texture2D = load("res://assets/characters/npcs/atlas_npcs.png")
	var figs := [["Fuchs",19],["Schimpanse",18],["Otter",12],["Panther",15]]
	for i in figs.size():
		var s := Sprite3D.new(); s.name = figs[i][0]; s.texture = tex; s.region_enabled = true
		s.region_rect = Rect2(0, figs[i][1]*66, 34, 66)
		s.pixel_size = 1.0/28.66; s.offset = Vector2(0, 33)
		s.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST; s.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
		s.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
		s.position = Vector3(-2.5 + i*1.6, 0, (i%2)*0.8 - 1.2 + (2.0 if i==3 else 0.0)); root.add_child(s)
	var cam := Camera3D.new(); cam.name = "Kamera"; cam.position = Vector3(8, 9, 8); root.add_child(cam)
	cam.transform = cam.transform.looking_at(Vector3(0,1,0)); cam.fov = 40; cam.current = true
	_own(root, root); for c in root.get_children(): c.owner = root
	var ps := PackedScene.new(); var err := ps.pack(root)
	print("pack ", err, " save ", ResourceSaver.save(ps, "res://scenes/tests/probe.tscn"))
	quit()
