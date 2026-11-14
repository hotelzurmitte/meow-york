# Zuneigung, Knötchen und große Knoten

*Stand 13.11.2026 · entschieden · Code: `GameState.zuneigung_aendern()`, `GameState.knoetchen()`, `GameState.knoten_reisst()`, `GameState.grosser_knoten()` · Daten: `data/zustaende/grosse_knoten.json`*

Zwei Dinge halten einen Menschen beim Helden, und sie sind nicht dasselbe:

| | Zuneigung | Knötchen und Knoten |
| --- | --- | --- |
| **Im Regelwerk** | die Schlinge: wie viel ihm der Held bedeutet | der Knoten: gemeinsames Erleben, das die Schlinge zunäht |
| **Im Taschen-Bild** | wie viel Geld in der Tasche für den Helden steckt | wie viel von dieser Tasche zugenäht ist |
| **Entsteht durch** | was der Held tut: Gefällt es dem Gefährten oder nicht? | was beide gemeinsam erleben |
| **Schwankt** | ständig, nach oben und unten | wächst langsam, sinkt selten, reißt nur durch Verrat |
| **Entscheidet** | ob er bleibt, wie er redet, Romanzen, Quest-Ausgänge | ob Pfötchen ihn im Finale gegen den Helden wenden kann |

**Warum beides zählt:** Pfötchen kann nur verschieben, was nicht zugenäht ist. Viel Zuneigung ohne Knoten ist eine volle, offene Tasche, das perfekte Ziel. Ein Knoten ohne Zuneigung ist eine fast leere, zugenähte Tasche. Sie ist sicher, aber er bleibt nur aus Gewohnheit.

---

## 1. Zuneigung *(Zu- und Abneigung der Gefährten)*

**Skala −10 bis +10**, Start 0. Gespeichert in `GameState.zuneigung`, abgefragt über `<g>_zuneigung`.

| Wert | Stufe | Folge |
| --- | --- | --- |
| +6 bis +10 | **hoch** | Romanze möglich, beste Ausgänge der persönlichen Quest, eigene Zeilen im Finale |
| −3 bis +5 | **mittel** | normaler Umgang |
| −4 bis −7 | **niedrig** | Widerspruch, Sticheleien, verweigert manche Hilfe |
| −8 und weniger | **Bruch** | Er verlässt die Gruppe, wie in BG3. Einmal im Spiel kann der Held ihn zurückholen, wenn er etwas wiedergutmacht |

**Was die Zuneigung bewegt:**
- **±1:** Der Gefährte mag oder missbilligt, was der Held tut oder sagt. Einblendung: „Corvin gefällt das.“
- **±2:** Es trifft seinen Kern (siehe Tabelle unten). „Corvin gefällt das sehr.“
- **±3:** seltene, große Momente, etwa wenn der Held für ihn etwas Wichtiges aufgibt oder ihn bloßstellt.

**Vorlieben der Gefährten** *(Entwurf, abgeleitet aus Will und Braucht in `steckbriefe.md`)*:

| Gefährte | Gefällt (+) | Missfällt (−) |
| --- | --- | --- |
| **Big Dig** | Kinder schützen, bleiben, wenn es schwer wird, Arbeit mit den Händen | Kinder im Stich lassen, Abstand halten, Ausreden |
| **Corvin** | Wahrheit, Beweise, Verantwortung übernehmen | Lügen, Unschuldige opfern, Ausreden für eigene Fehler |
| **Shiner** | Mut, Kunst, Ehre der Crew, etwas wagen | Ausverkauf, Feigheit, Kunst kleinreden |
| **Knuckles** | Frieden stiften, reparieren statt zerstören, Familie | unnötige Gewalt, Schulden machen, die Familie verraten |
| **Weberin** | Genauigkeit, Wissen schützen, ehrliche Fragen | Missbrauch von Wissen, Sentimentalität als Ausrede |
| **Barkley** | Hunde befreien, Herren zur Rechenschaft ziehen | Herren schonen, Katzen-Arroganz, Kompromisse mit der Garde |
| **Delta Mae** | ehrliche Kunst, zuhören, ihr die Bühne lassen | Gefühle vortäuschen, sie übergehen, Lucien schmeicheln |
| **Mercy** | Barmherzigkeit, Patienten zuerst, Glaube ohne Kirche | Grausamkeit, Heuchelei, Menschen als Mittel |
| **Fitz** | Freude, Wagemut, ihn ernst nehmen | ihn wie ein Kind behandeln, Langeweile, ihm das Fliegen verbieten |

---

## 2. Knötchen *(gemeinsames Erleben)*

**3 Knötchen = 1 Knoten.** Höchstens 9 Knötchen, also Knotenstärke 0 bis 3 (`<g>_knoetchen`, berechnet `<g>_knoten`).

**Woher Knötchen kommen:**

