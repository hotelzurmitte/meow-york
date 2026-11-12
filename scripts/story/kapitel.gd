extends Node
## Kapitel: verbindet Dialoge mit Spielablauf (Kämpfe, Zwischensequenzen).
## Dialoge rufen Funktionen hierüber auf, z. B. `do Kapitel.kampf([...], "Name")`.

signal kampf_beendet(gewonnen: bool)

## Rundenkampf – das Kampfsystem wird erst in Phase 3 übertragen.
## Bis dahin gilt ein Kampf als gewonnen, damit die Geschichte weiterläuft.
func kampf(gegner: Array, name := "") -> void:
	EventBus.hinweis.emit("Kampf: %s (Kampfsystem folgt – gilt vorerst als gewonnen)" % name, "info")
	EventBus.ereignis.emit("kampf:" + name)
	GameState.set_flag("letzter_kampf_gewonnen", true)
	await get_tree().create_timer(0.6).timeout
	kampf_beendet.emit(true)
