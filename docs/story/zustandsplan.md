# Meow York – Zustandsplan

Stand: 13.11.2026 · Grundlage für Tests in Godot. Die maschinenlesbare Fassung liegt im Repository unter `data/zustaende/zustaende.json`, die Bedienung steht in `docs/zustaende.md`. Beide Dateien beschreiben dieselben Variablen. Bei Änderungen wird zuerst die JSON-Datei angepasst.

---

## Grundregeln

1. **Spätere Szenen lesen nur Zustände, nie einzelne Dialogzeilen.** Ein Gespräch darf eine Variable setzen. Was gesagt wurde, interessiert danach niemanden mehr.
2. **Jede Variable hat einen Standardwert.** Wer nichts tut, bekommt den Standard. Es gibt keinen undefinierten Zustand.
3. **Jede Variable wird an festen Stellen gesetzt und an festen Stellen gelesen.** Beides steht in der Tabelle. Was dort nicht steht, darf die Variable nicht anfassen.
4. **Quest-Ausgänge werden einmal gesetzt und dann nicht mehr verändert.**
5. **Zusätze lesen, setzen aber nichts Wichtiges.** Paarmomente, Gefährten-Kommentare und „Muster erkannt“ dürfen fehlen, ohne dass etwas bricht. Ausnahme: `held_hebel_genutzt`, markiert als Zusatz, der gestrichen werden kann.
6. **Abgeleitete Werte werden berechnet, nicht gespeichert.** Zum Beispiel `unruhen_hairlem` aus `naeherinnen`.

---

## Point of no Return: Wie keine Quest verfällt

**Das Problem:** Nach jedem Akt gibt es kein Zurück. Ein Quest-Teil, der in Hairlem spielt, kann nicht mehr erledigt werden, wenn der Spieler in die Subfurs geht.

**Die Lösung hat vier Teile:**

1. **Persönliche Quests sind Ketten aus Kapiteln, ein Kapitel pro Akt.** Corvins Quest hat ein Kapitel in Hairlem (Tauben), eins in den Subfurs (Musterbuch), eins auf Boney Island (Vale) und eins in Cathattan (Prozess). Nur das jeweilige Kapitel ist an sein Areal gebunden, nie die ganze Quest.
2. **„Verpasst“ ist ein gültiger Ausgang.** Wer ein Kapitel nicht erledigt, scheitert nicht. Beim Aktübergang bekommt das Kapitel automatisch den Wert `verpasst`, und die Kette läuft mit diesem Wert weiter. Beispiel: Tauben-Quest nicht gemacht → `tauben = verpasst` → der Züchter behält sein Netz, in Akt 4 hilft nur Hazels Begnadigung. Die Geschichte geht weiter, nur anders. Das ist auch erzählerisch ehrlich: Verpasste Gelegenheiten haben Folgen.
3. **Warnung vor dem Übergang.** Vor jedem Point of no Return zeigt das Spiel offene Kapitel, als Kommentar der Gefährten: „Bevor wir runtergehen: Auf den Dächern ist noch was offen.“ (Corvin). Wie in BG3 vor dem Aktwechsel.
4. **Figuren und Dinge wandern mit.** Wo es passt, zieht der Inhalt mit dem Spieler: Pip wird nach Boney Island gebracht, Tauben fliegen überall hin, Malcolm taucht in jedem Akt auf, die Weberin trägt ihr Musterbuch bei sich. So bleibt manches auch nach einem verpassten Kapitel erreichbar, in veränderter Form.

**Für die Tests heißt das:** Jeder Kapitelwert hat höchstens vier Zustände, einer davon ist `verpasst`. Der Aktübergang ist eine Funktion, die alle offenen Kapitel auf `verpasst` setzt und abgeleitete Werte neu berechnet. Diese Funktion ist der wichtigste Testpunkt des ganzen Spiels.

---

## Zahlen