| Moment | Knötchen |
| --- | --- |
| tiefes, ehrliches Gespräch im Lager (eins pro Akt und Gefährte, oft optional) | +1 |
| Pflicht-Lagerszene mit einer echten Entscheidung | +1 |
| außergewöhnliche Tat des Helden vor seinen Augen, die seinen Kern trifft (Zuneigung +2 oder +3 und gemeinsam erlebt) | +1 |
| großes gemeinsames Erlebnis: die Schlägerei in Akt 1, der Höhepunkt der persönlichen Quest | +2 |
| negativer gemeinsamer Moment: Der Held handelt vor seinen Augen gegen seine Werte, und beide wissen es | −1 |
| **Verrat** (Regelwerk, Axiom 4): Der Held bricht die gemeinsame Geschichte | **alle weg** |

Über das Spiel gibt es je Gefährte etwa 10 bis 12 mögliche Knötchen. Für einen festgezurrten Knoten (9) muss der Spieler die meisten nutzen, aber nicht alle. **Das Lager lohnt sich:** Wer die optionalen Gespräche führt, knüpft fester als wer nur die Pflichtszenen sieht.

**Darstellung:** Ein Knötchen erscheint als kleiner Faden zwischen den beiden Porträts. Bei jedem dritten zieht er sich zu, mit eigenem Klang: „Knoten geknüpft“. In Akt 1 ist das nach der Schlägerei (+2) möglich, wenn der Spieler vorher schon ein Gespräch im Lager geführt hat.

**Im Finale:**

| Knotenstärke | Pfötchen versucht ihn zu wenden |
| --- | --- |
| **3 · festgezurrt** | Er bekommt ihn nicht zu fassen |
| **2 · verknotet** | Er schwankt eine Runde, kommt mit einer leichten Probe zurück |
| **1 · angeknotet** | Er wird gewendet, zurückholbar mit einer schweren Probe (wie bei der Schlägerei) |
| **0 · nur Zuneigung** | Er kämpft die ganze Phase gegen den Helden. Man muss ihn bewusstlos schlagen, nicht töten. Fällt Pfötchen, kommt er zu sich |

**Herausgeschnittene** (`weberin_herausgeschnitten`) sind nicht wendbar, egal wie viele Knötchen sie haben.

**Malcolm** ist ein Sonderfall (`malcolm_knoten`, siehe `charakterbiografien.md`), weil er spät und nur über die Bruderschaft dazukommt.

---

## 3. Große Knoten *(die Stadt)*

**Ein großer Knoten entsteht, wenn viele Menschen gemeinsam etwas erleben.** Knoten halten alles fest, auch Hass. Deshalb hat jeder ein Vorzeichen: Positive verbinden die Menschen untereinander und mit dem Helden, negative knoten Wut, Angst oder die Bindung an den Orden fest. **Jeder negative hebt einen positiven auf.**

Die Stadt wird nach Vierteln gerechnet, weil sie im Finale unterschiedlich reagiert:

| Viertel | Positiv (+1) | Negativ (−1) |
| --- | --- | --- |
| **Hairlem** | Waffenstillstand (Nugget bloßgestellt) · Platz gerettet (Mimi, Benny, Pounce) · Tauben befreit | Gang-Hass (Auftrag ausgeführt) · Tauben unter Druck genutzt |
| **Subfurs** | Hunde befreit · Delta Maes Konzert | Expedition ungestört |
| **Boney Island** | Shiners Knotenwand · Fitz' Show | Erweckungslager ungestört |
| **Cathattan** | Gangs ziehen gemeinsam ein · Hazels Liebe legt sich um die Stadt · Konzert im Park · Gedenken am Brunnen | Unruhen gegen Hazel ungebremst · Brunnen gestürzt |

**Bilanz je Viertel** (`viertel_<name>`):

| Bilanz | Im Finale |
| --- | --- |
| **+2 und mehr · hält** | Eimerketten. Pfötchens Zug geht ins Leere, die Leute helfen dem Helden |
| **0 bis +1 · wankt** | Teile kippen, mittlerer Brand, Verbündete von dort kommen nur zur Hälfte |
| **unter 0 · kippt** | Es brennt. Die Menge richtet sich gegen den Helden und seine Verbündeten |

**Daraus berechnet:**
- `stadt_brand`: von „funken“ (nichts kippt, höchstens ein Viertel wankt) über „strassen“ und „viertel“ bis „cathattan_brennt“ (zwei Viertel kippen oder Cathattan kippt).
- `verknotung_moeglich`: **mindestens drei Viertel halten und keins kippt.** Der Spieler sieht diesen Wert nie. Er erfährt ihn erst, wenn er im Finale loslässt.

**Cathattan ist der Engpass:** Der Held kommt erst in Akt 4 dorthin. Mit dem Central Bark gibt es dort vier positive Knoten (14.11.), zwei davon über Gefährten (Delta Mae, Barkley). Akt 4 bleibt ein Wettlauf um Cathattan, aber kein unfairer.

Die Liste ist ein Anfang. Weitere große Knoten entstehen beim Schreiben von Akt 2 bis 4, immer mit Viertel und Vorzeichen in `grosse_knoten.json`.
