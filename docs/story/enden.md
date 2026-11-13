# Die Enden von Meow York: Karte und Prüfung

*Stand 13.11.2026 · Quellen: Regelwerk (Abschnitt „Die Enden“), GDD, `charakterbiografien.md`, `quests_und_beziehungsboegen.md`, Zustandsregister*

Das Ende besteht aus vier Schichten, die der Spieler unabhängig voneinander beeinflusst. Erst zusammen ergeben sie „sein“ Ende.

| Schicht | Frage | Entschieden durch |
| --- | --- | --- |
| **1. Das Knäuel** | Was wird aus der Macht über die Gefühle der Stadt? | die letzte Entscheidung im Tempel |
| **2. Pfötchen** | Was wird aus dem Vater? | den letzten Kampf und das Gespräch davor |
| **3. Der Held** | Wer ist er am Ende? | wie er das ganze Spiel über angeknüpft, gebunden und entschieden hat |
| **4. Die Stadt und die Menschen** | Wer lebt, wer ist frei, wer ist allein? | jede Quest, jede Gefährtin, jeder Knoten (Epilog) |

---

## Schicht 1: Was aus dem Knäuel wird

| Ende | Was passiert | Preis | Voraussetzung |
| --- | --- | --- | --- |
| **Zerstörung** | Der Held öffnet alle Übergänge. Jeder in Meow York Geborene wird ein eigener Faden. Keine Manipulation mehr, auch nicht durch fremde Herrscher | Keine Resonanz mehr für Meow-Yorker: Niemand fühlt mehr mit, ohne hinzusehen | immer wählbar, wenn der Held das Knäuel erreicht |
| **Verknotung** *(das verdiente Ende)* | Das Knäuel bleibt, kann aber kaum noch etwas bewegen, weil die Stadt zu fest verknotet ist | Auch Fehden und schlechte Bindungen werden starr: Jeder negative große Knoten erscheint im Epilog als erstarrte Fehde | der Held lässt los, und mindestens drei Viertel halten (siehe unten) |
| **Wächter** | Der Held nimmt das Knäuel an sich. Er kann es nicht benutzen, also benutzt es niemand | Nur vertagt. Seine Freunde bleiben Druckmittel, er bleibt allein | immer wählbar |
| **Einwebung** | Der Held lässt sich an seiner Narbe wieder einspleißen oder wird beim Anknüpfen eingesponnen. Er fühlt zum ersten Mal die Stadt und seinen Vater | Er wird lenkbar. Als Herrscher (Weg „Der Erbe“) würde Juno seine Leitung | gewählt, oder als Scheitern bei hoher `held_verwachsung` |
| **Raffung** | Malcolm schiebt alle unverknoteten Gefühle der Stadt in Schlingen um sich selbst. Alle haben nur noch eine Schlinge, um ihn | Malcolms eigene Leere bleibt. Er hat alle und fühlt nichts | Malcolm bekommt das Knäuel: Weg „Das Werkzeug“, oder der Held überlässt ihm die Zerstörung ohne verknotete Bruderschaft (Fund 2) |
| **Status quo** | Pfötchen behält das Knäuel | Ordnung durch Feindbilder, die Stadt kühlt weiter aus | Pfötchen siegt, oder der Held geht (Weg „Der Heimkehrer“) |

**Wie die Verknotung zustande kommt** *(entschieden 13.11.)*: Sie ist kein Knopf. Im Tempel kann der Held das Knäuel weder nehmen noch zerstören, sondern **loslassen und der Stadt vertrauen**. Dann zieht Pfötchen mit aller Kraft. Ist die Stadt fest genug verknotet (`verknotung_moeglich`: mindestens drei Viertel halten, keins kippt), bewegt sich nichts. Das ist die Verknotung. Sonst gewinnt Pfötchen, und es bleibt beim Status quo. Ein Wagnis, dessen Ausgang sich der Spieler über das ganze Spiel verdient hat, ohne die Zahl zu sehen. Wie die großen Knoten und Viertel gerechnet werden: `zuneigung_und_knoten.md`.

