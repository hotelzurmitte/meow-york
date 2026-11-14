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

## Point of no Return: Wie keine Geschichte verloren geht

Nach jedem Akt gibt es kein Zurück. Damit trotzdem kein Bogen verloren geht und niemand gezwungen ist, Gefährtenquests genau dann zu machen, wenn ein Areal offen ist, gilt das Prinzip von BG3: **Die Geschichte kommt zum Spieler.**

1. **Pflicht-Lagerszenen:** Jeder Gefährte hat pro Akt eine Lagerszene bei der langen Rast im Unterschlupf. Sie lässt sich nicht verpassen. Wurde sie bis zum Aktende nicht gezeigt, wird sie im nächsten Akt nachgeholt (`<gefährte>_lagerszene`, `offene_lagerszenen()`). Die Einstiege der Gefährten sind solche Szenen, etwa Corvin mit seinem Notizbuch.
2. **Zeitfenster über zwei Akte:** Ortsgebundene Kapitel verfallen erst nach dem zweiten Akt ihres Fensters (`verfaellt_nach_akt`). Beispiel: Den Taubenzüchter findet man in Hairlem oder, per Botentaube, in den Subfurs.
3. **Mitwandernde Figuren:** Taubenzüchter, Pip, Captain Vale, Lucien und die Botin der Näherinnen ziehen mit, so wie Dammon in BG3.
4. **Hauptmomente auf dem Hauptweg:** Die wichtigen Szenen der Gefährten liegen an den Knotenpunkten jedes Akts, wo der Spieler ohnehin hinkommt.
5. **„Verpasst“ nur für Nebenzweige:** Erst nach Ablauf des Fensters setzt `akt_wechseln()` ein offenes Kapitel auf `verpasst`. Das färbt den Ausgang, nimmt aber nie den Bogen weg.
6. **Warnung vor dem Übergang:** Offene Kapitel werden als Kommentar der Gefährten angezeigt, wie in BG3.

**Für die Tests:** `akt_wechseln()` und `offene_lagerszenen()` sind die wichtigsten Testpunkte. Das Prüfwerkzeug testet beide bei jedem Lauf.

---

## Zahlen

- **Variablen insgesamt:** 158
- **Davon Grundwerte der Gefährten:** 45 (je Gefährte: beigetreten, in der Gruppe, Zuneigung, Knoten, Lagerszene)
- **Story-Variablen:** 113

Das sind die Zustände, die du testest. Nicht Millionen Wege, sondern diese Tabelle.

---

## Grundwerte je Gefährte

Gilt für dig, corvin, shiner, knuckles, weberin, barkley, deltamae, mercy, fitz.

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Hinweis |
| --- | --- | --- | --- | --- | --- |
| `<gefährte>_beigetreten` | ja, nein | nein | Rekrutierung | Lange Rast (wer im Unterschlupf ist), offene_lagerszenen() | beigetreten ≠ in der aktiven Gruppe |
| `<gefährte>_in_gruppe` | ja, nein | nein | Rekrutierung / Verlassen | Szenen, Paarmomente | abgeleitet: GameState.mitglied("<gefährte>") |
| `<gefährte>_zuneigung` | niedrig, mittel, hoch | mittel | Gefährten-Reaktionen | Quest-Ausgänge, Romanzen, Finale | abgeleitet: GameState.zuneigung["<gefährte>"] (−10 bis +10): < −3 niedrig, > 5 hoch; bei −8 verlässt der Gefährte die Gruppe |
| `<gefährte>_knoten` | 0–3 | 0 | berechnet | Finale: 3 sicher, 2 schwankt (leichte Probe), 1 gewendet (schwere Probe), 0 gewendet für die ganze Phase | Knotenstärke: wie viel der Schlinge zum Helden zugenäht ist |
| `<gefährte>_lagerszene` | 0–4 | 0 | Pflicht-Lagerszene des Akts (Wert = Akt) | offene_lagerszenen() | Akt der zuletzt gezeigten Pflicht-Lagerszene; fehlende werden im nächsten Akt nachgeholt |

