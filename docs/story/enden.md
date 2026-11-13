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
| **Verknotung** *(das verdiente Ende)* | Das Knäuel bleibt, kann aber kaum noch etwas bewegen, weil die Stadt zu fest verknotet ist | Auch Fehden und schlechte Bindungen werden starr | genug Knoten in Gruppe und Stadt (siehe unten) |
| **Wächter** | Der Held nimmt das Knäuel an sich. Er kann es nicht benutzen, also benutzt es niemand | Nur vertagt. Seine Freunde bleiben Druckmittel, er bleibt allein | immer wählbar |
| **Einwebung** | Der Held lässt sich an seiner Narbe wieder einspleißen oder wird beim Anknüpfen eingesponnen. Er fühlt zum ersten Mal die Stadt und seinen Vater | Er wird lenkbar. Als Herrscher (Weg „Der Erbe“) würde Juno seine Leitung | gewählt, oder als Scheitern bei hoher `held_verwachsung` |
| **Raffung** | Malcolm schiebt alle unverknoteten Gefühle der Stadt in Schlingen um sich selbst. Alle haben nur noch eine Schlinge, um ihn | Malcolms eigene Leere bleibt. Er hat alle und fühlt nichts | Malcolm bekommt das Knäuel: Weg „Das Werkzeug“, oder der Held überlässt ihm die Zerstörung ohne verknotete Bruderschaft (Fund 2) |
| **Status quo** | Pfötchen behält das Knäuel | Ordnung durch Feindbilder, die Stadt kühlt weiter aus | Pfötchen siegt, oder der Held geht (Weg „Der Heimkehrer“) |

**Messbar machen, was „genug Knoten“ heißt** *(Vorschlag)*: eine berechnete Variable `stadt_verknotung` aus Punkten:

| Punkt | Quelle |
| --- | --- |
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
| 1 | „Verknotung: genug Knoten“ war nicht messbar | `stadt_verknotung` mit Punkten (oben) |
| 2 | Regelwerk: Zerstörung, „der Held öffnet alle Übergänge **oder lässt Malcolm es tun**“. Aber Malcolm schwenkt auf die Raffung um | *(entschieden)* **Eine Falle:** Malcolm schwenkt in Akt 3 um und verbirgt es einen Akt lang. Wer ihm im Finale die Zerstörung überlässt, bekommt die Raffung. Nur wenn die Bruderschaft verknotet ist (`malcolm_knoten`), hält Malcolm Wort. Ist sie nur gebunden, aber nicht verknotet, zieht Pfötchen sie im Finale zurück in die Treue zum Vater. Wer `malcolm_risse` hoch hat, wird von einem Gefährten gewarnt |
| 9 | GDD (Akt 4) und Regelwerk (Akt 3) nannten verschiedene Zeitpunkte für Malcolms Umschwung | *(entschieden)* Akt 3, Boney Island |
| 3 | Der Held „kann das Knäuel nicht benutzen“, soll es aber zerstören können | Kein Widerspruch: Benutzen heißt Gefühle verschieben, dafür braucht man Resonanz. Übergänge öffnen kann nach Axiom 5 jeder, der es berührt. Die Zerstörung ist das Öffnen aller Übergänge |
| 4 | Der Richter tötet Pfötchen, und dann? | Das Knäuel ist herrenlos. Malcolm greift sofort danach. Der Held hat einen Zug: es selbst nehmen (Wächter), zerstören oder Malcolm lassen (Raffung) |
| 5 | Einwebung als Scheitern kann sich unfair anfühlen | Vorher spürbar machen: Ab mittlerer `held_verwachsung` warnen Gefährten, Junos Stimme wird lauter, die Fadensicht flackert. Im Finale fragt die Weberin (wenn dabei) direkt: „Willst du das wirklich?“ |
| 6 | Heimkehrer ohne Juno? | Möglich, aber dann geht er allein. Bei `juno_bogen = verloren` heißt der Weg nicht Heimkehr, sondern Flucht. Eigener Epilog-Satz |
| 7 | Hazel herausgeschnitten (Weberin, Akt 4): Pfötchens Plan, sie zur Leitung zu machen, scheitert | Gewollt. Dann muss Pfötchen im Finale einen Gefährten als Leitung nehmen, und zwar den, der den Helden am meisten liebt. Der härteste Finalkampf |
| 8 | Das Finale spiegelt die Schlägerei aus Akt 1 noch nicht ausdrücklich | Vorschlag: gleiche Mechanik, höchster Einsatz. Wie auf dem Basketballplatz holt der Held gewendete Gefährten mit Worten zurück, nur dass es jetzt Pfötchen selbst ist, der zieht |

---

## Das Bild des Endes *(zur Klärung)*

**Vorschlag: eine Nacht, ein Schauplatz, sechs Schlussbilder.**

Akt 4 heißt „Die Stadt, die zerreißt“. Pfötchen lenkt den Zorn der Stadt auf Hazel, die Unruhen kippen in die letzte Nacht. Das Finale findet in dieser Nacht statt: unten brennt Cathattan, oben im Tempel des Ordens hält Pfötchen das Knäuel.

**Wie viel brennt, entscheidet der Spieler** (`stadt_brand`, berechnet aus Gang-Frieden, Tauben, Hunden, Hazel, Delta Maes Lied, Fitz' Zirkus): von ein paar Feuern, die gelöscht werden, bis zu „Cathattan brennt“. Der Brand ist die sichtbare Summe seiner Entscheidungen, bevor er die letzte trifft.

**Jedes Ende hat sein eigenes Bild derselben brennenden Nacht:**

| Ende | Schlussbild |
| --- | --- |
| **Zerstörung** | Mitten im Aufruhr bleiben alle stehen und sehen auf ihre Hände. Die Wut ist weg, nicht weil jemand sie beruhigt hat, sondern weil sie nie ihre eigene war. Die Feuer brennen weiter, aber niemand schreit mehr. Dann fangen die Ersten an zu löschen, jeder für sich |
| **Verknotung** | Eimerketten. Menschen, die sich eben noch geprügelt haben, reichen sich Wasser weiter. Pfötchen zieht am Knäuel, und nichts bewegt sich |
| **Wächter** | Der Morgen danach. Die Feuer sind von selbst ausgegangen. Der Held sitzt allein im leeren Tempel, das Knäuel im Schoß, und draußen fegt jemand die Asche |
| **Einwebung** | Das Feuer ist das Erste, was er je fühlt: die Angst der ganzen Stadt auf einmal, und mittendrin die Liebe seines Vaters. Er bricht zusammen. Als Erbe steht er danach auf |
| **Raffung** | Stille. Die ganze Stadt dreht sich gleichzeitig zu Malcolm um, Hunderttausende Gesichter, ein Blick |
| **Status quo** | Pfötchens Predigt im Fernsehen, wie am Ende von Akt 1. Die Stadt beruhigt sich als Welle, nur umgekehrt. Der Kreis schließt sich, und der Spieler weiß jetzt, was er sieht |