--- | --- |
| je 1 | jeder Gefährte mit Knoten zum Helden (`<g>_knoten`) |
| 2 | Shiner als Knotenmalerin (die Stadt malt ihre gemeinsamen Momente) |
| 2 | Knuckles als Nachfolgerin (die Gangs ziehen gemeinsam ein) |
| 1 | Tauben befreit |
| 1 | Junos Bogen nicht verloren |
| 1 | Hazel verraten und dadurch an die Stadt verknotet |
| 1 | Delta Maes ehrliches Lied |

Ab 10 Punkten ist die Verknotung wählbar. Das optimale Szenario (`08_finale_optimal`) kommt auf 13, ein ordentlicher Durchlauf mit fünf Knoten und zwei Stadtpunkten auf 7. Das Ende ist also verdient, aber nicht nur für Perfektionisten.

---

## Schicht 2: Pfötchens Schicksal

| Schicksal | Wie | Passt zu |
| --- | --- | --- |
| **Bekehrt** | Der Held erreicht ihn ohne Knäuel, mit Worten und Beweisen (Corvins Akten, Kassette, das Foto der Mutter). Pfötchen legt das Knäuel ab | Verknotung, Wächter, Zerstörung |
| **Erreicht** (Weg „Der Sohn“) | Der Held knüpft an ihn an. Halten seine Knoten, fühlt Pfötchen zum ersten Mal, was er seinem Sohn angetan hat | Verknotung, Zerstörung; scheitert es: Einwebung |
| **Verschont** | besiegt, aber am Leben gelassen, ohne Knäuel | alle außer Status quo |
| **Geopfert** | Er wendet das Knäuel gegen sich selbst und stirbt am eigenen Nachhall, als letzte Leitung | Zerstörung, Wächter |
| **Gerichtet** (Weg „Der Richter“) | Der Held tötet ihn ohne Zögern | danach greift jemand nach dem herrenlosen Knäuel: Wächter, Zerstörung oder Raffung |
| **Sieger** | Der Held unterliegt oder geht | Status quo |

Grundhaltung im Finale (fest): **der verzweifelte Vater.** Jeder Angriff ist ein Versuch, den Sohn zur Aufgabe zu zwingen, um ihn zu retten. Keine der Optionen darf sich wie ein reiner Sieg anfühlen.

---

## Schicht 3: Der Weg des Helden

| Weg | Haltung | Führt zu |
| --- | --- | --- |
| **Der Sohn** *(Herzstück)* | Er riskiert alles für einen Moment echter Verbindung mit dem Vater | Pfötchen erreicht → Verknotung oder Zerstörung; misslingt → Einwebung |
| **Der Mitfühlende** | Er knüpft immer öfter an und gibt am Ende seine Unerreichbarkeit auf | Verknotung |
| **Der Wächter** | Er bleibt bewusst fadenlos, weil die Stadt einen braucht, den niemand lenkt | Wächter |
| **Der Richter** | Er rechnet ab | Pfötchen gerichtet, dann eine Knäuel-Entscheidung |
| **Der Erbe** *(dunkelstes Gegenstück)* | Er lässt sich einspleißen, um zu herrschen | Einwebung, Juno als Leitung oder bewusst jemand anderes |
| **Der Heimkehrer** | Er holt Juno, wenn sie mitkommt, und geht | Status quo |
| **Das Werkzeug** | Er folgt Malcolm bis zum Ende | Raffung |

---

## Schicht 4: Epilog

Jede Gefährtin, jede Fraktion und jede offene Figur bekommt ein Bild und ein bis zwei Sätze, je nach Zuständen. Die Bausteine stehen schon im Register:

