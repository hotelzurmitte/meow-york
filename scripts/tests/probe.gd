extends Node3D
# Probe-Szene: Alle Objekte liegen als Knoten in probe.tscn (im Editor sichtbar).
# Dieses Skript lässt nur den Fuchs mit WASD laufen und macht auf Wunsch einen Screenshot.

const DIRS := {"vorne": 0, "links": 1, "rechts": 2, "hinten": 3}
@onready var fox: Sprite3D = $Fuchs
@onready var cam: Camera3D = $Kamera

func _ready():
	var lbl := Label.new(); lbl.text = "Godot-Probe · WASD: Fuchs laufen lassen"; lbl.position = Vector2(12, 10); add_child(lbl)
	if "--shot" in OS.get_cmdline_user_args():
		for f in 5: await get_tree().process_frame
		await RenderingServer.frame_post_draw
		var img := get_viewport().get_texture().get_image(); img.save_png("user://probe.png"); print("SHOT OK ", img.get_size()); get_tree().quit()

func _process(dt):
	var v := Vector2.ZERO
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT): v.x -= 1
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT): v.x += 1
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP): v.y -= 1
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN): v.y += 1
	if v.length() < 0.1: return
	v = v.normalized()
	# Bildschirmrichtung in Weltrichtung umrechnen (Kamera schaut schräg von oben)
	var right := cam.global_basis.x; right.y = 0; right = right.normalized()
	var fwd := -cam.global_basis.z; fwd.y = 0; fwd = fwd.normalized()
	fox.position += (right * v.x - fwd * v.y) * 3.0 * dt
	var d := "rechts" if v.x > 0.5 else ("links" if v.x < -0.5 else ("hinten" if v.y < 0 else "vorne"))
	fox.region_rect.position.x = DIRS[d] * 34
