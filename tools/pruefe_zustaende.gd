extends Node
## Prüft das Zustandsregister gegen Dialoge, Skripte und Szenarien. Repariert nichts, meldet nur.
## Aufruf: godot --headless --path . res://tools/pruefe_zustaende.tscn
## Ende mit Code 1, wenn es FEHLER gibt (für automatische Läufe), sonst 0.
##
##   FEHLER   unbekannte Variable, ungültiger Wert, abgeleitete Variable gesetzt,
##            fehlerhafter Registereintrag, Aktübergang lässt Kapitel offen, kaputtes Szenario
##   WARNUNG  gelesen, aber nie gesetzt · gesetzt, aber nie gelesen · Ausgang an mehreren Stellen gesetzt
##   HINWEIS  Story-Variablen, die noch nirgends eingebaut sind

const QUELLEN := ["res://data/dialogues/", "res://scripts/", "res://tools/"]
const AUSNAHMEN := ["res://tools/pruefe_zustaende.gd", "res://scripts/core/zustaende.gd"]

var fehler := 0
var warnungen := 0
var ausfuehrlich := "--ausfuehrlich" in OS.get_cmdline_user_args()
var proto_warnungen := []   ## Warnungen zu Prototyp-Flags (nur mit --ausfuehrlich einzeln)
var gelesen := {}   ## name -> Array „datei:zeile“
var gesetzt := {}   ## name -> Array „datei:zeile“

func _ready() -> void:
	print("== Zustandsprüfung ==")
	_pruefe_register()
	for q in QUELLEN: _durchsuche(q)
	_pruefe_verwendung()
	_teste_laufzeit()
	_pruefe_szenarien()
	print("\n== Ergebnis: %d Fehler, %d Warnungen ==" % [fehler, warnungen])
	get_tree().quit(1 if fehler > 0 else 0)

func _fehler(t: String) -> void:
	fehler += 1; print("FEHLER   " + t)

func _warnung(t: String, prototyp := false) -> void:
	warnungen += 1
	if prototyp and not ausfuehrlich: proto_warnungen.append(t)
	else: print("WARNUNG  " + t)

# ---------- 1. Das Register selbst ----------
func _pruefe_register() -> void:
	print("\n-- Register --")
	var typen := ["bool", "int", "enum", "liste"]
	for e in Zustaende.alle():
		var n: String = e.name
		if not (e.get("typ") in typen): _fehler("%s: unbekannter Typ „%s“" % [n, e.get("typ")]); continue
		if not e.has("standard"): _fehler("%s: kein Standardwert" % n)
		elif not e.has("abgeleitet"):
			var f := Zustaende.pruefe_wert(n, Zustaende.standard(n))
			if f != "": _fehler("%s: Standardwert ungültig – %s" % [n, f])
		if e.has("verfaellt_nach_akt"):
			if not ("offen" in e.get("werte", []) and "verpasst" in e.get("werte", [])):
				_fehler("%s: verfällt nach Akt %s, braucht aber die Werte „offen“ und „verpasst“" % [n, str(e.verfaellt_nach_akt)])
			if Zustaende.standard(n) != "offen": _fehler("%s: verfallendes Kapitel muss mit „offen“ beginnen" % n)
		for wert in e.get("voraussetzungen", {}):
			if wert != "*" and e.typ == "enum" and not (wert in e.werte): _fehler("%s: Voraussetzung für unbekannten Wert „%s“" % [n, wert])
			for b in e.voraussetzungen[wert]:
				if not Zustaende.hat(b[0]): _fehler("%s: Voraussetzung nennt unbekannte Variable „%s“" % [n, b[0]])
				elif not (b[1] in ["==", "!="]): _fehler("%s: Vergleich „%s“ nicht erlaubt (nur == und !=)" % [n, b[1]])
		if Zustaende.ist_prototyp(n): _fehler("%s steht im Register und in prototyp_flags" % n)
	print("%d Story-Variablen, %d Prototyp-Flags geduldet" % [Zustaende.alle().size(), Zustaende.prototyp_flags().size()])

# ---------- 2. Dialoge und Skripte durchsuchen ----------
## Nur feste Namen: zusammengesetzte wie flag("viertel_" + v) werden übersprungen
var _re_lesen := RegEx.create_from_string("(?<![A-Za-z_])flag\\(\\s*\"([^\"]+)\"(?=\\s*[,)])")
var _re_setzen := RegEx.create_from_string("(?:set_flag|erhoehen)\\(\\s*\"([^\"]+)\"")
var _re_setzwert := RegEx.create_from_string("^\\s*(?:,\\s*([^()]*?))?\\s*\\)")
var _re_vergleich := RegEx.create_from_string("gleich\\(\\s*(?:GameState\\.)?flag\\(\\s*\"([^\"]+)\"\\s*\\)\\s*,\\s*(\"[^\"]*\"|true|false|-?\\d+)\\s*\\)|flag\\(\\s*\"([^\"]+)\"\\s*\\)\\s*[!=]=\\s*(\"[^\"]*\"|true|false|-?\\d+)")