- **Variablen insgesamt:** 75
- **Davon Grundwerte der Gefährten:** 27 (je Gefährte: in der Gruppe, Zuneigung, Knoten)
- **Story-Variablen:** 48

Das sind die Zustände, die du testest. Nicht Millionen Wege, sondern diese Tabelle.

---

## Grundwerte je Gefährte

Gilt für dig, corvin, shiner, knuckles, weberin, barkley, deltamae, mercy, fitz.

| Variable | Typ | Werte | Standard | Gelesen von |
| --- | --- | --- | --- | --- |
| `<gefährte>_in_gruppe` | bool | ja, nein | nein | Szenen, Paarmomente |
| `<gefährte>_zuneigung` | enum | niedrig, mittel, hoch | mittel | Quest-Ausgänge, Romanzen, Finale |
| `<gefährte>_knoten` | bool | ja, nein | nein | Finale: kann Pfötchen ihn wenden? |

## Welt

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `akt` | 1–5 (5 = Finale) | 1 | Aktübergang | überall | alle |  |
| `gang_wahl` | keine, breaking_cats, nomapes | keine | Hauptquest A1: Gang-Wahl | Gefährte Shiner/Knuckles, Finale (Gangs) | 1 |  |
| `tauben` | offen, netz_genutzt, befreit, verpasst | offen | Corvin K1 (Tauben-Quest) | Corvin K4 (Beweise), Finale (Taubennetz), Juno-Spur A1 | 1 | verpasst = Züchter behält Netz, keine Hilfe im Finale; beim Aktübergang: offen → verpasst |
| `naeherinnen` | offen, befreit, zurueckgelassen, verpasst | offen | Weberin K2 | unruhen_hairlem, Pfötchen-Gegenzüge, Nebenwirkungs-Begegnungen A3–A4 | 2 | verpasst wirkt wie zurueckgelassen; beim Aktübergang: offen → verpasst |
| `unruhen_hairlem` | ja, nein | nein | abgeleitet: naeherinnen == befreit | hazel_status (früher unter Druck), Benny-Gefahr A4 | 2–4 |  |
| `pfoetchen_gegenzuege` | 0–5 je Akt | 3 | Aktbeginn; +1 wenn unruhen_hairlem | Gegenzug-Ereignisse | 2–4 |  |
| `vale` | lebt, vor_gericht, tot | lebt | Barkley K4 / Corvin K4 | rook, Corvin-Ausgang, Barkley-Ausgang | 4 |  |
| `rook` | in_haft, frei | in_haft | Corvin K4 | Epilog, Tauben im Finale | 4 |  |
| `malcolm_risse` | 0–3 | 0 | Corvin misstraut (+1), Gang-Enttarnung (+1), Weberin-Gespräch (+1) | Malcolm-Szenen A3, Erlösungsmöglichkeit A4 | 1–4 |  |
| `hazel_status` | ahnungslos, wissend, verraten | ahnungslos | mercy_akten / Hauptquest A4 | Hazel-Szenen, Finale, Pfötchens Leitung | 3–4 | verraten = Knoten gerutscht, unlenkbar |
| `held_anknuepfen` | 0–n | 0 | jedes Anknüpfen | Fadensicht-Freischaltung, Finale (Ende ‚Der Sohn‘) | 2–4 |  |
| `held_hebel_genutzt` | 0–n | 0 | Muster erkannt → Nutzen | Zuneigung aller, Gefährten-Kommentare, Finale | 1–4 | ZUSATZ: kann gestrichen werden |

## Juno

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `juno_kontakt` | ja, nein | nein | Fitz K3 (Bote) | Juno-Szenen A3–A4 | 3 |  |
| `juno_knoten_lager` | 0–3 | 0 | +1 shiner_galerie angenommen, +1 deltamae_lager_auftritt, +1 fitz_show geflogen | Weberin kann Juno nur auftrennen wenn < 2 | 3 |  |
| `juno_offenheit` | -2–+2 | 0 | Mercy-Urteil (hart −1 / gnädig +1), Delta-Mae-Szene (+1), Held-Szenen | juno_bogen | 3–4 |  |
| `juno_bogen` | verloren, frei_bleibt, frei_kommt_mit | verloren | A4 berechnet aus juno_offenheit, Auftrennung, Kindheitsszenen | Finale (Gastfigur), Epilog | 4 |  |

