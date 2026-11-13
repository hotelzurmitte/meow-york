extends Node3D
## Akt 1, Quest 1 (Junos Spur) in Hairlem: setzt Schwester Odile und die Ordenshelfer zur Laufzeit ein.
## Daten: data/levels/hairlem/story_akt1.json. Die Szene hairlem.tscn wird dafür nicht verändert.
## Wer wann da ist, richtet sich nach der Tageszeit (Stimmung) und nach dem Zustand „odile“:
##   Morgen: Odile und die Helfer räumen Junos Wohnung aus (Einstieg odile_wohnung).
##   Tag und Abend: Odile verteilt Suppe vor dem Haus (Einstieg odile_mission).
##   Nacht: niemand.

const DATEN := "res://data/levels/hairlem/story_akt1.json"
const DIALOG := preload("res://data/dialogues/akt1_odile.dialogue")

var _figuren := {}      ## schluessel -> NPC
var _orte := {}         ## schluessel -> Dialogpunkt
var _zeit := ""

func _ready() -> void:
	name = "Akt1Juno"
	var d: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(DATEN))
	for f in d.figuren:
		var npc := Node3D.new(); npc.set_script(load("res://scripts/characters/npc.gd"))
		npc.name = "Story_" + String(f.schluessel)
		npc.set("anzeigename", f.name); npc.set("figur", f.figur)
		npc.set("blick", Vector2(f.blick[0], f.blick[1]))
		npc.set("sprechernamen", PackedStringArray(f.get("sprechernamen", [])))
		if f.has("sprueche"): npc.set("sprueche", PackedStringArray(f.sprueche))
		npc.position = _position(String(f.schluessel), f.pos)
		add_child(npc); _figuren[f.schluessel] = npc
	for o in d.orte:
		var p := Node3D.new(); p.set_script(load("res://scripts/world/dialog_punkt.gd"))
		p.name = "Story_" + String(o.schluessel)
		p.set("beschriftung", o.beschriftung); p.set("dialog", DIALOG); p.set("dialog_start", o.cue)
		p.position = _position(String(o.schluessel), o.pos)
		add_child(p); _orte[o.schluessel] = p
	EventBus.flag_geaendert.connect(func(_n, _w): _aktualisieren())
	EventBus.dialog_beendet.connect(_aktualisieren)
	_aktualisieren()

## Ein Marker3D „Story_<schluessel>“ unter „Handgebaut“ hat Vorrang vor der Position aus den Daten
func _position(schluessel: String, pos: Array) -> Vector3:
	var m := get_parent().get_node_or_null("Handgebaut/Story_" + schluessel) as Node3D
	return m.global_position if m else Vector3(pos[0], pos[1], pos[2])

func _process(_dt: float) -> void:
	# Die Tageszeit hat kein Signal, daher hier vergleichen
	var s := get_parent().get_node_or_null("Stimmung")
	if s and s.voreinstellung != _zeit: _aktualisieren()

func _aktualisieren() -> void:
	if Dialog.aktiv: return            # Während eines Gesprächs verschwindet niemand
	var s := get_parent().get_node_or_null("Stimmung")
	_zeit = s.voreinstellung if s else "day"
	var odile: String = GameState.flag("odile")
	var morgen := _zeit == "morning"
	var nacht := _zeit == "night"
	# Erst nach der Ankunft (Überfall vorbei) und solange Akt 1 läuft
	var aktiv: bool = GameState.flag("ch1robbed") and int(GameState.flag("akt")) <= 1
	var o: Node3D = _figuren.get("odile")
	if o:
		o.visible = aktiv and not nacht
		o.set("dialog", DIALOG)
		o.set("dialog_start", "odile_wohnung" if morgen else "odile_mission")
	# Die Helfer räumen nur morgens und nur, bis das Gespräch mit Odile gelaufen ist
	for k in ["helfer_hopp", "helfer_maus"]:
		var h: Node3D = _figuren.get(k)
		if h: h.visible = aktiv and morgen and odile == "unbekannt"
	var l: Node3D = _orte.get("lauschen")
	if l: l.visible = aktiv and morgen and odile == "unbekannt" and not GameState.schon("spur_expedition")