## Welt

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `akt` | 1–5 (5 = Finale) | 1 | Aktübergang | überall | alle | 5 = Finale (nach dem letzten Point of no Return) |
| `gang_wahl` | keine, breaking_cats, nomapes | keine | Hauptquest A1: Gang-Wahl | Gefährte Shiner/Knuckles, Finale (Gangs) | 1 |  |
| `tauben` | offen, netz_genutzt, befreit, verpasst | offen | Corvin K1 (Tauben-Quest) | Corvin K4 (Beweise), Finale (Taubennetz), Juno-Spur A1 | 1–2 | Fenster Akt 1–2 (A2: Botentaube in die Subfurs); verpasst = Züchter behält Netz, keine Hilfe im Finale; beim Aktübergang: offen → verpasst |
| `naeherinnen` | offen, befreit, zurueckgelassen, verpasst | offen | Weberin K2 | unruhen_hairlem, Pfötchen-Gegenzüge (blinde Pflege), Fehlgriff-Begegnungen A3–A4 | 2–3 | Fenster Akt 2–3 (A3: Botin findet die Gruppe auf Boney Island); verpasst wirkt wie zurueckgelassen; beim Aktübergang: offen → verpasst |
| `unruhen_hairlem` | ja, nein | nein | abgeleitet: naeherinnen == befreit | hazel_status (früher unter Druck), Gefahr für Hazels Anhänger wie Benny in A4 | 2–4 | abgeleitet: GameState.flag("naeherinnen") == "befreit" |
| `pfoetchen_gegenzuege` | 0–5 | 3 | Aktbeginn; +1 wenn unruhen_hairlem | Gegenzug-Ereignisse | 2–4 |  |
| `vale` | lebt, vor_gericht, tot | lebt | Barkley K4 / Corvin K4 | Barkley-Ausgang, Riffs Schicksal, Epilog | 4 | einmal setzen |
| `rook` | in_haft, frei | in_haft | Corvin K4 | Epilog, Tauben im Finale | 4 | einmal setzen |
| `malcolm_risse` | 0–3 | 0 | Corvin misstraut (+1), Gang-Enttarnung (+1), Weberin-Gespräch (+1) | Malcolm-Szenen A3, Erlösungsmöglichkeit A4 | 1–4 |  |
| `hazel_status` | ahnungslos, wissend, verraten | ahnungslos | mercy_akten / Hauptquest A4 | Hazel-Szenen, Finale, Pfötchens Leitung | 3–4 | verraten = Knoten gerutscht, unlenkbar |
| `held_anknuepfen` | 0–n | 0 | jedes Anknüpfen | Fadensicht-Freischaltung, Finale (Ende ‚Der Sohn‘) | 2–4 |  |
| `held_verwachsung` | 0–10 | 0 | jedes Anknüpfen (steigt mit Dauer und Aufmerksamkeit) | Gefahr der Einwebung, Ende ‚Einwebung‘ | 2–5 | Regelwerk D2: Risiko, dauerhaft eingesponnen zu werden |
| `knaeuel_aufmerksamkeit` | 0–10 | 0 | + bei jedem Anknüpfen, − mit der Zeit (lange Rast) | Pfötchens Gegenzüge, held_verwachsung | 2–5 | Regelwerk D2: hohe Aufmerksamkeit löst Gegenzüge aus |
| `held_hebel_genutzt` | 0–n | 0 | Muster erkannt → Nutzen | Zuneigung aller, Gefährten-Kommentare, Finale | 1–4 | ZUSATZ: kann gestrichen werden |
| `unterschlupf` | cuckoos_nest, dig_keller, corvin_buero, ubahn_waggon, deltamae_station, acorn_wohnwagen, geisterbahn, hotel_cathattan, mercy_gemeinde, kanalzugang | cuckoos_nest | Wahl des Schlafplatzes / Aktübergang | Lange Rast (Ort und Eröffnungszeile der Lagerszenen) | alle | Hauptunterschlupf je Akt: cuckoos_nest, ubahn_waggon, acorn_wohnwagen, hotel_cathattan |
| `odile` | unbekannt, gewonnen, getaeuscht, verletzt | unbekannt | Quest 1.2 (akt1_odile.dialogue) | Weg in die Mission (Abendandacht, Aufnahme), Akt 3 (Lager) | 1 | gewonnen = ehrlich als Bruder, getaeuscht = als Bekehrungswilliger, verletzt = Helfer eingeschüchtert |
| `orden_wachsam` | 0–5 | 0 | Odile eingeschüchtert, Einbruch in die Mission, weitere Akt-1-Szenen | Listen der Garde, Gegenzüge in Akt 2 | 1–2 | wird mit GameState.erhoehen() gezählt |
| `odile_moment_gesehen` | ja, nein | nein | Quest 1.2 (Sprung ohne Anlass) | Schlägerei (Held erkennt das Muster), Corvins Notizbuch | 1 |  |
| `odile_schluessel` | ja, nein | nein | Quest 1.2 (Fingerfertigkeit 14) | Mission nachts (mission_weg = einbruch ohne Schlossprobe) | 1 |  |
| `suppenmarke` | ja, nein | nein | Quest 1.2 (Taschendiebstahl misslungen) | Mission (Suppenschlange ohne Warten) | 1 | Trostpreis: Odile hält den Helden für bedürftig |
| `schicht` | offen, angenommen, abgelehnt, verpasst | offen | Nest (Hummel) | Hummel, Zimmer 7 (als Kellner) | 1 |  |
| `mission_weg` | keiner, einladung, aufnahme, kueche, oben, unten, einbruch | keiner | Quest 1.3 | Odile, orden_wachsam | 1 |  |
| `roach` | offen, blossgestellt, erpresst, laufen_gelassen, corvin | offen | Quest 2 | Roach als Fahrer oder Informant | 1 |  |
| `mantelmann` | unbekannt, beschattet, gestellt, abgeschrieben, verpruegelt | unbekannt | Quest 3 | Big Dig, Mimi, Ansgar im Lager (Akt 3) | 1 |  |
| `zimmer7_weg` | keiner, kellner, schluessel, feuertreppe, keller, anwerbung | keiner | Quest 3 | Hummel, Ansgar erkennt ihn wieder | 1 |  |
| `ghettoblaster` | offen, gestohlen, gekauft, gewonnen, gefaelscht, zurueckgegeben | offen | Quest 4 | Ansehen, Auftrag | 1 |  |
| `fadenlos` | ja, nein | nein | Der Morgen danach (fest) | Anrede der NPCs, Listen der Garde | 1 |  |
| `gerettet` | mimi, benny, pounce | leer | Schlägerei | Big Dig (Mimi), Knuckles (Benny), Cats (Pounce) | 1 |  |
| `mimi_vertraut` | ja, nein | nein | Quest 1.1 (Hof), Big Dig | Mimi holt die Kassette, versteckt sich bei Big Dig | 1 | fällt weg, wenn Ansgar verprügelt wurde |
| `kassette` | im_geraet, geheimfach, battle_heimlich, battle_gesehen, mimi, adikatz, nugget | im_geraet | Quest 4 (Geheimfach), Battle | Ärger danach, Auftrag, Malcolm in Akt 2 | 1 | nach dem Battle ist im_geraet nicht mehr möglich (dann nugget) |
| `kassette_gesehen_von` | niemand, nugget, adikatz | niemand | Quest 4, Battle | Ärger um die Kassette; über Nugget erfährt es Malcolm | 1 |  |
| `kassette_gehoert` | ja, nein | nein | Anhören (Abspielgerät nötig) | Streit Corvin/Big Dig, Auftrag, Weberin in Akt 2 (Stimme erkannt) | 1 |  |
| `auftrag_ausgang` | offen, ausgefuehrt, vorgetaeuscht, gewarnt, doppelt, nugget_entlarvt | offen | Der Auftrag | Gang-Wahl, Bosse in Akt 4 | 1 | Ausgang der Hauptquest „Der Auftrag“ (nicht verwechseln mit dem Prototyp-Flag „auftrag“ = Auftraggeber) |
| `held_art` | katzenartige, voegel, krokodile, kaengurus, maeuse_ratten, fuechse, marder, insekten, spinnen, primaten | fuechse | Charaktererstellung (Taxi) | Startansehen, Preise, Garde-Kontrollen, Anrede, Schlüsselzeilen (Roach, Hummel, Ilse, Odile, Malcolm, Adikatz, Don Orango, Gus), eigener Weg je Akt | alle | Zehn Gruppen, Daten: data/characters/tierarten.json, Erklärung: docs/story/tierarten.md. Hunde sind gesperrt. Verwandtschaftsoptionen in Dialogen: flag("held_art") == "<gruppe>"; einmal setzen |
| `held_unterart` | Katze, Schwarzkatze, Tigerkatze, Siamkatze, Perserkatze, Ragdoll, Loewe, Tiger, Leopard, Puma, Panther, Luchs, Rabe, Spatz, Eule, Moewe, Taube, Alligator, Krokodil, Kaiman, Kaenguru, Wallaby, Quokka, Maus, Ratte, Hamster, Maulwurf, Rotfuchs, Polarfuchs, Fennek, Dachs, Marder, Otter, Stinktier, Waschbaer, Kakerlake, Ameise, Biene, Kaefer, Motte, Grille, Webspinne, Springspinne, Vogelspinne, Tarantel, Schimpanse, Gorilla, OrangUtan | Rotfuchs | Charaktererstellung (Taxi) | Aussehen, Form (Hauskatze/Großkatze, Taube, Waschbär, Dachs), Bild von Pfötchens Frau (Rückblenden, Archiv, Foto) | alle | Pfötchens Frau hat genau diese Unterart; einmal setzen |
| `malcolm_knoten` | ja, nein | nein | genug gemeinsames Erleben mit Malcolm (Bruderschaft) | Finale: Malcolm wendbar? Hält er bei der Zerstörung Wort oder vollzieht er die Raffung? | 2–4 | Ohne Knoten ist die Bruderschaft Malcolms Schwachstelle: Pfötchen schiebt sie zurück in die Treue zum Vater |
| `grosse_knoten` | waffenstillstand, platz_gerettet, tauben_frei, gang_hass, tauben_gepresst, hunde_frei, deltamae_konzert, expedition_ungestoert, knotenwand, fitz_show, lager_ungestoert, gangs_gemeinsam, hazel_liebe, unruhen_ungebremst | leer | Quest-Ausgänge und Massenereignisse (data/zustaende/grosse_knoten.json) | viertel_*, stadt_brand, verknotung_moeglich | 1–4 | positive und negative große Knoten |
| `viertel_hairlem` | haelt, wankt, kippt | wankt | berechnet | Finale: Verbündete, Brand, Menge | 5 | abgeleitet: Bilanz der großen Knoten in Hairlem: ab +2 hält, 0 bis +1 wankt, unter 0 kippt |
| `viertel_subfurs` | haelt, wankt, kippt | wankt | berechnet | Finale: Verbündete, Brand, Menge | 5 | abgeleitet: Bilanz der großen Knoten in Subfurs: ab +2 hält, 0 bis +1 wankt, unter 0 kippt |
| `viertel_boney` | haelt, wankt, kippt | wankt | berechnet | Finale: Verbündete, Brand, Menge | 5 | abgeleitet: Bilanz der großen Knoten in Boney Island: ab +2 hält, 0 bis +1 wankt, unter 0 kippt |
| `viertel_cathattan` | haelt, wankt, kippt | wankt | berechnet | Finale: Verbündete, Brand, Menge | 5 | abgeleitet: Bilanz der großen Knoten in Cathattan: ab +2 hält, 0 bis +1 wankt, unter 0 kippt |
| `stadt_brand` | funken, strassen, viertel, cathattan_brennt | strassen | berechnet | Finale (Kulisse), Epilog | 5 | abgeleitet: aus viertel_*: kein Viertel kippt und höchstens eins wankt → funken; keins kippt → strassen; eins kippt → viertel; zwei oder mehr kippen oder Cathattan kippt → cathattan_brennt |
| `verknotung_moeglich` | ja, nein | nein | berechnet | Finale: lässt der Held los, hält die Stadt (Verknotung) oder Pfötchen gewinnt (Status quo) | 5 | abgeleitet: mindestens drei Viertel halten und keins kippt; wird dem Spieler nie angezeigt |
| `riff` | verschollen, geheilt, gerettet | verschollen | Akt 2 (Begegnung in Vales Patrouille → geheilt), Akt 3 (Befreiung über Adikatz oder die Kassette → gerettet) | Finale: Opfer an der Brücke (gerettet: Riff, sonst Adikatz), bekanntes Gesicht (geheilt), Epilog | 2–4 | siehe quests_und_beziehungsboegen.md, Abschnitt Lil' Riff |
| `haltung_nomapes` | verbuendet, neutral, feindlich | neutral | berechnet | Finale: Station 1 und 3 (Welle halten, Opfer, oder an Vales Seite) | 5 | abgeleitet: gangs_gemeinsam → verbündet; gewählte Gang → verbündet; ohne Wahl → neutral; andere Gang: Auftrag ausgeführt, gewarnt oder doppelt → feindlich, sonst neutral; Nomapes zusätzlich feindlich, wenn Knuckles treue Nichte ist und der Held bei den Cats steht; Nomapes |
| `haltung_cats` | verbuendet, neutral, feindlich | neutral | berechnet | Finale: Station 1 und 3 (Welle halten, Opfer, oder an Vales Seite) | 5 | abgeleitet: gangs_gemeinsam → verbündet; gewählte Gang → verbündet; ohne Wahl → neutral; andere Gang: Auftrag ausgeführt, gewarnt oder doppelt → feindlich, sonst neutral; Nomapes zusätzlich feindlich, wenn Knuckles treue Nichte ist und der Held bei den Cats steht; Breaking Cats |
| `buerger_getoetet` | keine, einige, viele | keine | Finale, Station 2 (Die Menge) | Epilog (Gedenktafel, je nach Ende), Gefährten-Reaktionen | 5 | Töten ist nie Pflicht, nicht tödlich kostet Zeit, Brand und Kraft |
| `andere_wahl` | nicht_da, zurueckgeholt, bewusstlos, getoetet | nicht_da | Finale, Station 3b | Epilog, Gang im Epilog | 5 | die in Akt 1 nicht gewählte Gefährtin (Shiner oder Knuckles) |
| `bekanntes_gesicht_wer` | riff, benny, pounce, odile, ansgar, junger_kater | junger_kater | berechnet | Finale, Station 5 | 5 | abgeleitet: riff = geheilt → riff; dann gerettet enthält benny → benny, pounce → pounce; odile gewonnen oder getaeuscht → odile; mantelmann nicht verpruegelt und nicht unbekannt → ansgar; sonst junger_kater |
| `bekanntes_gesicht` | keins, zurueckgeholt, bewusstlos, getoetet | keins | Finale, Station 5 | Epilog (Gedenktafel) | 5 |  |
| `pfoetchen_griff` | stark, bruechig, verzweifelt | stark | berechnet | Pfötchens Züge in Akt 4 (Tempo des Verrats an Hazel, Pips), Härte in der Gründungsnacht | 4 | abgeleitet: Zahl der Bedrohungen: Hunde befreit (barkley_ausgang fanatiker oder mehr_als_eine_liebe), Tauben befreit, Näherinnen befreit, Gangs im Frieden (waffenstillstand oder gangs_gemeinsam), Pips neu verknotet, Hazel wissend oder verraten, Mercy Reformerin oder Abtrünnige. 0–2 stark, 3–4 brüchig, 5+ verzweifelt; siehe akt4_rueckgrat.md, Abschnitt 4 |
| `malcolm_papiere` | offen, angenommen, abgelehnt | offen | Akt 1 (Malcolms Angebot), Akt 4 (Brücke) | Ankunft in Cathattan, Malcolm | 1–4 |  |
| `akt4_uhr` | ja, nein | nein | Hauptquest 4.2 (Gespräch mit dem Vater) oder dritte Einladung | Krisenquests, Rasten | 4 |  |
| `akt4_rast` | 0–5 | 0 | lange Rast, sobald akt4_uhr läuft | Fenster der Krisenquests, Warnung vor der Gründungsnacht | 4 |  |
| `unruhen_stufe` | 0–5 | 0 | jede Rast in der Krisenphase | Plakate, Straße, Hazel, Kellerstadt | 4 |  |
| `foto_mutter` | nicht_gefunden, behalten, dem_rat, veroeffentlicht | nicht_gefunden | Hauptquest 4.1 | Gespräch mit dem Vater, Ordensrat, Unruhen | 4 |  |
| `vater_gespraech` | keins, beweise, angeknuepft, gedroht, geschwiegen | keins | Hauptquest 4.2 | Schicht 2 im Finale (bekehrbar, erreichbar) | 4 |  |
| `vater_angebot` | offen, angenommen, abgelehnt | offen | Hauptquest 4.2 | Finale (Erbe, Einwebung), Gefährten-Reaktionen | 4 |  |
| `hazel_beistand` | offen, ja, nein | offen | Krisenquest K1 | großer Knoten hazel_liebe oder unruhen_ungebremst | 4 |  |
| `krisen` | hazel, benny, kellerstadt, pips, rat, razzia, aufstand, feuer, kammern | leer | Krisenquests (geschafft) | Finale, Epilog | 4 |  |
| `rat_abstimmung` | offen, pfoetchen_bleibt, pfoetchen_verliert | offen | Krisenquest K5 | Pfötchens Griff, Auftreten im Finale | 4 |  |