- **Gefährten:** `<g>_ausgang`, `<g>_knoten`, ob sie gewendet wurden und zurückfanden
- **Juno:** `juno_bogen` (verloren, frei und bleibt, frei und kommt mit)
- **Gangs:** `gang_wahl`, `knuckles_ausgang`, `auftrag_ausgang`
- **Tauben und Rook:** `tauben`, `rook`
- **Hunde:** `barkley_ausgang`, `vale`
- **Hazel:** `hazel_status`
- **Malcolm:** sein Bogen (Bruderschaft, der Gefallene, Leere als Wahl)
- **Herausgeschnittene:** `weberin_herausgeschnitten`. Sie fühlen nie wieder mit, egal welches Ende.

**Wichtig für die Zerstörung:** Sie trifft nur in Meow York Geborene. Juno und Fitz kamen von außerhalb und behalten ihre Resonanz. In einer Stadt, in der niemand mehr mitfühlt, sind sie plötzlich die Einzigen, die es noch können. Der Held war es immer.

---

## Prüfung: Widersprüche und Lücken

| # | Fund | Lösung *(Vorschlag)* |
| --- | --- | --- |
| 1 | „Verknotung: genug Knoten“ war nicht messbar | *(entschieden)* große Knoten mit Vorzeichen je Viertel, `verknotung_moeglich` (siehe `zuneigung_und_knoten.md`) |
| 2 | Regelwerk: Zerstörung, „der Held öffnet alle Übergänge **oder lässt Malcolm es tun**“. Aber Malcolm schwenkt auf die Raffung um | *(entschieden)* **Eine Falle:** Malcolm schwenkt in Akt 3 um und verbirgt es einen Akt lang. Wer ihm im Finale die Zerstörung überlässt, bekommt die Raffung. Nur wenn die Bruderschaft verknotet ist (`malcolm_knoten`), hält Malcolm Wort. Ist sie nur gebunden, aber nicht verknotet, zieht Pfötchen sie im Finale zurück in die Treue zum Vater. Wer `malcolm_risse` hoch hat, wird von einem Gefährten gewarnt |
| 9 | GDD (Akt 4) und Regelwerk (Akt 3) nannten verschiedene Zeitpunkte für Malcolms Umschwung | *(entschieden)* Akt 3, Boney Island |
| 3 | Der Held „kann das Knäuel nicht benutzen“, soll es aber zerstören können | Kein Widerspruch: Benutzen heißt Gefühle verschieben, dafür braucht man Resonanz. Übergänge öffnen kann nach Axiom 5 jeder, der es berührt. Die Zerstörung ist das Öffnen aller Übergänge |
| 4 | Der Richter tötet Pfötchen, und dann? | Das Knäuel ist herrenlos. Malcolm greift sofort danach. Der Held hat einen Zug: es selbst nehmen (Wächter), zerstören oder Malcolm lassen (Raffung) |
| 5 | Einwebung als Scheitern kann sich unfair anfühlen | Vorher spürbar machen: Ab mittlerer `held_verwachsung` warnen Gefährten, Junos Stimme wird lauter, die Fadensicht flackert. Im Finale fragt die Weberin (wenn dabei) direkt: „Willst du das wirklich?“ |
| 6 | Heimkehrer ohne Juno? | Möglich, aber dann geht er allein. Bei `juno_bogen = verloren` heißt der Weg nicht Heimkehr, sondern Flucht. Eigener Epilog-Satz |
| 7 | Hazel herausgeschnitten oder unlenkbar: Pfötchens Leitung fällt weg | *(korrigiert)* Leitung ist nach dem Regelwerk, wer den **Halter** am meisten liebt, nicht den Helden. Dann fließt der Nachhall durch Juno (wenn ihr Bogen verloren ist) oder durch Malcolm. Man sieht im Finale, wie es sie zerreißt |
| 8 | Das Finale spiegelt die Schlägerei aus Akt 1 noch nicht ausdrücklich | *(entschieden)* gleiche Mechanik, höchster Einsatz: Der Held holt gewendete Gefährten mit Worten zurück, nur zieht jetzt Pfötchen selbst. Wie schwer das ist, entscheidet die Knotenstärke |

