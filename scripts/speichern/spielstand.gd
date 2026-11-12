class_name Spielstand
extends RefCounted
## Spielstände als JSON in user://spielstand_<platz>.json (versioniert über GameState.VERSION).

static func pfad(platz: int) -> String:
	return "user://spielstand_%d.json" % platz

static func speichern(platz: int, szene: String) -> void:
	var d := GameState.als_dict()
	d["szene"] = szene
	d["zeit"] = Time.get_datetime_string_from_system(false, true)
	var sp := (Engine.get_main_loop() as SceneTree).get_first_node_in_group("spieler") as Node3D
	if sp: d["pos"] = [sp.global_position.x, sp.global_position.y, sp.global_position.z]
	var f := FileAccess.open(pfad(platz), FileAccess.WRITE)
	if f: f.store_string(JSON.stringify(d, "\t"))
	EventBus.hinweis.emit("Gespeichert (Platz %d)" % platz, "gut")

static func vorhanden(platz: int) -> bool:
	return FileAccess.file_exists(pfad(platz))

static func info(platz: int) -> Dictionary:
	if not vorhanden(platz): return {}
	var d = JSON.parse_string(FileAccess.get_file_as_string(pfad(platz)))
	return d if d is Dictionary else {}

static func laden(platz: int, baum: SceneTree) -> void:
	var d := info(platz)
	if d.is_empty():
		EventBus.hinweis.emit("Kein Spielstand auf Platz %d" % platz, "schlecht"); return
	GameState.aus_dict(d)
	GameState.naechster_spawn = ""
	GameState.lade_position = d.get("pos", null)
	var szene: String = d.get("szene", "res://scenes/world/hairlem.tscn")
	baum.change_scene_to_file(szene)
