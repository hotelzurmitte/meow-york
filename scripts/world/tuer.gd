@tool
extends Node3D
## Übergang oder benutzbarer Punkt (Tür, Gullydeckel, Leiter …).
## Mit `ziel_szene` wechselt sie das Level, sonst zeigt sie `meldung`.

@export var beschriftung := "Tür"
@export_file("*.tscn") var ziel_szene := ""
@export var ziel_spawn := ""
@export_multiline var meldung := ""

func _ready() -> void:
	if Engine.is_editor_hint(): return
	add_to_group("interaktiv")

var hinweis: String:
	get: return beschriftung

func benutzen(_wer: Node3D) -> void:
	if ziel_szene != "":
		GameState.naechster_spawn = ziel_spawn
		get_tree().change_scene_to_file(ziel_szene)
	elif meldung != "":
		EventBus.meldung.emit(meldung)