## Juno

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `juno_kontakt` | ja, nein | nein | Fitz K3 (Bote) | Juno-Szenen A3–A4 | 3 |  |
| `juno_knoten_lager` | 0–3 | 0 | +1 shiner_galerie angenommen, +1 deltamae_lager_auftritt, +1 fitz_show geflogen | juno_bogen (verknotete Bindung an den Orden erschwert den Bogen) | 3 |  |
| `juno_offenheit` | -2–2 | 0 | Mercy-Urteil (hart −1 / gnädig +1), Delta-Mae-Szene (+1), Held-Szenen | juno_bogen | 3–4 |  |
| `juno_bogen` | verloren, frei_bleibt, frei_kommt_mit | verloren | A4 berechnet aus juno_offenheit, Auftrennung, Kindheitsszenen | Finale (Gastfigur), Epilog | 4 | einmal setzen |
| `juno_spur` | 0–5 | 0 | Quest 1 (Wohnung, Odile, Mission), Tauben | Junos Begegnung in Akt 2 | 1 | wird mit GameState.erhoehen() gezählt |
| `juno_sachen_gerettet` | ja, nein | nein | Quest 1.1/1.2 (Odile gibt sie zurück, beiseitegeschafft oder Helfer verjagt) | Unterschlupf (Kiste mit Junos Sachen), Juno in Akt 3–4 | 1 |  |
| `juno_stimme` | 1–4 | 1 | Akt 2 (Juno weist ihn ab) → 2, Akt 3 (Irrtum bei Malcolm erkannt) → 3, Akt 4 (guter Bogen) → 4 | Einsicht-Proben: Form von Junos Stimme („Juno hätte gesagt“ / „Ich glaube …“ / Widerspruch / eigene Stimme) | 1–5 | siehe docs/story/akt1_szenen.md, Abschnitt Junos Stimme |
| `juno_zettel_gesehen` | ja, nein | nein | Quest 1.3 | Junos erste Worte in Akt 2 | 1 |  |

