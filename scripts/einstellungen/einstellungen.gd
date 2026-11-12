extends Node
## Einstellungen: Effekt- und Grafikschalter wie die Knopfleiste im Prototyp
## (Unschärfe, Bloom, Spiegelungen, Regen, Iso-Kamera). Werden in user://einstellungen.cfg gemerkt.
## Andere Systeme lesen die Werte und hören auf EventBus.einstellung_geaendert.

const DATEI := "user://einstellungen.cfg"

var werte := {"unschaerfe": true, "bloom": true, "spiegelungen": true, "fps_anzeigen": false}
## Regen ist Teil der Szene (die Geschichte schaltet ihn), wird aber hier gehalten,
## damit Knopf, Wetter und Spiegelungen denselben Zustand sehen. Nicht gespeichert.
var regen := false

func _ready() -> void:
	var c := ConfigFile.new()
	if c.load(DATEI) == OK:
		for k in werte: werte[k] = c.get_value("grafik", k, werte[k])

func an(name: String) -> bool:
	if name == "regen": return regen
	return bool(werte.get(name, false))

func setze(name: String, wert: bool) -> void:
	if name == "regen":
		regen = wert
	else:
		werte[name] = wert
		var c := ConfigFile.new()
		for k in werte: c.set_value("grafik", k, werte[k])
		c.save(DATEI)
	EventBus.einstellung_geaendert.emit(name)

func umschalten(name: String) -> void:
	setze(name, not an(name))
