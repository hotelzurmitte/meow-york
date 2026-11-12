extends Node
## Spielt jeden Dialogknoten ab und folgt jeder erlaubten Antwort (begrenzte Tiefe).
## Meldet Laufzeitfehler des Dialogue Managers (fehlende Funktionen, falsche Typen).
## Aufruf: godot --headless --path . res://tools/dialog_lauftest.tscn
var schritte := 0

func _ready() -> void:
	get_tree().create_timer(500).timeout.connect(func(): print("ZEITLIMIT"); get_tree().quit())
	var d := "res://data/dialogues/"
	for f in DirAccess.get_files_at(d):
		if not f.ends_with(".dialogue"): continue
		var res: DialogueResource = load(d + f)
		var titel: PackedStringArray = res.get_cues()
		var n := 0
		for t in titel:
			GameState.aus_dict({}); GameState.gespraech_beginnt()
			await _folge(res, t, 0)
			n += 1
		print("%s: %d Einstiege, %d Schritte" % [f, n, schritte])
	print("FERTIG")
	get_tree().quit()

func _folge(res: DialogueResource, key: String, tiefe: int) -> void:
	if tiefe > 6 or key == "" or key == "END": return
	var line = await DialogueManager.get_next_dialogue_line(res, key)
	var i := 0
	while line and i < 12:
		schritte += 1
		if line.responses.size() > 0:
			for r in line.responses:
				if r.is_allowed and tiefe < 3:
					await _folge(res, r.next_id, tiefe + 1)
			return
		if line.next_id == "" or line.next_id == "END": return
		line = await DialogueManager.get_next_dialogue_line(res, line.next_id)
		i += 1