## Big Dig

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `dig_k2_wendung` | zurueckgeholt, verlassen | verlassen | Big Dig K2 (abhängig von dig_knoten) | dig_in_gruppe A2–A3 | 2 | einmal setzen |
| `dig_fitz_einsicht` | ja, nein | nein | Bogen Big Dig/Fitz A3 | dig_ausgang (Voraussetzung neu_verknotet) | 3 |  |
| `dig_pips_szenen` | 0–3 | 0 | Big Dig K3 Strand-Szenen | dig_ausgang | 3 |  |
| `dig_ausgang` | neu_verknotet, entfuehrt, losgelassen | losgelassen | Big Dig K4 | Finale (Tunnel / fehlt / wendbar) | 4 | neu_verknotet braucht dig_fitz_einsicht UND (pip_szenen==3 ODER Musterbuch-Szene mit der Weberin); einmal setzen |
| `dig_knoetchen` | 0–9 | 0 | GameState.knoetchen(): Knotenmomente +1 (Schlägerei, tiefe Gespräche, Lagerszenen mit Entscheidung, Höhepunkt der persönlichen Quest, außergewöhnliche Tat vor ihren Augen), negative gemeinsame Momente −1, Verrat → 0 | dig_knoten (3 Knötchen = 1 Knoten) | alle | siehe docs/story/zuneigung_und_knoten.md |