## Big Dig

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `dig_k2_wendung` | zurueckgeholt, verlassen | verlassen | Big Dig K2 (abhängig von dig_knoten) | dig_in_gruppe A2–A3 | 2 |  |
| `dig_fitz_einsicht` | ja, nein | nein | Bogen Big Dig/Fitz A3 | dig_ausgang (Voraussetzung neu_verknotet) | 3 |  |
| `dig_pip_szenen` | 0–3 | 0 | Big Dig K3 Strand-Szenen | dig_ausgang | 3 |  |
| `dig_ausgang` | neu_verknotet, entfuehrt, losgelassen | losgelassen | Big Dig K4 | Finale (Tunnel / fehlt / wendbar) | 4 | neu_verknotet braucht dig_fitz_einsicht UND (pip_szenen==3 ODER 'pip' in weberin_auftrennungen) |

## Corvin

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `corvin_k2_musterbuch` | ja, nein | nein | Corvin K2 | Corvin-Stimmbruch, Weberin-Bogen | 2 |  |
| `corvin_vale_ermittlung` | offen, gemeinsam, allein, verpasst | offen | Corvin K3 mit Barkley | vale, Bogen Corvin/Barkley | 3 | beim Aktübergang: offen → verpasst |
| `corvin_ausgang` | ganze_wahrheit, halbe_wahrheit, keine_wahrheit | keine_wahrheit | Corvin K4 | Finale (Taubennetz / wendbar) | 4 | Beweise: tauben==netz_genutzt ODER Hazel-Begnadigung |

## Shiner

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `shiner_k2_station` | ja, nein | nein | Shiner K2 | Weberin-Kommentar, shiner_ausgang | 2 |  |
| `shiner_galerie` | offen, angenommen, abgelehnt, verpasst | offen | Shiner K3 | juno_knoten_lager, Bogen Shiner/Delta Mae | 3 | beim Aktübergang: offen → verpasst |
| `shiner_uebermalt_gestanden` | ja, nein | nein | Bogen Shiner/Corvin A3 | shiner_galerie (Ablehnung leichter) | 3 |  |
| `shiner_ausgang` | knotenmalerin, ausverkauft, einzelgaengerin | einzelgaengerin | Shiner K4 | Ende ‚Verknotung‘ | 4 |  |

## Knuckles

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `knuckles_nugget` | offen, enttarnt, gedeckt, verpasst | offen | Knuckles K2–K4 | knuckles_ausgang | 2–4 | verpasst wirkt wie gedeckt; beim Aktübergang: offen → verpasst |
| `knuckles_vertrag` | behalten, gekuendigt | behalten | Knuckles K3 | knuckles_ausgang | 3 |  |
| `knuckles_luege_gebeichtet` | ja, nein | nein | Bogen Knuckles/Big Dig A3 | knuckles_zuneigung | 3 |  |
| `knuckles_ausgang` | nachfolgerin, geschaeftsfrau, treue_nichte | treue_nichte | Knuckles K4 | Finale (Gangs) | 4 |  |

## Weberin

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `weberin_auftrennungen` | juno, tauben, gangs, garde, pip | leer | Weberin K4 (max. 2) | Juno-Bogen, Gangs, Barkley-Plan, Big-Dig-Ausgang | 4 | nur wenn weberin_ausgang != verweigerin |
| `weberin_luege_gestanden` | ja, nein | nein | Bogen Weberin/Corvin A3 oder Mercy-Akten | mercy_weberin_behandelt, Auftrennung pip | 3 |  |
| `weberin_ausgang` | hueterin, zerstoererin, verweigerin | verweigerin | Weberin K4 | Finale (Ketten lockern), Ende ‚Wegsperren‘/‚Zerstörung‘ | 4 |  |

