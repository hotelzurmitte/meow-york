extends Node
## GameState: die einzige Quelle für den Spielzustand. Wird als JSON gespeichert (versioniert).

const VERSION := 1

var flags: Dictionary = {}
var geld: int = 0
var tag: int = 0
var quests: Dictionary = {}          ## id -> {name, ziel, erledigt, neben}
var zuneigung: Dictionary = {"dig": 0, "corvin": 0}
var ansehen: Dictionary = {}         ## Gruppe -> Wert
var gesinnung: Dictionary = {"gut": 0, "gesetz": 0}
var letzte_probe_ok := false
var letzter_wurf := 0
var naechster_spawn := ""             ## Spawnpunkt im nächsten Level
var belohnung: int = 0                 ## Nuggets Belohnung für den Ghettoblaster
var job_tag: int = 0                   ## Tag, an dem Hummel den Job vergeben hat
var fehl_tag: int = 0                  ## Tag, an dem die Schicht verpasst wurde
var aktuelle_quest := ""               ## zuletzt geänderte Aufgabe (wie GAME.quest im Prototyp)
var quest_ziel_figur := ""             ## Figur, zu der die aktuelle Aufgabe führt
var wurf: int = 0                      ## Ergebnis von wuerfeln()
var _gesehen: Dictionary = {}          ## im laufenden Gespräch schon besuchte Knoten

## Fertigkeitswerte (Platzhalter bis zum Charaktersystem)
var fertigkeiten: Dictionary = {
	"ren": {"Täuschen": 3, "Fingerfertigkeit": 4, "Akrobatik": 4, "Überzeugen": 2, "Einschüchtern": 1, "Wahrnehmung": 2},
	"dig": {"Einschüchtern": 4, "Athletik": 5, "Wahrnehmung": 1},
	"corvin": {"Wahrnehmung": 4, "Einsicht": 4, "Straßenwissen": 4},
}

# ---------- Flags ----------
func flag(name: String, standard = false):
	return flags.get(name, standard)

func set_flag(name: String, wert = true) -> void:
	flags[name] = wert
	EventBus.flag_geaendert.emit(name, wert)

## Gibt beim ersten Aufruf false zurück und merkt sich den Schlüssel (für einmalige Antworten)
func einmal(schluessel: String) -> bool:
	var k := "o:" + schluessel
	if flags.has(k):
		return true
	flags[k] = true
	return false

func schon(schluessel: String) -> bool:
	return flags.has("o:" + schluessel)

# ---------- Gruppe ----------
var gruppe: Array = ["ren", "dig", "corvin"]
func mitglied(wer: String) -> bool:
	return wer in gruppe

# ---------- Notizen (Hinweise im Tagebuch) ----------
var notizen: Array = []
func notiz(text: String) -> void:
	if text in notizen: return
	notizen.append(text)
	EventBus.hinweis.emit("Hinweis: " + text, "quest")

## Raub: nimmt bis zu `betrag` Collar und merkt sich, wie viel
func rauben(betrag: int) -> void:
	var t: int = min(geld, betrag)
	if t > 0: geld_aendern(-t)
	set_flag("robbed", t)

# ---------- Geld, Beziehungen ----------
func geld_aendern(betrag: int) -> void:
	geld = max(0, geld + betrag)
	EventBus.geld_geaendert.emit(geld)
	if betrag != 0:
		EventBus.hinweis.emit(("+%d" % betrag if betrag > 0 else "%d" % betrag) + " Collar", "gut" if betrag > 0 else "schlecht")

func zuneigung_aendern(wer: String, d: int) -> void:
	zuneigung[wer] = zuneigung.get(wer, 0) + d
	var n: String = {"dig": "Big Dig", "corvin": "Corvin", "ren": "Ren"}.get(wer, wer)
	var t: String = ("gefällt das sehr." if d > 1 else "gefällt das.") if d > 0 else ("missbilligt das stark." if d < -1 else "missbilligt das.")
	EventBus.hinweis.emit("%s %s" % [n, t], "gut" if d > 0 else "schlecht")

const GRUPPEN := {"nomapes": "Nomapes", "cats": "Breaking Cats", "insects": "Insekten von Hairlem"}
func ansehen_aendern(gruppe: String, d: int) -> void:
	ansehen[gruppe] = ansehen.get(gruppe, 0) + d
	EventBus.hinweis.emit("%s: Ansehen %s%d" % [GRUPPEN.get(gruppe, gruppe), "+" if d > 0 else "", d], "gut" if d > 0 else "schlecht")

func gesinnung_aendern(achse: String, d: int) -> void:
	gesinnung[achse] = gesinnung.get(achse, 0) + d
	var t := ("Gut" if d > 0 else "Böse") if achse == "gut" else ("Rechtschaffen" if d > 0 else "Chaotisch")
	EventBus.hinweis.emit("Gesinnung ↑ " + t, "info")

# ---------- Quests ----------
func quest(id: String, name: String, ziel: String, erledigt := false, neben := false) -> void:
	quests[id] = {"name": name, "ziel": ziel, "erledigt": erledigt, "neben": neben}
	aktuelle_quest = id
	EventBus.quest_geaendert.emit(id)
	EventBus.hinweis.emit(("Aufgabe abgeschlossen: " if erledigt else "Aufgabe: ") + name, "quest")