## Corvin

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `corvin_k2_musterbuch` | ja, nein | nein | Corvin K2 | Corvin-Stimmbruch, Weberin-Bogen | 2 |  |
| `corvin_vale_ermittlung` | offen, gemeinsam, allein, verpasst | offen | Corvin K3 mit Barkley | vale, Bogen Corvin/Barkley | 3–4 | Fenster Akt 3–4 (A4 mit weniger Beweisen); beim Aktübergang: offen → verpasst |
| `corvin_ausgang` | ganze_wahrheit, halbe_wahrheit, keine_wahrheit | keine_wahrheit | Corvin K4 | Finale (Taubennetz / wendbar) | 4 | Beweise: tauben==netz_genutzt ODER Hazel-Begnadigung; einmal setzen |
| `corvin_knoetchen` | 0–9 | 0 | GameState.knoetchen(): Knotenmomente +1 (Schlägerei, tiefe Gespräche, Lagerszenen mit Entscheidung, Höhepunkt der persönlichen Quest, außergewöhnliche Tat vor ihren Augen), negative gemeinsame Momente −1, Verrat → 0 | corvin_knoten (3 Knötchen = 1 Knoten) | alle | siehe docs/story/zuneigung_und_knoten.md |

## Shiner

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `shiner_k2_station` | ja, nein | nein | Shiner K2 | Weberin-Kommentar, shiner_ausgang | 2 |  |
| `shiner_galerie` | offen, angenommen, abgelehnt, verpasst | offen | Shiner K3 | juno_knoten_lager, Bogen Shiner/Delta Mae | 3–4 | Fenster Akt 3–4 (A4: Porträt statt Banner, wirkt nicht auf Juno); beim Aktübergang: offen → verpasst |
| `shiner_uebermalt_gestanden` | ja, nein | nein | Bogen Shiner/Corvin A3 | shiner_galerie (Ablehnung leichter) | 3 |  |
| `shiner_ausgang` | knotenmalerin, ausverkauft, einzelgaengerin | einzelgaengerin | Shiner K4 | Ende ‚Verknotung‘ | 4 | einmal setzen |
| `shiner_knoetchen` | 0–9 | 0 | GameState.knoetchen(): Knotenmomente +1 (Schlägerei, tiefe Gespräche, Lagerszenen mit Entscheidung, Höhepunkt der persönlichen Quest, außergewöhnliche Tat vor ihren Augen), negative gemeinsame Momente −1, Verrat → 0 | shiner_knoten (3 Knötchen = 1 Knoten) | alle | siehe docs/story/zuneigung_und_knoten.md |

