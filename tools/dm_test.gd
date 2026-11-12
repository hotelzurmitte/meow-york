extends Node
func _ready() -> void:
	var proben := ["do GameState.geld_aendern(-1)", "do GameState.geld_aendern(-GameState.geld)", "do GameState.geld_aendern(0 - GameState.geld)",
		"do GameState.notiz(\"a\" + str(GameState.geld))", "do GameState.notiz(\"a\" + GameState.geld)", "set GameState.quest_ziel_figur = null",
		"do GameState.geld_aendern(max(GameState.geld, 50))", "do GameState.geld_aendern(floor(GameState.geld / 2))", "do GameState.geld_aendern(1 if GameState.flag(\"x\") else 2)",
		"do GameState.notiz(\"Wert \" + str(1))"]
	for p in proben:
		var r := DMCompiler.compile_string("~ s\n" + p + "\nIlse: x\n=> END\n", "res://x.dialogue")
		print(("OK   " if r.errors.is_empty() else "FEHL ") + p)
	get_tree().quit()
