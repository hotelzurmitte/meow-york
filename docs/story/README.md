# Story-Dokumente

Erarbeitet am 13.11.2026 im Chat zu den Charakterbiografien. Grundlage war das Game Design Document (GDD, Stand 13.11.2026). Das GDD selbst und das Regelwerk „Das Knäuel“ liegen nicht im Repository.

**Status:** Am 13.11.2026 vom Nutzer vollständig freigegeben und mit dem Regelwerk „Das Knäuel“ abgeglichen. Das GDD bleibt die zentrale Quelle. Details können sich beim Ausarbeiten noch ändern.

## Reihenfolge zum Lesen

1. `steckbriefe.md`: alle Figuren in Stichworten, zum schnellen Nachschlagen
2. `charakterbiografien.md`: ausführliche Biografien mit bewerteten Entwicklungen
3. `stimmen_und_beziehungen.md`: Sprechweisen, Stimmbruch unter Druck, Beziehungen
4. `quests_und_beziehungsboegen.md`: persönliche Quests über alle Akte, Beziehungsbögen, Wirkungsketten
5. `akt1_szenen.md`: Akt 1 Szene für Szene (Vorschlag, noch nicht freigegeben)
6. `zustandsplan.md`: alle Story-Variablen und der Testplan. Die technische Fassung ist `data/zustaende/zustaende.json`, die Bedienung steht in `docs/zustaende.md`.

## Vom Nutzer im Chat entschieden