## Knuckles

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `knuckles_nugget` | offen, enttarnt, gedeckt, verpasst | offen | Knuckles K2–K4 | knuckles_ausgang | 2–4 | verpasst wirkt wie gedeckt; beim Übergang ins Finale: offen → verpasst |
| `knuckles_vertrag` | behalten, gekuendigt | behalten | Knuckles K3 | knuckles_ausgang | 3 | einmal setzen |
| `knuckles_luege_gebeichtet` | ja, nein | nein | Bogen Knuckles/Big Dig A3 | knuckles_zuneigung | 3 |  |
| `knuckles_ausgang` | nachfolgerin, geschaeftsfrau, treue_nichte | treue_nichte | Knuckles K4 | Finale (Gangs) | 4 | einmal setzen |
| `knuckles_knoetchen` | 0–9 | 0 | GameState.knoetchen(): Knotenmomente +1 (Schlägerei, tiefe Gespräche, Lagerszenen mit Entscheidung, Höhepunkt der persönlichen Quest, außergewöhnliche Tat vor ihren Augen), negative gemeinsame Momente −1, Verrat → 0 | knuckles_knoten (3 Knötchen = 1 Knoten) | alle | siehe docs/story/zuneigung_und_knoten.md |

## Weberin

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `weberin_herausgeschnitten` | pips, hazel, dig, corvin, shiner, knuckles, barkley, deltamae, mercy | leer | Weberin K4 (höchstens 2) | Finale (nicht wendbar), Hazel als Leitung, Pips, Epilog (keine Resonanz) | 4 | Herausgeschnittene sind unlenkbar und fühlen nie wieder mit. Nur in Meow York Geborene: nicht juno, nicht fitz |
| `weberin_luege_gestanden` | ja, nein | nein | Bogen Weberin/Corvin A3 oder Mercy-Akten | mercy_weberin_behandelt, Musterbuch-Szene zu Pips | 3 |  |
| `weberin_ausgang` | hueterin, zerstoererin, schneiderin | hueterin | Weberin K4 | Finale (liest Pfötchens Ketten), Ende ‚Wegsperren‘/‚Zerstörung‘ | 4 | einmal setzen |
| `weberin_knoetchen` | 0–9 | 0 | GameState.knoetchen(): Knotenmomente +1 (Schlägerei, tiefe Gespräche, Lagerszenen mit Entscheidung, Höhepunkt der persönlichen Quest, außergewöhnliche Tat vor ihren Augen), negative gemeinsame Momente −1, Verrat → 0 | weberin_knoten (3 Knötchen = 1 Knoten) | alle | siehe docs/story/zuneigung_und_knoten.md |