func _durchsuche(ordner: String) -> void:
	for f in DirAccess.get_files_at(ordner):
		var pfad := ordner + f
		if pfad in AUSNAHMEN: continue
		if f.ends_with(".gd") or f.ends_with(".dialogue"): _datei(pfad)
	for d in DirAccess.get_directories_at(ordner): _durchsuche(ordner + d + "/")

func _datei(pfad: String) -> void:
	var text := FileAccess.get_file_as_string(pfad)
	var kurz := pfad.trim_prefix("res://")
	for m in _re_lesen.search_all(text):
		_merke(gelesen, m.get_string(1), "%s:%d" % [kurz, _zeile(text, m.get_start())])
	for m in _re_setzen.search_all(text):
		var n := m.get_string(1)
		var ort := "%s:%d" % [kurz, _zeile(text, m.get_start())]
		_merke(gesetzt, n, ort)
		_pruefe_name(n, ort)
		# erhoehen() zählt relativ: Typ muss eine Zahl sein, der Wert selbst wird zur Laufzeit begrenzt
		if m.get_string(0).begins_with("erhoehen"):
			if Zustaende.hat(n) and String(Zustaende.eintrag(n).get("typ", "")) != "int":
				_fehler("%s: erhoehen(„%s“) braucht eine Zahl-Variable" % [ort, n])
			continue
		# Wert direkt hinter dem Namen; nur Literale werden geprüft
		var w := _re_setzwert.search(text.substr(m.get_end(), 200))
		if w == null: continue
		var roh := w.get_string(1).strip_edges()
		var wert = true if roh == "" else _literal(roh)
		if wert != null and Zustaende.hat(n) and not Zustaende.ist_abgeleitet(n):
			var f := Zustaende.pruefe_wert(n, wert)
			if f != "": _fehler("%s: %s" % [ort, f])
	for m in _re_vergleich.search_all(text):
		var n := m.get_string(1) if m.get_string(1) != "" else m.get_string(3)
		var roh := m.get_string(2) if m.get_string(1) != "" else m.get_string(4)
		var wert = _literal(roh)
		if wert != null and Zustaende.hat(n) and not Zustaende.ist_abgeleitet(n):
			var f := Zustaende.pruefe_wert(n, wert)
			if f != "": _fehler("%s:%d: Vergleich mit unmöglichem Wert – %s" % [kurz, _zeile(text, m.get_start()), f])

func _pruefe_name(n: String, ort: String) -> void:
	if not Zustaende.bekannt(n): _fehler("%s: unbekannte Variable „%s“ – ins Zustandsregister eintragen" % [ort, n])
	elif Zustaende.ist_abgeleitet(n): _fehler("%s: „%s“ ist abgeleitet und darf nicht gesetzt werden" % [ort, n])

func _merke(ziel: Dictionary, n: String, ort: String) -> void:
	if n.begins_with("o:"): return   # Schlüssel von GameState.einmal()/schon(), keine Flags
	# GameState berechnet abgeleitete Werte selbst – das zählt nicht als Verwendung im Spiel
	if ort.begins_with("scripts/core/game_state.gd") and Zustaende.hat(n): return
	if not ziel.has(n): ziel[n] = []
	ziel[n].append(ort)

## Literal aus dem Quelltext lesen; null, wenn es kein Literal ist (z. B. eine Variable)
func _literal(roh: String):
	if roh.begins_with("\"") and roh.ends_with("\"") and roh.length() >= 2: return roh.substr(1, roh.length() - 2)
	if roh == "true": return true
	if roh == "false": return false
	if roh.is_valid_int(): return int(roh)
	return null

func _zeile(text: String, pos: int) -> int:
	return text.substr(0, pos).count("\n") + 1

# ---------- 3. Verwendung ----------
func _pruefe_verwendung() -> void:
	print("\n-- Verwendung --")
	for n in gelesen:
		if not Zustaende.bekannt(n):
			_fehler("%s: unbekannte Variable „%s“ wird gelesen" % [gelesen[n][0], n])
		elif not gesetzt.has(n) and not Zustaende.ist_abgeleitet(n):
			_warnung("„%s“ wird gelesen (%s), aber nirgends gesetzt" % [n, gelesen[n][0]], Zustaende.ist_prototyp(n))
	for n in gesetzt:
		if Zustaende.bekannt(n) and not gelesen.has(n):
			_warnung("„%s“ wird gesetzt (%s), aber nirgends gelesen" % [n, gesetzt[n][0]], Zustaende.ist_prototyp(n))
		if Zustaende.eintrag(n).get("einmal", false) and gesetzt[n].size() > 1:
			_warnung("Ausgang „%s“ wird an %d Stellen gesetzt: %s" % [n, gesetzt[n].size(), ", ".join(gesetzt[n])])
	if not proto_warnungen.is_empty():
		print("WARNUNG  %d Warnungen zu Prototyp-Flags (einzeln mit: -- --ausfuehrlich)" % proto_warnungen.size())
	var offen := []
	for e in Zustaende.alle():
		if not gelesen.has(e.name) and not gesetzt.has(e.name): offen.append(e.name)
	print("HINWEIS  %d von %d Story-Variablen sind noch nirgends eingebaut" % [offen.size(), Zustaende.alle().size()])

