extends Node
## Testhilfe (nur aktiv mit Startparametern nach „--“):
##   --shot=<datei.png>   Screenshot nach --warte Sekunden (Standard 2) speichern und beenden
##   --pos=x,z            Gruppe an diese Stelle setzen
##   --yaw=<rad>          Kameradrehung

func _ready() -> void:
	var args := {}
	for a in OS.get_cmdline_user_args():
		var kv := a.trim_prefix("--").split("=", true, 1)
		args[kv[0]] = kv[1] if kv.size() > 1 else ""
	if args.is_empty(): return
	await get_tree().process_frame
	await get_tree().process_frame
	if args.has("pos"):
		var p: PackedStringArray = String(args["pos"]).split(",")
		var i := 0
		for g in get_tree().get_nodes_in_group("gruppe"):
			g.global_position = Vector3(float(p[0]) - 1.2 * i, 0, float(p[1]) + 0.5 * i); i += 1
	if args.has("yaw"):
		var k = get_tree().get_first_node_in_group("kamera")
		if k: k.yaw = float(args["yaw"]); k._yaw_ziel = k.yaw
	if args.has("iso"):
		var k = get_tree().get_first_node_in_group("kamera")
		if k: k.iso = float(args["iso"])
	if args.has("shot"):
		await get_tree().create_timer(float(args.get("warte", "2"))).timeout
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png(String(args["shot"]))
		print("SHOT ", args["shot"])
		get_tree().quit()