## Barkley

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `barkley_befreiung` | natuerlich, inszeniert | natuerlich | Barkley K2 | Zuneigung mehrerer, Gefährten-Kommentare | 2 | einmal setzen |
| `barkley_zweite_schlinge` | keine, fitz, deltamae | keine | Bögen Barkley/Fitz bzw. Barkley/Delta Mae | barkley_ausgang, Finale (über wen Pfötchen greift) | 3–4 |  |
| `barkley_verrate_inszeniert` | ja, nein | nein | Barkley K3 | Zuneigung, barkley_ausgang | 3 |  |
| `barkley_ausgang` | mehr_als_eine_liebe, fanatiker, raecher | fanatiker | Barkley K4 | Finale, Epilog | 4 | mehr_als_eine_liebe braucht zweite_schlinge != keine; einmal setzen |
| `barkley_knoetchen` | 0–9 | 0 | GameState.knoetchen(): Knotenmomente +1 (Schlägerei, tiefe Gespräche, Lagerszenen mit Entscheidung, Höhepunkt der persönlichen Quest, außergewöhnliche Tat vor ihren Augen), negative gemeinsame Momente −1, Verrat → 0 | barkley_knoten (3 Knötchen = 1 Knoten) | alle | siehe docs/story/zuneigung_und_knoten.md |

## Delta Mae

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `deltamae_pakt` | fremde_stimme, eigene_stimme, andere_loesung | eigene_stimme | Delta Mae K2 | Zuneigung, Finale (Stimme behalten?) | 2 | einmal setzen |
| `deltamae_lager_auftritt` | ja, nein | nein | Delta Mae K3 | juno_knoten_lager, Bogen Shiner/Delta Mae | 3 |  |
| `deltamae_ausgang` | ehrliches_lied, legende, verkaufte | legende | Delta Mae K4 | Finale (letztes Lied) | 4 | einmal setzen |
| `deltamae_knoetchen` | 0–9 | 0 | GameState.knoetchen(): Knotenmomente +1 (Schlägerei, tiefe Gespräche, Lagerszenen mit Entscheidung, Höhepunkt der persönlichen Quest, außergewöhnliche Tat vor ihren Augen), negative gemeinsame Momente −1, Verrat → 0 | deltamae_knoten (3 Knötchen = 1 Knoten) | alle | siehe docs/story/zuneigung_und_knoten.md |

