extends Node3D
## Level-Wurzel. Stellt die Gruppe an den Spawnpunkt, der beim Levelwechsel gewählt wurde.
## Spawnpunkte sind Marker3D-Knoten unter „Spawnpunkte“.

@export var standard_spawn := "Strasse"
@export var bereichsname := ""

func _ready() -> void:
	var name_ := GameState.naechster_spawn if GameState.naechster_spawn != "" else standard_spawn
	GameState.naechster_spawn = ""
	var m := get_node_or_null("Spawnpunkte/" + name_) as Node3D
	var p = m.global_position if m else null
	# Spielstand geladen: genau dort weitermachen, wo gespeichert wurde
	if GameState.lade_position is Array and GameState.lade_position.size() == 3:
		var a: Array = GameState.lade_position
		p = Vector3(a[0], a[1], a[2])
	GameState.lade_position = null
	if p != null:
		var i := 0
		for g in get_tree().get_nodes_in_group("gruppe"):
			g.global_position = p + Vector3(-1.3 * i, 0, 0.5 * i)
			i += 1
	if bereichsname != "" and not (GameState.flag("ueberfall") and not GameState.flag("ch1robbed")):
		EventBus.meldung.emit(bereichsname)