## Barkley

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `barkley_befreiung` | natuerlich, inszeniert | natuerlich | Barkley K2 | Zuneigung mehrerer, Gefährten-Kommentare | 2 |  |
| `barkley_zweite_schlinge` | keine, fitz, deltamae | keine | Bögen Barkley/Fitz bzw. Barkley/Delta Mae | barkley_ausgang, Finale (über wen Pfötchen greift) | 3–4 |  |
| `barkley_verrate_inszeniert` | ja, nein | nein | Barkley K3 | Zuneigung, barkley_ausgang | 3 |  |
| `barkley_ausgang` | mehr_als_eine_liebe, fanatiker, raecher | fanatiker | Barkley K4 | Finale, Epilog | 4 | mehr_als_eine_liebe braucht zweite_schlinge != keine |

## Delta Mae

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `deltamae_pakt` | fremde_stimme, eigene_stimme, andere_loesung | eigene_stimme | Delta Mae K2 | Zuneigung, Finale (Stimme behalten?) | 2 |  |
| `deltamae_lager_auftritt` | ja, nein | nein | Delta Mae K3 | juno_knoten_lager, Bogen Shiner/Delta Mae | 3 |  |
| `deltamae_ausgang` | ehrliches_lied, legende, verkaufte | legende | Delta Mae K4 | Finale (letztes Lied) | 4 |  |

## Mercy

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `mercy_urteil_juno` | hart, gnaedig | hart | Mercy K3 | juno_offenheit | 3 |  |
| `mercy_weberin_behandelt` | ja, nein | nein | Mercy K3 | Auftrennung pip möglich | 3 |  |
| `mercy_akten` | ordensrat, presse_hazel, zurueckgehalten | zurueckgehalten | Mercy K4 | hazel_status, mercy_ausgang | 4 |  |
| `mercy_ausgang` | reformerin, abtruennige, schweigende | schweigende | Mercy K4 | Finale | 4 |  |

## Fitz

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `fitz_show` | geflogen, sabotiert, umgedeutet | geflogen | Fitz K3 | juno_knoten_lager, Zirkus-Vertrag | 3 |  |
| `fitz_weberin_trost` | ja, nein | nein | Bogen Fitz/Weberin A4 | fitz_ausgang | 4 |  |
| `fitz_ausgang` | letzter_flug, trotzig, bodenstaendig | trotzig | Fitz K4 | Finale | 4 | letzter_flug braucht fitz_weberin_trost |

---

## Was Godot automatisch prüfen soll

Diese Prüfungen reparieren nichts. Sie melden nur, wo etwas nicht stimmt. Sie laufen bei jedem Start im Editor oder als eigener Testlauf.

1. **Unbekannte Variable:** Ein Dialog oder eine Quest liest oder setzt eine Variable, die nicht in `meow_york_zustaende.json` steht. Häufigster Fehler: Tippfehler.
2. **Ungültiger Wert:** Eine Variable wird auf einen Wert gesetzt, der nicht in ihrer Werteliste steht.
3. **Nie gesetzt:** Eine Variable wird irgendwo gelesen, aber nirgends gesetzt.
4. **Nie gelesen:** Eine Variable wird gesetzt, aber nirgends gelesen. Dann ist sie überflüssig oder es fehlt eine Wirkung.
5. **Unerreichbare Dialogknoten:** Knoten, zu denen kein Weg führt.
6. **Sackgassen:** Knoten ohne Ausgang, die kein Gesprächsende sind.
7. **Ausgang doppelt gesetzt:** Ein Quest-Ausgang wird an zwei Stellen gesetzt (verstößt gegen Grundregel 4).
8. **Aktübergang vollständig:** Nach dem Übergang hat jedes Kapitel des alten Akts einen Wert, keins ist mehr `offen`.

