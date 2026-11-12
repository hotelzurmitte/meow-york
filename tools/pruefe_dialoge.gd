extends Node
## Prüft alle .dialogue-Dateien mit dem Dialogue-Manager-Compiler und listet Fehler mit Zeilennummer.
## Aufruf: godot --headless --path . res://tools/pruefe_dialoge.tscn
func _ready() -> void:
	var d := "res://data/dialogues/"
	for f in DirAccess.get_files_at(d):
		if not f.ends_with(".dialogue"): continue
		var text := FileAccess.get_file_as_string(d + f)
		var r := DMCompiler.compile_string(text, d + f)
		print("%s: %d Fehler" % [f, r.errors.size()])
		var zeilen := text.split("\n")
		for e in r.errors:
			print("  Zeile %d: %s  |  %s" % [e.line_number + 1, DMConstants.get_error_message(e.error), zeilen[e.line_number].substr(0, 120)])
	get_tree().quit()
