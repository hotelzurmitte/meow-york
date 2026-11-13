# Zustandsregister und Prüfungen

Alle Story-Variablen von Meow York stehen in `data/zustaende/zustaende.json`: Name, Typ, erlaubte Werte, Standardwert, wo sie gesetzt und wo sie gelesen werden. Gespeichert werden die Werte wie bisher in `GameState.flags`. Den vollständigen Plan mit Begründungen gibt es als Dokument „Meow York – Zustandsplan“.

## Regeln

- Neue Variablen zuerst ins Register eintragen, dann im Dialog oder Skript verwenden.
- Gesetzt wird nur über `GameState.set_flag(name, wert)`, gelesen über `GameState.flag(name)`. Nicht gesetzte Story-Variablen liefern ihren Standardwert aus dem Register.
- Quest-Ausgänge (`einmal: true`) werden einmal gesetzt und danach nicht mehr verändert.
- Abgeleitete Werte (`abgeleitet`) werden berechnet und nie gesetzt: `<gefährte>_in_gruppe`, `<gefährte>_zuneigung`, `unruhen_hairlem`.
- Flags aus dem Prototyp stehen in `prototyp_flags` und werden ohne Werteprüfung geduldet.

## Point of no Return

`GameState.akt_wechseln(neuer_akt)` setzt alle Kapitel des alten Akts, die noch `offen` sind, auf `verpasst` und erhöht `akt`. Welche Kapitel betroffen sind, steht im Register unter `verfaellt_nach_akt`. Akt 5 ist das Finale.

## Prüfwerkzeug

```
godot --headless --path . res://tools/pruefe_zustaende.tscn
godot --headless --path . res://tools/pruefe_zustaende.tscn -- --ausfuehrlich
```

Es repariert nichts und meldet nur. Ende mit Code 1 bei Fehlern.

- **FEHLER:** unbekannte Variable (meist ein Tippfehler), Wert nicht erlaubt, abgeleitete Variable gesetzt, Vergleich mit einem Wert, den es nicht gibt, fehlerhafter Registereintrag, Aktübergang lässt ein Kapitel offen, kaputtes Szenario.
- **WARNUNG:** gelesen, aber nie gesetzt; gesetzt, aber nie gelesen; Ausgang an mehreren Stellen gesetzt. Warnungen zu Prototyp-Flags werden zusammengefasst, einzeln mit `--ausfuehrlich`.
- **HINWEIS:** wie viele Story-Variablen noch nirgends eingebaut sind.

Im Debug-Build warnt außerdem `GameState.set_flag` beim Spielen, wenn ein Wert nicht passt, ein Ausgang sich ändert oder eine Voraussetzung fehlt.

## Szenario-Spielstände

Test-Spielstände liegen in `data/zustaende/szenarien/`. Laden beim Start:

```
godot --path . -- --szenario=08_finale_optimal
```

Jede Datei hat `titel`, `erwartet` (was man prüfen soll), `gruppe`, `flags` und optional `zuneigung` und `spawn`. Das Prüfwerkzeug kontrolliert alle Szenarien mit.
