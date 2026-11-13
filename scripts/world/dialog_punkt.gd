extends Node3D
## Benutzbarer Punkt ohne Figur, der einen Dialog startet (z. B. „Im Hausflur lauschen“).

@export var beschriftung := "Untersuchen"
@export var dialog: DialogueResource
@export var dialog_start := ""

func _ready() -> void:
	add_to_group("interaktiv")

var hinweis: String:
	get: return beschriftung

func benutzen(_wer: Node3D) -> void:
	if dialog: Dialog.starten(dialog, dialog_start, null)
