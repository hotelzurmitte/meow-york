extends Node3D
## Level-Wurzel. Stellt die Gruppe an den Spawnpunkt, der beim Levelwechsel gewählt wurde.
## Spawnpunkte sind Marker3D-Knoten unter „Spawnpunkte“.

@export var standard_spawn := "Strasse"
@export var bereichsname := ""

func _ready() -> void:
	var name_ := GameState.naechster_spawn if GameState.naechster_spawn != "" else standard_spawn
	GameState.naechster_spawn = ""
	var m := get_node_or_null("Spawnpunkte/" + name_) as Node3D
	if m:
		var i := 0
		for g in get_tree().get_nodes_in_group("gruppe"):
			g.global_position = m.global_position + Vector3(-1.3 * i, 0, 0.5 * i)
			i += 1
	if bereichsname != "":
		EventBus.meldung.emit(bereichsname)