- Pfötchens heimliche Geliebte war seine erste Leitung und nahm sich, zermürbt vom Nachhall, das Leben. Das Ordensoberhaupt lebt ehelos, der Held ist ein uneheliches Kind. Die Stadt verehrt Pfötchen als Heiligen, der allein ein Findelkind (Malcolm) großzieht. *(14.11.)*
- Pfötchen hat Malcolm nach dem Tod seiner Geliebten bewusst als neue Leitung gewählt: ein Waisenkind ohne andere Bindungen, das als Ziehsohn des Ordensoberhaupts der Liebling der Stadt werden würde. Er hat ihn nie geliebt. Die Liebe zum Sohn blieb eine Schlinge ins Leere, und Malcolm spürt das.
- Pfötchen hat den Sohn selbst herausgeschnitten. Die Weberin hat ihm die Stelle gezeigt, ohne zu wissen, wessen Kind es war: Er sagte ihr, das Kind sei eine Gefahr für die Stadt.
- **Enthüllung in drei Stufen** (14.11.): Akt 2 die Narbe (er wurde vom Halter herausgeschnitten), Akt 3 die Beichte der Weberin (angeblich als Gefahr), Akt 4 Mitte das Foto der Mutter in Pfötchens Kammer (er ist der Sohn und wurde aus Liebe herausgeschnitten).
- **Insekten sind der größte Sündenbock der Stadt,** die Tauben der zweite. In Akt 4 lenkt Pfötchen den Hass auf die Insekten auf ihre Schutzherrin Hazel. *(14.11.)*
- Die Weberin ist die Kartografin des Knäuels: Sie kennt die Übergänge, berechnet die billigsten Wege und plant Pfötchens Pflege. Es gibt keine neue Regel dafür. In Akt 4 kann sie Menschen herausschneiden.
- „Der Erbe“ ist ein Weg im Einwebungs-Ende, denn ein Herausgeschnittener kann das Knäuel nicht benutzen.
- Big Digs vermisstes Kind heißt Pips (ein kleiner Mäuserich). Das Mädchen, das in Akt 1 hilft, heißt Mimi.
- Keine Monsterhunde als sichtbare Wächter: Kontrollposten der Ordensgarde an den Brücken, Monsterhunde nur im Verborgenen, „BEWARE OF THE BEASTS!“ als Graffiti.
- Malcolm hat die gestohlenen Papiere des Helden bei Roach gekauft. Er gibt sie später scheinbar freundlich zurück.
- Was der Spieler wann über den Helden erfährt: siehe die Enthüllungstreppe in `akt1_szenen.md`.
- **Akt 1, freigegeben am 13.11.:** Schwester Odile (Gans), Bruder Ansgar (Dachs), Gus Rook. Corvin hat Hausverbot im Nest. Lil' Riff wurde der Garde unter Vale übergeben. Der Orden geht nach unten, um bei den Ausgestoßenen Schlingen zu knüpfen.
- **Malcolm in Akt 1 ist der Köder** (13.11.): Er kämpft sichtbar gegen den Orden, sagt dabei die Wahrheit über ihn und hilft dem Helden ohne Gegenleistung. Die Kassette sät nur Zweifel, jede Zeile lässt eine gute Lesart zu. `malcolm_risse` steigt in Akt 1 höchstens auf 2.
- **Junos Stimme** (13.11.): Bei gelungener Einsicht deutet Juno in seinem Kopf, was andere fühlen. Sie kann sich irren, schweigt manchmal und verändert sich über die Akte (`juno_stimme`).
- **Fadenlos** bekommt eine eigene stille Szene am Morgen nach der Schlägerei. **Die Gang-Wahl** hängt an Menschen (Riffs Platz im Studio, der Lohntag in der Werkstatt), und wer einen Gefährten verlieren kann, wird vorher gewarnt.
- **Papier-Spieltests** für fünf Spielstile: `akt1_spieltests.md`, Test-Spielstände `11_` bis `15_`.
- **Tierarten des Helden** (13.11.): Zehn Gruppen mit Unterarten (Katzenartige, Vögel, Krokodile, Kängurus, Mäuse und Ratten, Füchse, Dachse und Marder, Insekten, Spinnen, Primaten). Die Art ist ein Milieu, keine Fähigkeit. Jede Gruppe hat einen Verwandten unter den Gefährten, mit festem Paket je Akt und ohne exklusives Ende. Hunde sind nicht wählbar, Roach erklärt es im Taxi. Abfällige Straßennamen (Samtpfote, Achtauge, Krabbler …) benutzen nur Figuren mit Vorurteil. **Pfötchens Frau hat die Unterart, die der Spieler wählt** (`tierarten.md`, `held_art`, `held_unterart`).
- **Mercy ab Akt 1** (14.11.): Ärztin der Ordensmission in Hairlem, schließt sich nach der Schlägerei im Lazarett an, mit Sicherungen in Akt 2 und 3. Akt 2: Expedition (mitgehen oder bleiben), Akt 3: ihre Geschichte nimmt Fahrt auf. **Klassen:** Big Dig nur Bruiser (Tank), Corvin Gumshoe oder Street Ranger, Delta Mae ohne Mutantin, Barkley mit Street Saint (Paladin der Treue).
- **Zuneigung und Knoten** (13.11.): Zuneigung (−10 bis +10, Zu- und Abneigung) und Knötchen (3 = 1 Knoten, Stärke 0 bis 3) sind getrennt. Große Knoten der Stadt haben ein Vorzeichen und zählen je Viertel. Daraus folgen Brand, Verbündete und ob die Verknotung gelingt: `zuneigung_und_knoten.md`.
- **Finale** (13.11.): eine brennende Nacht in sieben Stationen, einmal in der schwersten Fassung gebaut. Verbündete nehmen weg, erleichtern oder öffnen Wege, Feinde (auch eine Gang) stellen sich auf Pfötchens Seite. Opfer an der Brücke: Don Orango, Riff (mit Breakdance) oder Adikatz. Fanatische Bürger: töten möglich, nie Pflicht, nicht tödlich kostet (`buerger_getoetet`). Bekannte Gegner: die nicht gewählte Gefährtin aus Akt 1 auf der Brücke, ein bekanntes Gesicht in der Halle. Sechs Schlussbilder. Verknotung entsteht, wenn der Held loslässt: `enden.md`.
- **Verbindungen über Systeme, nicht über Zufälle:** Vincenzo ist kein Onkel von Fitz, Benny nicht Hazels Bruder, Vale nicht Corvins früherer Chef. Der Lagerhausbrand war ein Versicherungsbetrug, Corvin kennt Gus Rook seit zwölf Jahren.
- Das Bild für Spieler: Schlingen sind Taschen, Gefühl ist Geld, Pfötchen schiebt nur zwischen den eigenen Taschen einer Person, Knoten nähen Taschen zu.
- Hazels Bogen: Erst weiß sie die Wahrheit und liebt trotzdem weiter. Dann verrät Pfötchen sie, ihr Knoten rutscht, und ihre Liebe legt sich auf die Stadt.
- **Wie sich ein Knoten löst:** Von außen kann niemand einen Knoten lösen. Er löst sich nur von innen, durch Verrat. Das Gefühl verschwindet dabei nicht, sondern legt sich um das Nächste, was der Person etwas bedeutet.
- Die Katzen fürchteten die Hunde, weil Hunde treu sind: starke Schlingen, die schnell und fest verknoten und damit nicht zu lenken sind.
- Barkleys Knoten löst sich durch Vales Verrat. Seinen Körper verwandelt Delta Mae zurück, weil sie den Zauber kennt. Das Ritual gelingt nicht ganz, deshalb kann er die Monsterform wie ein Druide abrufen.
- Barkley bleibt ernst. Komisch ist er nur, weil er die jungen Leute nicht versteht.
- Fitz ist die „Karlach“ der Gruppe: ein echtes Risiko, getragen mit Lebensfreude.
- Shiner, Knuckles und Fitz haben weniger Trauma. Delta Maes Kanal-Legende ist zur Hälfte erfunden.
- Der Held kann Pfötchen auch „platt machen“ (Ende „Der Richter“). Dazu kommen weitere Enden: Erbe, Heimkehrer, Werkzeug.
- Figuren fallen in ernsten Momenten aus ihrer Sprechweise. Daran zeigt sich ihr Wachstum.
- **Point of no Return nach dem Vorbild von BG3:** Die Geschichte kommt zum Spieler. Jeder Gefährte hat pro Akt eine Pflicht-Lagerszene, die nachgeholt wird, falls sie fehlt. Ortsgebundene Kapitel haben ein Fenster über zwei Akte, Schlüsselfiguren wandern mit, und „verpasst“ gibt es nur für Nebenzweige.
- **Kein festes Lager:** Die Gruppe rastet in wechselnden Unterschlüpfen, etwa im Zimmer über dem Cuckoo's Nest, im U-Bahn-Waggon, im Wohnwagen der Acorns oder im Hotel in Cathattan. Die Figuren tragen ihre Requisiten bei sich. Corvin hat unterwegs ein Notizbuch statt der Pinnwand, die in seinem Büro bleibt.

