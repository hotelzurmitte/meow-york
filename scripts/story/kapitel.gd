extends Node
## Kapitel: verbindet Dialoge mit dem Spielablauf (Kämpfe, Ereignisse, Folgedialoge).
## Dialoge rufen Funktionen hierüber auf, z. B. `do Kapitel.kampf([...], "Name")`.

signal kampf_beendet(gewonnen: bool)

var _danach := ""          ## Dialog, der nach dem aktuellen Gespräch startet
var antonia := {"da": true, "weg": false, "misstrauen": 0.0, "zustand": "ruhig", "hold": false, "alert": false, "cool": 0.0}

func _ready() -> void:
	EventBus.ereignis.connect(_ereignis)

# ---------- Kampf ----------
## Das Kampfsystem wird erst in Phase 3 übertragen. Bis dahin gilt ein Kampf als gewonnen.
func kampf(gegner: Array, name := "") -> void:
	EventBus.hinweis.emit("Kampf: %s (Kampfsystem folgt – gilt vorerst als gewonnen)" % name, "info")
	EventBus.ereignis.emit("kampf:" + name)
	GameState.set_flag("letzter_kampf_gewonnen", true)
	for g in gegner: EventBus.ereignis.emit("besiegt:" + String(g))
	await get_tree().create_timer(0.6).timeout
	kampf_beendet.emit(true)

# ---------- Folgedialog ----------
func dialog_danach(cue: String) -> void:
	_danach = cue

func nach_gespraech() -> void:
	if _danach == "": return
	var cue := _danach; _danach = ""
	await get_tree().create_timer(0.6).timeout
	for d in ["kapitel1_ankunft", "kapitel1_bar", "kapitel1_strasse", "kapitel1_branx"]:
		var res: DialogueResource = load("res://data/dialogues/%s.dialogue" % d)
		if cue in res.get_cues():
			Dialog.starten(res, cue, null); return

# ---------- Schleichen und Antonia (Garage) – vollständig mit dem Schleichsystem ----------
func schleicht() -> bool:
	return false

func antonia_da() -> bool: return antonia.da and not antonia.weg
func antonia_weg() -> bool: return antonia.weg
func antonia_misstrauen() -> float: return antonia.misstrauen
func antonia_zustand() -> String: return antonia.zustand

func antonia_setze(eigenschaft: String, wert) -> void:
	if eigenschaft == "sus": antonia.misstrauen = float(wert)
	else: antonia[eigenschaft] = wert
	EventBus.ereignis.emit("antonia:%s" % eigenschaft)

# ---------- Ereignisse aus Dialogen, die keine Szene braucht ----------
func _ereignis(name_: String) -> void:
	var t := name_.split(":")
	match t[0]:
		"giveBoom":
			GameState.set_flag("hasBoom"); GameState.set_flag("boomTaken")
			EventBus.ereignis.emit("boombox:weg")
			if GameState.quests.has(GameState.aktuelle_quest):
				GameState.quest_ziel_setzen("Bring den Ghettoblaster zu Nugget ins Cuckoo's Nest.")
				GameState.quest_ziel_figur = "nugget"
			EventBus.hinweis.emit("Erhalten: Goldener Ghettoblaster", "quest")
		"checkShift":
			if GameState.flag("job") and not GameState.flag("shiftDone") and not GameState.flag("shiftMissed") and GameState.tag > GameState.job_tag + 1:
				GameState.set_flag("shiftMissed"); GameState.fehl_tag = GameState.tag
				GameState.quest("shift", "Schicht im Cuckoo's Nest", "Schicht verpasst. Hummel ist sauer – ein paar Tage redet er nicht mit euch, und danach wird es teurer.", true, true)
		"antGone":
			antonia.weg = true; GameState.set_flag("antGone")
		"antCalm":
			antonia.alert = false; antonia.misstrauen = 0.0; antonia.cool = 30.0
		"revealJag":
			GameState.set_flag("jagSeen")