**Testbot:** Ein Skript spielt Dialoge tausendfach mit zufälligen Antworten durch und meldet Abstürze, Sackgassen und Variablen außerhalb ihrer Werte. Das kann über Nacht laufen.

---

## Szenario-Spielstände für das Debug-Menü

Mit diesen Spielständen springst du direkt an kritische Stellen, ohne 40 Stunden zu spielen. Das Debug-Menü sollte jede Variable aus der JSON-Datei setzen können.

| Nr. | Startpunkt | Gesetzte Zustände | Was getestet wird |
| --- | --- | --- | --- |
| 1 | Ende Akt 1 | alles `offen` | Aktübergang setzt alles auf `verpasst` |
| 2 | Akt 2, Big Dig K2 | dig_knoten = false | Big Dig verlässt die Gruppe, kehrt in A3 zurück |
| 3 | Akt 2, Weberin K2 | naeherinnen = befreit | Unruhen, Hazel unter Druck, mehr Gegenzüge |
| 4 | Akt 3, Lager | shiner_galerie = angenommen, deltamae_lager_auftritt = true, fitz_show = geflogen | juno_knoten_lager = 3, Juno nicht mehr auftrennbar |
| 5 | Akt 4, Brücke | corvin + barkley in Gruppe, vale = lebt | gemeinsame Konfrontation, Prozess möglich |
| 6 | Akt 4, Brücke | nur barkley in Gruppe | Barkley greift sofort an, vale = tot |
| 7 | Akt 4, Finale | alle Ausgänge auf Standard | „schlechtester“ Durchlauf ohne Abstürze |
| 8 | Akt 4, Finale | alle Ausgänge optimal | Ende „Verknotung“ erreichbar |
| 9 | Akt 4, Finale | barkley_zweite_schlinge = fitz, fitz_knoten = false | Pfötchen greift Barkley über Fitz |
| 10 | Akt 4, Hazel | mercy_akten = presse_hazel | Hazel weiß früher Bescheid, Pfötchen verliert Leitung früh |

---

## Testfiguren

Statt alle Kombinationen zu spielen, spielst du sechs typische Spieler komplett durch. Die Fälle dazwischen decken die automatischen Prüfungen und Szenario-Spielstände ab.

1. **Der Gutmensch:** erledigt alles, hilft allen, knüpft viele Knoten. Erwartet: optimale Ausgänge, Ende „Verknotung“ möglich.
2. **Der Eilige:** folgt nur der Hauptquest. Erwartet: fast alles `verpasst`, Standardausgänge, das Spiel bleibt trotzdem schlüssig.
3. **Der Zyniker:** nutzt jeden Hebel, inszeniert Verrate, lügt. Erwartet: niedrige Zuneigung, viele Gefährten wendbar im Finale.
4. **Der Abrechner:** will Pfötchen vernichten, tötet Vale, gibt die Akten der Presse. Erwartet: Ende „Der Richter“, Chaos im Epilog.
5. **Der Vernachlässiger:** hat immer dieselben drei Gefährten dabei. Erwartet: die anderen bleiben bei Standardwerten, ihre Szenen funktionieren trotzdem.
6. **Der Wechsler:** wechselt die Gruppe ständig. Erwartet: viele Paarmomente, keine Widersprüche in Kommentaren.

---

## Streichliste

Was wegfallen kann, ohne dass etwas bricht, falls die Zeit knapp wird:

1. Paarmomente (reiner Zusatz)
2. „Muster erkannt“ mit `held_hebel_genutzt`
3. Nebenwirkungen der schlampigen Näherinnen
4. Die graue Variante der Barkley-Befreiung
5. Die dritte Strand-Szene mit Pip (`dig_pip_szenen` maximal 2)

Nicht streichbar, weil andere Bögen daran hängen: `dig_fitz_einsicht`, `barkley_zweite_schlinge`, `juno_knoten_lager`, `weberin_luege_gestanden`, `fitz_weberin_trost`.