## Offene Punkte (bei jedem neuen Akt prüfen)

- [ ] **Bekannte Gesichter im Finale erweitern:** Bisher kommen nur Figuren aus Akt 1 in Frage (Station 5, `bekanntes_gesicht_wer`: Benny, Pounce, Odile, Ansgar, Malcolms junger Kater). Beim Schreiben von Akt 2, 3 und 4 prüfen, welche neue Nebenfigur dort stark genug wird, um im Finale gegen den Helden zu stehen. Dann die Liste in `enden.md` und die Berechnung in `GameState` ergänzen. *(Wunsch des Nutzers, 13.11.)*
- [x] **Riff:** entschieden 14.11. (`quests_und_beziehungsboegen.md`, Abschnitt Lil' Riff). Offen bleibt nur der genaue Ort in Akt 3.
- [ ] **Malcolm und die Ankunft des Helden (Akt 2):** Das Regelwerk sagt, Malcolm hat ihn hergelockt. In Akt 1 kauft er die Papiere aller allein Angereisten, „er sucht jemanden“. Klären, wie viel er wusste.
- [x] **Akt 4:** Rückgrat in `akt4_rueckgrat.md`, Szene für Szene in `akt4_szenen.md` (Fassung 1 zur Prüfung). Entschieden 14.11.: Cathattan als eigenes Areal ohne Zeitdruck, erst das Gespräch mit dem Vater startet die Uhr bis zur Gründungsnacht (fünf Rasten, Krisenquests, nicht alle schaffbar), dann Point of no Return, Pfötchen mit dem Rücken zur Wand, Foto der Mutter in der Mitte des Akts. Einzelheiten noch Entwurf.
- [ ] **Große Knoten:** Liste in `data/zustaende/grosse_knoten.json` mit jedem Akt erweitern, Cathattan braucht mehr als zwei positive.

## Namen (freigegeben)

Tessa Strand (Weberin), Delta Mae (Alligatorin), Schwester Mercy (Gottesanbeterin), Fitz Acorn (Flughörnchen), Captain Vale, Benny, Rook, Vincenzo Frankinetti (Chamäleon), Lucien, Pips, die Näherinnen, Gertrud.
