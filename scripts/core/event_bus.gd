extends Node
## Die Signale werden von anderen Systemen gesendet (EventBus.x.emit), nie hier selbst –
## daher die Warnung UNUSED_SIGNAL für diese Datei abschalten.
@warning_ignore_start("unused_signal")
## EventBus: nur Signale, keine Logik. Systeme melden sich hier, statt sich gegenseitig zu kennen.

signal flag_geaendert(name: String, wert)
signal geld_geaendert(wert: int)
signal quest_geaendert(id: String)
signal hinweis(text: String, art: String)        ## kurze Einblendung („quest“, „gut“, „schlecht“, „info“)
signal meldung(text: String)                     ## Text in der Bildmitte (z. B. Bereichsname)
signal dialog_gestartet(sprecher: Node)
signal dialog_beendet()
signal ereignis(name: String)                    ## Kampf, Zwischensequenz, Szenenwechsel usw.
signal bereich_betreten(name: String)
signal lp_geaendert()                            ## Lebenspunkte der Gruppe
signal einstellung_geaendert(name: String)      ## Grafik-/Effektschalter (Einstellungen)
