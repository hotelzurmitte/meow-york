class_name Zustaende
extends RefCounted
## Zustandsregister: lädt data/zustaende/zustaende.json und prüft Story-Variablen.
## Gespeichert wird weiterhin nur in GameState.flags – GameState bleibt die einzige Quelle.
## Prüfwerkzeug: godot --headless --path . res://tools/pruefe_zustaende.tscn

const PFAD := "res://data/zustaende/zustaende.json"
const SZENARIEN := "res://data/zustaende/szenarien/"

static var _register: Dictionary = {}   ## name -> Eintrag aus der JSON-Datei
static var _prototyp: Dictionary = {}   ## Flags aus dem Prototyp (geduldet, ohne Werteprüfung)
static var _gefaehrten: Array = []
static var _geladen := false

static func laden() -> void:
	if _geladen: return
	_geladen = true
	var d = JSON.parse_string(FileAccess.get_file_as_string(PFAD))
	if typeof(d) != TYPE_DICTIONARY:
		push_error("Zustandsregister nicht lesbar: " + PFAD)
		return
	for v in d.get("variablen", []): _register[v.name] = v
	for p in d.get("prototyp_flags", []): _prototyp[p] = true
	_gefaehrten = d.get("gefaehrten", [])

# ---------- Abfragen ----------
static func hat(name: String) -> bool:
	laden(); return _register.has(name)

static func ist_prototyp(name: String) -> bool:
	laden(); return _prototyp.has(name)

static func bekannt(name: String) -> bool:
	return hat(name) or ist_prototyp(name)

static func eintrag(name: String) -> Dictionary:
	laden(); return _register.get(name, {})

static func alle() -> Array:
	laden(); return _register.values()

static func gefaehrten() -> Array:
	laden(); return _gefaehrten

static func prototyp_flags() -> Array:
	laden(); return _prototyp.keys()

static func ist_abgeleitet(name: String) -> bool:
	return eintrag(name).has("abgeleitet")

## Standardwert (Listen als Kopie, Zahlen als int)
static func standard(name: String):
	var s = eintrag(name).get("standard")
	if typeof(s) == TYPE_ARRAY: return s.duplicate()
	if typeof(s) == TYPE_FLOAT and s == floor(s): return int(s)
	return s

## Variablen, die am Ende von `akt` von „offen“ auf „verpasst“ fallen
static func verfallende(akt: int) -> Array:
	var r := []
	for e in alle():
		if e.has("verfaellt_nach_akt") and int(e.verfaellt_nach_akt) == akt: r.append(e.name)
	return r

# ---------- Prüfungen (geben einen Fehlertext zurück, leer = in Ordnung) ----------
static func pruefe_wert(name: String, wert) -> String:
	laden()
	if not _register.has(name):
		return "" if _prototyp.has(name) else "unbekannte Variable „%s“ (nicht im Zustandsregister)" % name
	var e: Dictionary = _register[name]
	if e.has("abgeleitet"):
		return "„%s“ ist abgeleitet (%s) und wird nicht gesetzt" % [name, e.abgeleitet]
	match String(e.typ):
		"bool":
			if typeof(wert) != TYPE_BOOL: return "„%s“ erwartet ja/nein, bekam %s" % [name, str(wert)]
		"int":
			if not (typeof(wert) in [TYPE_INT, TYPE_FLOAT]) or float(wert) != floor(float(wert)):
				return "„%s“ erwartet eine ganze Zahl, bekam %s" % [name, str(wert)]
			if e.get("min") != null and float(wert) < float(e.min): return "„%s“ = %s liegt unter %s" % [name, str(wert), str(e.min)]
			if e.get("max") != null and float(wert) > float(e.max): return "„%s“ = %s liegt über %s" % [name, str(wert), str(e.max)]
		"enum":
			if typeof(wert) != TYPE_STRING or not (wert in e.werte):
				return "„%s“ = %s ist kein erlaubter Wert (%s)" % [name, str(wert), ", ".join(e.werte)]
		"liste":
			if typeof(wert) != TYPE_ARRAY: return "„%s“ erwartet eine Liste" % name
			for w in wert:
				if not (w in e.werte): return "„%s“ enthält „%s“, erlaubt: %s" % [name, str(w), ", ".join(e.werte)]
			if e.has("max_eintraege") and wert.size() > int(e.max_eintraege):
				return "„%s“ hat %d Einträge, erlaubt sind %d" % [name, wert.size(), int(e.max_eintraege)]
		_:
			return "„%s“ hat einen unbekannten Typ „%s“ im Register" % [name, e.typ]
	return ""

## Einmal-Regel: Quest-Ausgänge werden einmal gesetzt und dann nicht mehr verändert
static func pruefe_einmal(name: String, alt, neu) -> String:
	var e := eintrag(name)
	if not e.get("einmal", false) or alt == null: return ""
	if alt == standard(name) or alt == neu: return ""
	return "„%s“ ist schon auf „%s“ gesetzt und darf sich nicht mehr ändern (neu: „%s“)" % [name, str(alt), str(neu)]

## Voraussetzungen eines Werts. `lese` liefert den aktuellen Wert einer Variable.
static func pruefe_voraussetzungen(name: String, wert, lese: Callable) -> String:
	var vs: Dictionary = eintrag(name).get("voraussetzungen", {})
	var liste: Array = vs.get(str(wert), []) + vs.get("*", [])
	for b in liste:
		var ist = lese.call(b[0])
		var ok: bool = _gleich(ist, b[2]) if b[1] == "==" else not _gleich(ist, b[2])
		if not ok:
			return "„%s“ = „%s“ verlangt %s %s %s (ist: %s)" % [name, str(wert), b[0], b[1], str(b[2]), str(ist)]
	return ""

static func _gleich(a, b) -> bool:
	if typeof(a) in [TYPE_INT, TYPE_FLOAT] and typeof(b) in [TYPE_INT, TYPE_FLOAT]: return float(a) == float(b)
	return typeof(a) == typeof(b) and a == b

## JSON liefert Zahlen als float – ganze Zahlen zurück in int verwandeln
static func normalisiere(wert):
	if typeof(wert) == TYPE_FLOAT and wert == floor(wert): return int(wert)
	return wert

## Liest einen Test-Spielstand (data/zustaende/szenarien/<name>.json)
static func szenario(name: String) -> Dictionary:
	var pfad := SZENARIEN + name.trim_suffix(".json") + ".json"
	if not FileAccess.file_exists(pfad):
		push_error("Szenario nicht gefunden: " + pfad)
		return {}
	var d = JSON.parse_string(FileAccess.get_file_as_string(pfad))
	return d if typeof(d) == TYPE_DICTIONARY else {}