---

## Das Finale *(entschieden 13.11.)*

**Eine Nacht, ein Schauplatz.** Akt 4 heißt „Die Stadt, die zerreißt“. Pfötchen lenkt den Zorn der Stadt auf Hazel, die Unruhen kippen in die letzte Nacht. Unten brennt Cathattan, oben im Tempel des Ordens hält Pfötchen das Knäuel. Wie viel brennt, zeigt `stadt_brand`: die sichtbare Summe aller großen Knoten, bevor der Spieler die letzte Entscheidung trifft.

**Grundsätze, damit es kein BG3-Klon wird:**
1. **Verbündete werden nicht gerufen, die Stadt rettet sich selbst.** Keine Beschwörung im Kampf. Was der Spieler geknüpft hat, zeigt sich daran, ob Viertel halten oder kippen: Eimerketten, Leute, die ihm einen Hinterhof öffnen, oder eine Menge, die sich gegen ihn dreht.
2. **Der Kampf ist ein Kampf um Liebe, nicht um Kontrolle.** Pfötchen steuert niemanden fremd. Er schiebt echte Gefühle, und die Gefährten greifen an, weil sie etwas anderes noch mehr lieben. Zurück holt man sie mit Worten, nicht mit Schaden.
3. **Am Ende wird es klein, wie im Noir.** Das Feuer ist Kulisse. Der Höhepunkt spielt in einem Raum: Vater und Sohn, das Knäuel zwischen ihnen. Der Held ist der Einzige, der ruhig durch den Aufruhr geht. Man kann das Finale beenden, ohne Pfötchen zu besiegen.

### Ablauf in der Maximalfassung *(entschieden 13.11.)*

**Methode:** Das Finale wird einmal vollständig gebaut, so als hätte der Spieler keinen einzigen Verbündeten. Das ist die Maximalfassung, die schwerste Version. Alles, was der Spieler über das Spiel gewonnen hat, nimmt davon etwas weg, erleichtert es oder öffnet einen anderen Weg. Was er sich verscherzt hat, macht es schwerer oder stellt sich auf Pfötchens Seite. So muss jede Station nur einmal gebaut werden, und jede Entscheidung des Spiels wird im Finale sichtbar.

**Station 0 · Die letzte Nacht** *(Unterschlupf in Cathattan)*
- Letzte Lagergespräche, die letzte Gelegenheit für Knötchen.
- **Aufstellung:** Vier gehen mit dem Helden. **Die übrigen Gefährten bekommen eine Aufgabe in der Stadt** (Tunnel, Dächer, Brücke, Löschketten) und tauchen an ihrer Station wieder auf. Niemand sitzt untätig im Lager, das unterscheidet uns von BG3.

**Station 1 · Der Sperrring** *(die Avenue vor dem Tempelbezirk)*
- **Maximal:** Straßensperre und zwei Trupps der Ordensgarde, Kampf.

**Station 2 · Die Menge** *(Tails Square, die Unruhen gegen Hazel)*
- **Maximal (`viertel_cathattan` = kippt):** Die Menge richtet sich gegen den Helden. Ein Kampf, in dem er niemanden töten darf, nur bewusstlos schlagen oder durchkommen. Es tut weh, weil das keine Feinde sind.
- **Wankt:** ein Abschnitt mit Proben (Schleichen, Überzeugen, Einschüchtern) statt Kampf.
- **Hält:** Eimerketten öffnen ihm eine Gasse. Die Station entfällt, und sie ist das schönste Bild auf dem Weg.

