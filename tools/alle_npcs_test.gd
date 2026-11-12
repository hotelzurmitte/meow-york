extends Node
## Test: jede ansprechbare Figur in Hairlem einmal ansprechen und das Gespräch wieder schließen.
## Aufruf: godot --headless --path . res://tools/alle_npcs_test.tscn
func _ready() -> void:
	GameState.set_flag("ueberfall", true); GameState.set_flag("ch1robbed", true); GameState.set_flag("ch1street", true)
	var lvl: Node = load("res://scenes/world/hairlem.tscn").instantiate()
	get_tree().root.add_child.call_deferred(lvl)
	await get_tree().create_timer(1.5).timeout
	var sp = get_tree().get_first_node_in_group("spieler")
	var n := 0
	for npc in get_tree().get_nodes_in_group("npcs"):
		if not npc.ansprechbar: continue
		print("NPC ", npc.name, " (", npc.anzeigename, ")")
		npc.benutzen(sp)
		for i in 20: await get_tree().process_frame
		Dialog.abbrechen()
		await get_tree().process_frame
		n += 1
	print("FERTIG ", n, " Figuren")
	get_tree().quit()
