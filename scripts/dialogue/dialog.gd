extends Node
## Dialog: Anbindung an den Dialogue Manager. Startet Gespräche im eigenen Dialogfeld
## (scenes/ui/dialogfeld.tscn, eingetragen als runtime/balloon_path) und meldet Anfang/Ende über den EventBus.

const FELD := "res://scenes/ui/dialogfeld.tscn"

var aktiv := false
var sprecher: Node = null

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_ende)

func starten(res: DialogueResource, cue := "", wer: Node = null) -> void:
	if aktiv: return
	aktiv = true; sprecher = wer
	GameState.gespraech_beginnt()
	EventBus.dialog_gestartet.emit(wer)
	var feld := DialogueManager.show_dialogue_balloon_scene(FELD, res, cue, [GameState])
	if feld: feld.add_to_group("dialog_blase")

## Einzelner Spruch einer Figur ohne Dialogdatei – erscheint ebenfalls im Dialogfeld
func einzeln(name: String, text: String, wer: Node = null) -> void:
	if aktiv: return
	aktiv = true; sprecher = wer
	EventBus.dialog_gestartet.emit(wer)
	var feld = load(FELD).instantiate()
	feld.add_to_group("dialog_blase")
	get_tree().current_scene.add_child(feld)
	feld.einzeln(name, text)

func einzeln_fertig() -> void:
	if not aktiv: return
	aktiv = false; sprecher = null
	EventBus.dialog_beendet.emit()

func _ende(_res) -> void:
	if not aktiv: return
	aktiv = false; sprecher = null
	EventBus.dialog_beendet.emit()
	Kapitel.nach_gespraech()

## Laufendes Gespräch beenden (z. B. vor einem Szenenwechsel)
func abbrechen() -> void:
	for b in get_tree().get_nodes_in_group("dialog_blase"):
		b.queue_free()
	if aktiv:
		aktiv = false; sprecher = null
		EventBus.dialog_beendet.emit()