func quest_erledigt(id: String) -> bool:
	return quests.has(id) and quests[id].erledigt

## Ziel der aktuellen Aufgabe ändern (wie GAME.quest.obj = … im Prototyp)
func quest_ziel_setzen(text: String) -> void:
	if quests.has(aktuelle_quest):
		quests[aktuelle_quest].ziel = text
		EventBus.quest_geaendert.emit(aktuelle_quest)

func quest_aktiv(id: String) -> bool:
	return quests.has(id) and not quests[id].erledigt

# ---------- Proben (W20 + Wert gegen Schwierigkeit) ----------
func probe(wer: String, fertigkeit: String, sg: int) -> bool:
	letzter_wurf = randi_range(1, 20)
	var bonus: int = fertigkeiten.get(wer, {}).get(fertigkeit, 0)
	letzte_probe_ok = letzter_wurf + bonus >= sg
	EventBus.hinweis.emit("%s (SG %d): W20 %d + %d = %d → %s" % [fertigkeit, sg, letzter_wurf, bonus, letzter_wurf + bonus, "Erfolg" if letzte_probe_ok else "Misserfolg"], "gut" if letzte_probe_ok else "schlecht")
	return letzte_probe_ok

# ---------- Regeln aus dem Prototyp ----------
func heilen(n: int) -> void:
	EventBus.ereignis.emit("heilen:%d" % n)

func schaden(wer: String, n: int) -> void:
	EventBus.ereignis.emit("schaden:%s:%d" % [wer, n])

func katzen_sauer() -> bool:
	return (flag("stoleBoom") or flag("beatCats")) and not flag("catsMadeUp")

func wurde_beraubt() -> bool:
	return int(flag("robbed", 0)) > 0

func geraubt_zurueck() -> int:
	return max(40, int(flag("robbed", 0)))

func roach_name() -> String:
	return "Big Dig" if flag("roachKnowsDig") else "Bruder"

func bierpreis() -> int:
	return 6 if flag("shiftMissed") else 3

func zimmerpreis() -> int:
	return 0 if flag("job") else 10

func schicht_offen() -> bool:
	return flag("job") and not flag("shiftDone") and not flag("shiftMissed") and tag > job_tag

## Wer nach dem Ghettoblaster-Streit sauer ist („cats“ oder „nomapes“)
func veraergert() -> String:
	return "cats" if gleich(flag("boomTo"), "nomapes") else "nomapes"

func wuerfeln(seiten: int) -> void:
	wurf = randi() % max(1, seiten)

## true, wenn der Knoten in diesem Gespräch schon besucht wurde (markiert ihn sonst)
func erneut(knoten: String) -> bool:
	if _gesehen.has(knoten): return true
	_gesehen[knoten] = true
	return false

func gespraech_beginnt() -> void:
	_gesehen.clear()

# ---------- Hilfen für Dialoge (der Dialogue Manager kennt kein „a if b else c“) ----------
func wenn(bedingung, ja, nein):
	return ja if bedingung else nein

## Vergleich ohne Typfehler (ein ungesetztes Flag ist false, kein Text)
func gleich(a, b) -> bool:
	if typeof(a) != typeof(b):
		if typeof(a) in [TYPE_INT, TYPE_FLOAT] and typeof(b) in [TYPE_INT, TYPE_FLOAT]: return float(a) == float(b)
		if typeof(a) == TYPE_BOOL and typeof(b) in [TYPE_INT, TYPE_FLOAT]: return int(a) == int(b)
		if typeof(b) == TYPE_BOOL and typeof(a) in [TYPE_INT, TYPE_FLOAT]: return int(a) == int(b)
		return false
	return a == b

func abrunden(x) -> int:
	return int(floor(float(x)))

## Text aus beliebigem Wert (der Dialogue Manager kennt das globale str() nicht)
func text(x) -> String:
	if x == null: return ""
	if typeof(x) == TYPE_FLOAT and x == floor(x): return str(int(x))
	return str(x)

## Wahrheitswert wie in JavaScript (1/true/"x" → true)
func wahr(x) -> bool:
	return bool(x) if typeof(x) in [TYPE_BOOL, TYPE_INT, TYPE_FLOAT] else (x != null and str(x) != "")

func oder(a, b):
	return a if a else b

# ---------- Speichern ----------
func als_dict() -> Dictionary:
	return {"version": VERSION, "flags": flags, "geld": geld, "tag": tag, "quests": quests,
		"zuneigung": zuneigung, "ansehen": ansehen, "gesinnung": gesinnung, "notizen": notizen, "gruppe": gruppe,
		"belohnung": belohnung, "job_tag": job_tag, "fehl_tag": fehl_tag, "aktuelle_quest": aktuelle_quest, "quest_ziel_figur": quest_ziel_figur}

func aus_dict(d: Dictionary) -> void:
	# Ältere Stände hier hochrechnen, wenn VERSION steigt
	flags = d.get("flags", {}); geld = d.get("geld", 0); tag = d.get("tag", 0); quests = d.get("quests", {})
	zuneigung = d.get("zuneigung", zuneigung); ansehen = d.get("ansehen", {}); gesinnung = d.get("gesinnung", gesinnung)