## Mercy

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `mercy_urteil_juno` | hart, gnaedig | hart | Mercy K3 | juno_offenheit | 3 | einmal setzen |
| `mercy_weberin_behandelt` | ja, nein | nein | Mercy K3 | Auftrennung pip möglich | 3 |  |
| `mercy_akten` | ordensrat, presse_hazel, zurueckgehalten | zurueckgehalten | Mercy K4 | hazel_status, mercy_ausgang | 4 |  |
| `mercy_ausgang` | reformerin, abtruennige, schweigende | schweigende | Mercy K4 | Finale | 4 | einmal setzen |
| `mercy_knoetchen` | 0–9 | 0 | GameState.knoetchen(): Knotenmomente +1 (Schlägerei, tiefe Gespräche, Lagerszenen mit Entscheidung, Höhepunkt der persönlichen Quest, außergewöhnliche Tat vor ihren Augen), negative gemeinsame Momente −1, Verrat → 0 | mercy_knoten (3 Knötchen = 1 Knoten) | alle | siehe docs/story/zuneigung_und_knoten.md |
| `mercy_erstkontakt` | keiner, andacht, kueche, nacht, lazarett | keiner | Quest 1.3 (Krankenstube), Lazarett | Mercys erste Zeilen, Zuneigung, Lagerszene | 1 |  |
| `mercy_schweigepflicht` | offen, respektiert, gebrochen | offen | Pflicht-Lagerszene Mercy (Akt 1) | Knötchen, juno_spur, Mercys Vertrauen in Akt 3 | 1 | respektiert: Knötchen; gebrochen: juno_spur +1, Zuneigung −2 |
| `mercy_expedition` | offen, geblieben, mitgegangen | offen | Akt 2, Befehl des Ordens | Mercy in Akt 2 und 3, großer Knoten ‚Expedition ungestört‘, Junos erste Nachricht | 2 | mitgegangen: verlässt die Gruppe für einen Teil von Akt 2 |

## Fitz

| Variable | Werte | Standard | Gesetzt von | Gelesen von | Akt | Hinweis |
| --- | --- | --- | --- | --- | --- | --- |
| `fitz_show` | geflogen, sabotiert, umgedeutet | geflogen | Fitz K3 | juno_knoten_lager, Zirkus-Vertrag | 3 | einmal setzen |
| `fitz_weberin_trost` | ja, nein | nein | Bogen Fitz/Weberin A4 | fitz_ausgang | 4 |  |
| `fitz_ausgang` | letzter_flug, trotzig, bodenstaendig | trotzig | Fitz K4 | Finale | 4 | letzter_flug braucht fitz_weberin_trost; einmal setzen |
| `fitz_knoetchen` | 0–9 | 0 | GameState.knoetchen(): Knotenmomente +1 (Schlägerei, tiefe Gespräche, Lagerszenen mit Entscheidung, Höhepunkt der persönlichen Quest, außergewöhnliche Tat vor ihren Augen), negative gemeinsame Momente −1, Verrat → 0 | fitz_knoten (3 Knötchen = 1 Knoten) | alle | siehe docs/story/zuneigung_und_knoten.md |

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
8. **Aktübergang und Zeitfenster:** Kapitel bleiben bis zum Ende ihres Fensters offen und sind danach nie mehr `offen`.
9. **Lagerszenen:** Eine verpasste Pflicht-Lagerszene wird im nächsten Akt nachgeholt.

**Testbot:** Ein Skript spielt Dialoge tausendfach mit zufälligen Antworten durch und meldet Abstürze, Sackgassen und Variablen außerhalb ihrer Werte. Das kann über Nacht laufen.

---

## Szenario-Spielstände für das Debug-Menü

Mit diesen Spielständen springst du direkt an kritische Stellen, ohne 40 Stunden zu spielen. Das Debug-Menü sollte jede Variable aus der JSON-Datei setzen können.

| Nr. | Startpunkt | Gesetzte Zustände | Was getestet wird |
| --- | --- | --- | --- |
| 1 | Ende Akt 1 | alles `offen` | Kapitel mit Fenster bleiben offen, Lagerszenen werden nachgeholt |
| 2 | Akt 2, Big Dig K2 | bigdig_knoten = false | Big Dig verlässt die Gruppe, kehrt in A3 zurück |
| 3 | Akt 2, Weberin K2 | naeherinnen = befreit | Unruhen, Hazel unter Druck, mehr Gegenzüge |
| 4 | Akt 3, Lager | shiner_galerie = angenommen, deltamae_lager_auftritt = true, fitz_show = geflogen | juno_knoten_lager = 3, Junos Bogen wird deutlich schwerer |
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
5. Die dritte Strand-Szene mit Pip (`bigdig_pip_szenen` maximal 2)

Nicht streichbar, weil andere Bögen daran hängen: die Pflicht-Lagerszenen, `bigdig_fitz_einsicht`, `barkley_zweite_schlinge`, `juno_knoten_lager`, `weberin_luege_gestanden`, `fitz_weberin_trost`.