**Station 3 · Die Brücke zum Tempelberg**
- **Maximal:** drei Wellen Monsterhunde, angeführt von Captain Vale.
- **Das Opfer:** Bleibt nach allen Erleichterungen eine Welle übrig, hält sie ein Anführer einer verbündeten Gang auf und stirbt dabei.
  - **Nomapes:** Don Orango. Knuckles wird Anführerin, ihr Ausgang „Nachfolgerin“ bekommt seinen Moment.
  - **Breaking Cats:** Wurde Riff gerettet (`riff` = gerettet), ist es Riff. Er wirft den Ghettoblaster an („Riff, Take vier!“), legt mitten auf der Brücke einen Windmill hin, der so lächerlich gut ist, dass die Monsterhunde einen Moment lang verwirrt stehen bleiben, und reißt die vorderen mit über das Geländer. Komisch und furchtbar zugleich. Sonst ist es Adikatz: „Sag meinem Bruder, ich hab ihn gesucht.“
  - Sind beide Gangs verbündet, entscheidet der Spieler, wer geht, oder er verhindert es durch genug andere Hilfe.
- **Feindliche Gang:** Steht eine Gang gegen den Helden, kämpft sie an Vales Seite, als zusätzliche Welle mit ihrem Boss. Ist ihr Gefährte (Shiner oder Knuckles) dabei, steht er seiner eigenen Familie gegenüber und kann sie mit einer Probe zum Abzug bewegen.

**Station 4 · Das Tempeltor**
- **Maximal:** das Haupttor mit der Elite der Garde, Kampf.
- **Andere Wege:** Big Digs Tunnel unter den Tempel, über die Dächer mit Fitz, Mercys Seitentür, ein Lüftungsschacht, den die Tauben gefunden haben. Jeder ersetzt den Kampf durch eine kurze eigene Szene.

**Station 5 · Die Halle der Gläubigen**
- **Maximal:** Pfötchen wendet die Gefährten gegen den Helden (Knotenstärke entscheidet), die Gläubigen singen, und jede Strophe macht das Zurückholen schwerer.
- **Juno:** Ist ihr Bogen verloren, steht sie als Rednerin neben Pfötchen und spricht zur Halle. Der Held kann sie nicht bekämpfen, nur zu ihr reden. Dabei zählt der Kindheitsknoten, und das angefangene „Schraubensch…“ aus Akt 1 bekommt sein Echo.
- **Die Leitung:** Hat Pfötchen Hazel verloren (herausgeschnitten oder unlenkbar geworden), fließt der Nachhall durch den, der ihn jetzt am meisten liebt: Juno, wenn sie verloren ist, sonst Malcolm. Man sieht ihn leiden, während Pfötchen zieht.

**Station 6 · Vater und Sohn** *(der Raum mit dem Knäuel)*
- Ein Gespräch, das zum Kampf werden kann, aber nicht muss. Pfötchen kämpft nicht mit Klauen, sondern mit den Ketten der Stadt: Er zieht an den Gefährten, die noch nicht festgezurrt sind.
- **Malcolm** kommt dazu. Bruderschaft verknotet: Er steht beim Helden und hält Wort. Nur gebunden: Pfötchen zieht ihn zurück. Ohne Bruderschaft: Er bittet, das Knäuel zerstören zu dürfen (die Falle aus Fund 2).
- **Dann die Entscheidung** (Schicht 1 und 2), das Schlussbild und der Epilog.

### Was die Maximalfassung verändert