# ---------- 4. Laufzeit: GameState und Aktübergang ----------
func _teste_laufzeit() -> void:
	print("\n-- Laufzeit --")
	var vorher := GameState.als_dict()
	GameState.aus_dict({})
	# Standardwerte und abgeleitete Werte
	_erwarte(GameState.flag("tauben") == "offen", "Standardwert von „tauben“ ist „offen“")
	GameState.zuneigung["dig"] = 9
	_erwarte(GameState.flag("dig_zuneigung") == "hoch", "Zuneigung 9 ergibt „hoch“")
	GameState.zuneigung["dig"] = 0
	GameState.set_flag("naeherinnen", "befreit")
	_erwarte(GameState.flag("unruhen_hairlem") == true, "„unruhen_hairlem“ folgt aus „naeherinnen“")
	# Knötchen und große Knoten
	for i in 7: GameState.knoetchen("dig")
	_erwarte(GameState.flag("dig_knoten") == 2, "7 Knötchen ergeben Knotenstärke 2")
	GameState.knoten_reisst("dig")
	_erwarte(GameState.flag("dig_knoten") == 0, "Verrat setzt den Knoten auf 0")
	for id in ["waffenstillstand", "platz_gerettet", "hunde_frei", "deltamae_konzert", "knotenwand", "fitz_show", "gangs_gemeinsam"]:
		GameState.grosser_knoten(id)
	_erwarte(GameState.flag("viertel_hairlem") == "haelt", "zwei positive Knoten: Hairlem hält")
	_erwarte(GameState.flag("viertel_cathattan") == "wankt", "ein positiver Knoten: Cathattan wankt")
	_erwarte(GameState.flag("verknotung_moeglich") == true, "drei Viertel halten, keins kippt: Verknotung möglich")
	GameState.grosser_knoten("unruhen_ungebremst"); GameState.grosser_knoten("unruhen_ungebremst")
	_erwarte(GameState.flag("viertel_cathattan") == "wankt", "großer Knoten zählt nur einmal")
	GameState.set_flag("grosse_knoten", ["gang_hass", "unruhen_ungebremst"])
	_erwarte(GameState.flag("stadt_brand") == "cathattan_brennt", "Cathattan kippt: Cathattan brennt")
	_erwarte(GameState.flag("verknotung_moeglich") == false, "ein Viertel kippt: keine Verknotung")
	# Haltung der Gangs
	GameState.set_flag("grosse_knoten", [])
	GameState.set_flag("gang_wahl", "nomapes"); GameState.set_flag("auftrag_ausgang", "ausgefuehrt")
	_erwarte(GameState.flag("haltung_nomapes") == "verbuendet" and GameState.flag("haltung_cats") == "feindlich", "Auftrag ausgeführt: gewählte Gang verbündet, andere feindlich")
	GameState.set_flag("auftrag_ausgang", "nugget_entlarvt")
	_erwarte(GameState.flag("haltung_cats") == "neutral", "Nugget entlarvt: andere Gang neutral")
	GameState.grosser_knoten("gangs_gemeinsam")
	_erwarte(GameState.flag("haltung_cats") == "verbuendet", "Gangs gemeinsam: beide verbündet")
	# Das bekannte Gesicht
	_erwarte(GameState.flag("bekanntes_gesicht_wer") == "junger_kater", "ohne Vorgeschichte: Malcolms junger Kater")
	GameState.set_flag("odile", "gewonnen")
	_erwarte(GameState.flag("bekanntes_gesicht_wer") == "odile", "Odile gewonnen: Odile")
	GameState.set_flag("gerettet", ["benny"])
	_erwarte(GameState.flag("bekanntes_gesicht_wer") == "benny", "Benny gerettet: Benny kommt zuerst")
	# Zähler bleiben in ihren Grenzen
	for i in 8: GameState.erhoehen("orden_wachsam")
	_erwarte(GameState.flag("orden_wachsam") == 5, "erhoehen() stoppt bei max 5")
	GameState.erhoehen("orden_wachsam", -9)
	_erwarte(GameState.flag("orden_wachsam") == 0, "erhoehen() stoppt bei min 0")
	# Werteprüfung erkennt Fehler
	_erwarte(Zustaende.pruefe_wert("tauben", "vielleicht") != "", "ungültiger Wert wird erkannt")
	_erwarte(Zustaende.pruefe_wert("malcolm_risse", 7) != "", "Zahl über dem Maximum wird erkannt")
	_erwarte(Zustaende.pruefe_wert("weberin_herausgeschnitten", ["pips", "hazel", "dig"]) != "", "mehr als zwei Herausgeschnittene werden erkannt")
	_erwarte(Zustaende.pruefe_wert("weberin_herausgeschnitten", ["juno"]) != "", "außerhalb Geborene können nicht herausgeschnitten werden")
	_erwarte(Zustaende.pruefe_wert("dig_in_gruppe", true) != "", "Setzen einer abgeleiteten Variable wird erkannt")
	_erwarte(Zustaende.pruefe_einmal("dig_ausgang", "entfuehrt", "losgelassen") != "", "Änderung eines Ausgangs wird erkannt")
	_erwarte(Zustaende.pruefe_voraussetzungen("dig_ausgang", "neu_verknotet", GameState.flag) != "", "fehlende Voraussetzung wird erkannt")
	# Aktübergang: ein erledigtes Kapitel bleibt, alles Offene verfällt
	GameState.aus_dict({})
	GameState.set_flag("tauben", "befreit")
	for akt in [1, 2, 3, 4]:   # 4 → 5 ist der Übergang ins Finale
		GameState.akt_wechseln(akt + 1)
		for n in Zustaende.verfallende(akt):
			if GameState.flag(n) == "offen": _fehler("Aktübergang %d → %d lässt „%s“ offen" % [akt, akt + 1, n])
	_erwarte(GameState.flag("tauben") == "befreit", "erledigtes Kapitel bleibt beim Aktübergang erhalten")
	_erwarte(GameState.flag("naeherinnen") == "verpasst", "offenes Kapitel wird beim Aktübergang „verpasst“")
	# Zeitfenster: „tauben“ ist in Akt 2 noch offen und verfällt erst danach
	GameState.aus_dict({})
	GameState.akt_wechseln(2)
	_erwarte(GameState.flag("tauben") == "offen", "Kapitel mit Fenster über zwei Akte bleibt nach Akt 1 offen")
	GameState.akt_wechseln(3)
	_erwarte(GameState.flag("tauben") == "verpasst", "Kapitel verfällt nach dem zweiten Akt seines Fensters")
	# Pflicht-Lagerszenen werden nachgeholt, nie verloren
	GameState.aus_dict({})
	GameState.set_flag("corvin_beigetreten", true)
	_erwarte(GameState.offene_lagerszenen() == ["corvin"], "neuer Gefährte hat eine offene Lagerszene")
	GameState.akt_wechseln(2)
	_erwarte(GameState.offene_lagerszenen() == ["corvin"], "verpasste Lagerszene wird im nächsten Akt nachgeholt")
	GameState.lagerszene_gezeigt("corvin")
	_erwarte(GameState.offene_lagerszenen().is_empty(), "gezeigte Lagerszene ist erledigt")
	GameState.aus_dict(vorher)

