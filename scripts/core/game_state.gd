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

func ansehen_aendern(gruppe: String, d: int) -> void:
	ansehen[gruppe] = ansehen.get(gruppe, 0) + d

func gesinnung_aendern(achse: String, d: int) -> void:
	gesinnung[achse] = gesinnung.get(achse, 0) + d

# ---------- Quests ----------
func quest(id: String, name: String, ziel: String, erledigt := false, neben := false) -> void:
	quests[id] = {"name": name, "ziel": ziel, "erledigt": erledigt, "neben": neben}
	EventBus.quest_geaendert.emit(id)
	EventBus.hinweis.emit("Quest: " + name, "quest")

func quest_aktiv(id: String) -> bool:
	return quests.has(id) and not quests[id].erledigt

# ---------- Proben (W20 + Wert gegen Schwierigkeit) ----------
func probe(wer: String, fertigkeit: String, sg: int) -> bool:
	letzter_wurf = randi_range(1, 20)
	var bonus: int = fertigkeiten.get(wer, {}).get(fertigkeit, 0)
	letzte_probe_ok = letzter_wurf + bonus >= sg
	EventBus.hinweis.emit("%s (SG %d): W20 %d + %d = %d → %s" % [fertigkeit, sg, letzter_wurf, bonus, letzter_wurf + bonus, "Erfolg" if letzte_probe_ok else "Misserfolg"], "gut" if letzte_probe_ok else "schlecht")
	return letzte_probe_ok

# ---------- Speichern ----------
func als_dict() -> Dictionary:
	return {"version": VERSION, "flags": flags, "geld": geld, "tag": tag, "quests": quests,
		"zuneigung": zuneigung, "ansehen": ansehen, "gesinnung": gesinnung, "notizen": notizen, "gruppe": gruppe}

func aus_dict(d: Dictionary) -> void:
	# Ältere Stände hier hochrechnen, wenn VERSION steigt
	flags = d.get("flags", {}); geld = d.get("geld", 0); tag = d.get("tag", 0); quests = d.get("quests", {})
	zuneigung = d.get("zuneigung", zuneigung); ansehen = d.get("ansehen", {}); gesinnung = d.get("gesinnung", gesinnung)