| Verbündeter oder Zustand | Wirkung |
| --- | --- |
| **Roach** (`roach` = erpresst) | Station 1 entfällt: Er fährt mit Vollgas durch die Sperre |
| **Tauben** (befreit oder Netz genutzt) | Station 1 leichter (nur ein Trupp), Station 4: Lüftungsschacht |
| **Hazel** (`hazel_status` = wissend oder verraten) | Station 1 leichter: Die Polizei zieht ab |
| **Fitz** | Station 2 entfällt (der Zirkus lenkt die Menge ab) oder Station 4 über die Dächer |
| **Viertel Cathattan** | hält: Station 2 entfällt · wankt: Proben · kippt: Kampf gegen Bürger |
| **Juno** (`juno_bogen` = frei_kommt_mit) | Station 2 leichter: Sie spricht zur Menge, gegen den Orden. Station 5: Sie kämpft mit |
| **Juno** (verloren) | Station 2 schwerer (sie predigt auf dem Platz), Station 5: Sie steht neben Pfötchen |
| **verbündete Gang** | Station 3: hält eine Welle Monsterhunde |
| **beide Gangs gemeinsam** (`gangs_gemeinsam`) | Station 3: hält zwei Wellen |
| **feindliche Gang** | Station 1 und 3: eine zusätzliche Welle mit ihrem Boss |
| **Barkley, Fanatiker** | Station 3 fast leer: Die befreiten Hunde überrennen Vales Meute. Dafür jagen sie danach Katzen (Epilog) |
| **Barkley, mehr als eine Liebe** | Station 3: eine Welle weniger, Barkley ruft die Hunde einzeln zu sich |
| **Vale** vor Gericht oder tot | Station 3 ohne Vale, die Meute ohne Führung ist leichter |
| **Big Dig** (neu verknotet) | Station 4 entfällt: Tunnel |
| **Mercy** | Schweigende: Station 4 entfällt (Seitentür) · Reformerin: Station 5 leichter (sie stellt Pfötchen vor den Gläubigen) |
| **Weberin** (Hüterin) | Station 5 und 6 leichter: Sie sagt an, an welcher Kette Pfötchen gerade zieht |
| **Delta Mae** | Station 5 leichter: Ihr letztes Lied übertönt die Gläubigen |
| **Corvin** (ganze Wahrheit) | Station 1 bis 3: Das Taubennetz meldet jede Bewegung, Hinterhalte entfallen |
| **Shiner** (Knotenmalerin) | Station 2: Die Menge erkennt ihre Wand und zögert |
| **Knotenstärke der Gefährten** | Station 5 und 6: wer gewendet wird und wie schwer er zurückzuholen ist |
| **Malcolm** | Station 6 (siehe oben) |

**Gangs:** Ob eine Gang verbündet, neutral oder feindlich ist, berechnet das Spiel aus Gang-Wahl, Auftrag und Knuckles' Bogen (`haltung_nomapes`, `haltung_cats`).

## Die Schlussbilder *(entschieden 13.11.)*

**Jedes Ende hat sein eigenes Bild derselben brennenden Nacht:**

| Ende | Schlussbild |
| --- | --- |
| **Zerstörung** | Mitten im Aufruhr bleiben alle stehen und sehen auf ihre Hände. Die Wut ist weg, nicht weil jemand sie beruhigt hat, sondern weil sie nie ihre eigene war. Die Feuer brennen weiter, aber niemand schreit mehr. Dann fangen die Ersten an zu löschen, jeder für sich |
| **Verknotung** | Eimerketten. Menschen, die sich eben noch geprügelt haben, reichen sich Wasser weiter. Pfötchen zieht am Knäuel, und nichts bewegt sich |
| **Wächter** | Der Morgen danach. Die Feuer sind von selbst ausgegangen. Der Held sitzt allein im leeren Tempel, das Knäuel im Schoß, und draußen fegt jemand die Asche |
| **Einwebung** | Das Feuer ist das Erste, was er je fühlt: die Angst der ganzen Stadt auf einmal, und mittendrin die Liebe seines Vaters. Er bricht zusammen. Als Erbe steht er danach auf |
| **Raffung** | Stille. Die ganze Stadt dreht sich gleichzeitig zu Malcolm um, Hunderttausende Gesichter, ein Blick |
| **Status quo** | Pfötchens Predigt im Fernsehen, wie am Ende von Akt 1. Die Stadt beruhigt sich als Welle, nur umgekehrt. Der Kreis schließt sich, und der Spieler weiß jetzt, was er sieht |