func _erwarte(ok: bool, was: String) -> void:
	if ok: print("ok       " + was)
	else: _fehler("Laufzeittest: " + was)

# ---------- 5. Szenarien ----------
func _pruefe_szenarien() -> void:
	print("\n-- Szenarien --")
	if not DirAccess.dir_exists_absolute(Zustaende.SZENARIEN): return
	var erlaubt := ["ren"] + Zustaende.gefaehrten()
	for f in DirAccess.get_files_at(Zustaende.SZENARIEN):
		if not f.ends_with(".json"): continue
		var d := Zustaende.szenario(f)
		if d.is_empty(): _fehler("%s: nicht lesbar" % f); continue
		var flags: Dictionary = d.get("flags", {})
		var lese := func(n): return Zustaende.normalisiere(flags[n]) if flags.has(n) else Zustaende.standard(n)
		var vorher := fehler
		for n in flags:
			var w = Zustaende.normalisiere(flags[n])
			var t := Zustaende.pruefe_wert(n, w)
			if t == "": t = Zustaende.pruefe_voraussetzungen(n, w, lese)
			if t != "": _fehler("%s: %s" % [f, t])
		for g in d.get("gruppe", []):
			if not (g in erlaubt): _fehler("%s: unbekanntes Gruppenmitglied „%s“" % [f, g])
		if d.get("gruppe", []).size() > 4: _fehler("%s: mehr als vier Figuren in der Gruppe" % f)
		if fehler == vorher: print("ok       %s – %s" % [f.trim_suffix(".json"), d.get("titel", "")])
