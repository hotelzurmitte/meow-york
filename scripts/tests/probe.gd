extends Node3D
# Probe: 3D-Boden + Haus + Pixel-Sprite (Atlas-Frame) mit orthografischer Kamera, Screenshot speichern
func _ready():
	var env := WorldEnvironment.new(); var e := Environment.new(); e.background_mode = Environment.BG_COLOR; e.background_color = Color(0.12,0.12,0.16)
	e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR; e.ambient_light_color = Color(0.5,0.5,0.6); env.environment = e; add_child(env)
	var sun := DirectionalLight3D.new(); sun.rotation_degrees = Vector3(-50, 30, 0); sun.shadow_enabled = true; add_child(sun)
	var ground := MeshInstance3D.new(); var pm := PlaneMesh.new(); pm.size = Vector2(20,20); ground.mesh = pm
	var gm := StandardMaterial3D.new(); gm.albedo_color = Color(0.35,0.33,0.38); ground.material_override = gm; add_child(ground)
	var house := MeshInstance3D.new(); var bm := BoxMesh.new(); bm.size = Vector3(4,5,3); house.mesh = bm; house.position = Vector3(-1,2.5,-3)
	var hm := StandardMaterial3D.new(); hm.albedo_color = Color(0.55,0.25,0.2); house.material_override = hm; add_child(house)
	var tex: Texture2D = load("res://assets/characters/npcs/atlas_npcs.png")
	var keys := ["Fuchs","Schimpanse","Otter","Panther"]
	var rows := {"Otter":12,"Panther":15,"Schimpanse":18,"Fuchs":19}
	for i in keys.size():
		var s := Sprite3D.new(); s.texture = tex; s.region_enabled = true
		s.region_rect = Rect2(0, rows[keys[i]]*66, 34, 66)
		s.pixel_size = 1.0/28.66; s.centered = true; s.offset = Vector2(0, 33)   # Pivot unten mittig
		s.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST; s.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
		s.shaded = true; s.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y; s.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
		s.position = Vector3(-2.5 + i*1.6, 0, (i%2)*0.8 - 1.2 + (2.0 if i==3 else 0.0)); add_child(s)
	var cam := Camera3D.new(); cam.projection = Camera3D.PROJECTION_ORTHOGONAL; cam.size = 10
	cam.position = Vector3(8, 9, 8); add_child(cam); cam.look_at(Vector3(0,1,0)); cam.current = true
	fox = get_child(get_child_count()-2) if false else null
	for c in get_children():
		if c is Sprite3D and c.region_rect.position.y == 19*66: fox = c
	var lbl := Label.new(); lbl.text = "Godot-Probe · WASD: Fuchs laufen lassen"; lbl.position = Vector2(12,10); add_child(lbl)
	if "--shot" in OS.get_cmdline_user_args():
		for f in 5: await get_tree().process_frame
		await RenderingServer.frame_post_draw
		var img := get_viewport().get_texture().get_image(); img.save_png("user://probe.png"); print("SHOT OK ", img.get_size()); get_tree().quit()

var fox: Sprite3D
const DIRS := {"vorne":0,"links":1,"rechts":2,"hinten":3}
func _process(dt):
	if fox == null: return
	var v := Vector2(Input.get_axis("ui_left","ui_right"), Input.get_axis("ui_up","ui_down"))
	if Input.is_key_pressed(KEY_A): v.x -= 1
	if Input.is_key_pressed(KEY_D): v.x += 1
	if Input.is_key_pressed(KEY_W): v.y -= 1
	if Input.is_key_pressed(KEY_S): v.y += 1
	if v.length() < 0.1: return
	v = v.normalized()
	# Bildschirmrichtung → Welt (Kamera schaut diagonal): rechts = (+x,-z)/√2, unten = (+x,+z)/√2
	var w := Vector3(v.x + v.y, 0, -v.x + v.y).normalized()
	fox.position += w * 3.0 * dt
	var d := "rechts" if v.x > 0.5 else ("links" if v.x < -0.5 else ("hinten" if v.y < 0 else "vorne"))
	fox.region_rect.position.x = DIRS[d] * 34
