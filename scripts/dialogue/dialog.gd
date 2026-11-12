extends Node
## Dialog: Anbindung an den Dialogue Manager. Startet Gespräche und meldet Anfang/Ende über den EventBus.
## Die Sprechblase ist vorerst die Beispiel-Sprechblase des Plugins; sie wird später im Meow-York-Stil ersetzt.

var aktiv := false
var sprecher: Node = null

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_ende)

func starten(res: DialogueResource, cue := "", wer: Node = null) -> void:
	if aktiv: return
	aktiv = true; sprecher = wer
	EventBus.dialog_gestartet.emit(wer)
	var blase := DialogueManager.show_dialogue_balloon(res, cue, [GameState])
	if blase: blase.add_to_group("dialog_blase")

func _ende(_res) -> void:
	if not aktiv: return
	aktiv = false; sprecher = null
	EventBus.dialog_beendet.emit()

## Laufendes Gespräch beenden (z. B. vor einem Szenenwechsel)
func abbrechen() -> void:
	for b in get_tree().get_nodes_in_group("dialog_blase"):
		b.queue_free()
	if aktiv:
		aktiv = false; sprecher = null
		EventBus.dialog_beendet.emit()
