# Tierarten: wie Meow York auf den Helden reagiert

*Stand 13.11.2026 · entschieden · Daten: `data/characters/tierarten.json` · Zustände: `held_art`, `held_unterart`*

## Grundsatz

**Die Art ist ein Milieu, keine Fähigkeit.** Was der Held kann, entscheidet die Klasse. Was die Stadt in ihm sieht, entscheidet die Art. Ein Insekt ist nicht schwächer als eine Katze, aber eine Katze kommt in Cathattan durch Türen, an denen ein Insekt abgewiesen wird.

**Keine Art ist die bessere.** Jede öffnet etwas und verschließt etwas. Wer oben willkommen ist, ist unten verdächtig, und umgekehrt. Die Art legt weder Persönlichkeit noch Beruf fest, nur, wie andere ihn ansehen.

**Drei Ebenen:**
1. **Gruppe** (zehn, siehe unten): Daran hängen die Reaktionen der Welt.
2. **Unterart** (frei wählbar innerhalb der Gruppe): Aussehen, und bei wenigen Unterarten eine eigene Besonderheit (Hauskatze, Taube, Waschbär, Dachs).
3. **Körper:** nur Optik und Animation. Fliegen, Klettern und Graben entscheidet die Klasse, nicht die Art.

**Reaktionen laufen über Systeme, nicht über tausend Sonderzeilen:**
1. **Startansehen** bei den Fraktionen
2. **Preise** in Bars, Läden und beim Zimmer
3. **Kontrollen der Garde:** ab welchem Wert von `orden_wachsam` sie ihn anhalten
4. **Anrede:** wie Fremde ihn nennen, bis er einen Namen hat
5. **Roachs Satz im Taxi** direkt nach der Wahl, einer je Gruppe
6. **Verwandtschaft** mit einem Gefährten (siehe unten)

Der Held bleibt in allen Fällen derselbe: Herkunft, Juno, Fadenlos. Die Art färbt die Welt, sie ändert die Geschichte nicht.

---

## Verwandtschaft *(entschieden)*

**Jede Gruppe hat einen Verwandten,** meist einen Gefährten. Verwandte erkennen den Helden als einen der Ihren. Das gibt ihm keine Abkürzung zum Ende, aber einen eigenen Zugang.

**Festes Paket je Gruppe und Akt** (damit keine Art bevorzugt wird und der Aufwand planbar bleibt):
- 2 bis 3 zusätzliche Gesprächsoptionen beim Verwandten
- 1 alternativer Lösungsweg in einer Quest
- 1 eigene Zeile in einer Pflichtszene oder Lagerszene

**Die Grenze:** Verwandtschaft macht Wege leichter oder anders. Sie schaltet kein Ende und keinen Ausgang frei, den andere Spieler nicht auch erreichen können. Die Verwandtschaftsoptionen stehen in den Dialogen unter der Bedingung `GameState.flag("held_art") == "<gruppe>"`.

**Aufwand:** 10 Gruppen × 4 Akte × etwa 5 Bausteine ≈ 200 kleine Inhalte. Das entspricht ungefähr einem zusätzlichen Gefährten, verteilt auf alle.

---

## Die zehn Gruppen

| Gruppe (`held_art`) | Unterarten | Verwandt mit | Kurz gesagt |
| --- | --- | --- | --- |
| `katzenartige` | **Hauskatzen:** Katze, Schwarzkatze, Tigerkatze, Siamkatze, Perserkatze, Ragdoll · **Großkatzen:** Löwe, Tiger, Leopard, Puma, Panther, Luchs | Shiner und die Breaking Cats (Großkatzen), der Orden (Hauskatzen) | Die Stadt gehört den Katzen, aber nicht allen Katzen gleich |
| `voegel` | Rabe, Spatz, Eule, Möwe, **Taube** | Corvin; die Taube mit Gus' Tauben | über den Dächern zu Hause |
| `krokodile` | Alligator, Krokodil, Kaiman | Delta Mae | die Legende aus dem Kanal |
| `kaengurus` | Känguru, Wallaby, Quokka | die Schausteller auf Boney Island | Zugereiste von Down Under |
| `maeuse_ratten` | Maus, Ratte, Hamster, Maulwurf | Big Dig | die Arbeiter, die keiner sieht |
| `fuechse` *(Standard)* | Rotfuchs, Polarfuchs, Fennek | niemand | der Fremde schlechthin |
| `marder` | Dachs, Marder, Otter, Stinktier, **Waschbär** | Juno (Waschbärin), Ansgar (Dachs) | die Gestrandeten der Straße |
| `insekten` | Kakerlake, Ameise, Biene, Käfer, Motte, Grille | Mercy, dazu Hummel, Ilse und Roach | ganz unten, und unten hält man zusammen |
| `spinnen` | Webspinne, Springspinne, Vogelspinne, Tarantel | die Weberin | Alle zucken zurück, eine erkennt ihn |
| `primaten` | Schimpanse, Gorilla, Orang-Utan | Knuckles und die Nomapes | Werkstatt, Hafen, Familie |

**Nur als NPCs:** Hasen (Hazel), Bären, Hirsche, Pferde, Schweine, Chamäleons (Vincenzo), Gänse (Odile). Sie haben in Meow York kein eigenes Milieu für einen Helden.

**Sprites:** Im NPC-Atlas gibt es bisher Katzen, Großkatzen (Löwe, Leopard, Panther), Vögel (Rabe, Spatz, Eule, Möwe, Taube), Maus, Ratte, Fuchs, Waschbär, Otter, Schimpanse. Für die übrigen Unterarten fehlen Grafiken.

---

## Wer wie reagiert

| | Straße Hairlem | Insekten | Breaking Cats | Nomapes | Orden und Garde (Kontrolle ab) | Cathattan (Akt 4) |
| --- | --- | --- | --- | --- | --- | --- |
| **Hauskatze** | Misstrauen, Preise +20 % | verschlossen | Verachtung („Samtpfote“) | Spott | herzlich (4) | Türen offen |
| **Großkatze** | Respekt, etwas Angst | vorsichtig | schneller Zugang | feindlich | „nicht die richtige Katze“ (2) | herablassend |
| **Vogel** | neutral | neutral | neutral | neutral | neutral (2) | höflich kühl |
| **Taube** | Abscheu, Preise +50 % | Mitleid | Spott | Spott | Schikane (1) | hinausgeworfen |
| **Krokodil** | Angst, man macht Platz | Angst | Respekt | Respekt | misstrauisch (2) | gefürchtet, geduldet |
| **Känguru** | neugierig, „wo kommst du her?“ | neutral | neutral | neutral | Papiere werden genau geprüft (2) | exotisch, Partygast |
| **Maus/Ratte** | übersehen | Solidarität | unterschätzen ihn | unterschätzen ihn | neutral (2) | Dienstboteneingang |
| **Fuchs** | neutral | neutral | neutral | neutral | neutral (2) | höflich kühl |
| **Marder** | neutral, Stinktier: Abstand | neutral | neutral | neutral | neutral (2) | höflich kühl |
| **Insekt** | übersehen | Familie, Rabatt bei Hummel | unterschätzen ihn | unterschätzen ihn | Aufnahme sofort (1) | abgewiesen, Hintereingänge |
| **Spinne** | Furcht, Kinder rennen weg | misstrauisch | neugierig | abergläubisch | „Achtauge“ (1) | Skandal |
| **Primat** | neutral | neutral | feindlich | schneller Zugang | neutral (2) | herablassend |

---

## Die Gruppen im Einzelnen

### Katzenartige
Die Stadt gehört den Katzen, aber nicht allen gleich.
- **Hauskatzen** sind in Hairlem Spitzel oder Verirrte. **Roach:** „Eine Hauskatze in meinem Taxi. Hast du dich verfahren, oder suchst du Ärger, Bruder?“ Hummel verlangt den „Cathattan-Preis“. Odile ist besonders herzlich, „eine von uns“, und das ist unheimlich. In die Mission kommt er als „verirrter Bruder“ ohne Probe. In Cathattan fällt er nicht auf.
- **Großkatzen** sind für Cathattan Straßenkatzen. **Roach:** „Großkatze. Gehörst du zu Adikatz' Leuten? Dann fahr ich schneller.“ Beim Battle darf er ohne Einladung in den Kreis. Die Nomapes glauben ihm nichts, „beide Aufträge annehmen“ wird schwerer.
- **Verwandt:** Shiner erkennt in der Großkatze einen Kletterpartner (eigene Lagerszenen-Zeile, ein Weg über die Dächer ohne Corvin). Der Luchs hat bei Malcolm eine eigene Zeile: „Noch einer, der nicht ganz dazugehört.“

### Vögel
- **Roach:** „Vogel. Warum nimmst du überhaupt ein Taxi?“ (Running Gag: Fliegen entscheidet die Klasse.)
- **Verwandt: Corvin.** Er öffnet sich schneller (Zuneigung +2 zu Beginn), redet über das Fliegen und über Rook. Gus lässt einen Vogel ohne Corvin aufs Dach.
- **Taube, die schwerste Wahl:** Beim Wählen erscheint „Tauben haben es in Meow York schwer. Manche Türen bleiben zu.“ **Roach:** „Eine Taube. Na, dich vermisst wenigstens keiner.“ Manche Läden bedienen ihn nicht. Bei der Schlägerei richtet sich ein Teil der Welle gegen ihn, denn Tauben sind nach den Insekten Pfötchens zweitliebster Sündenbock. Die Tauben-Quest wird seine persönlichste: Befreit er sie, befreit er seine Art. Die Tauben selbst erzählen ihm, wohin die Expedition geht (`juno_spur` +1).

### Krokodile
In Hairlem erzählt man sich von Krokodilen im Kanal. Jetzt steht eins an der Theke.
- **Roach:** „Mann. Ich dachte, euch gibt's nur in Geschichten.“ Er fährt sehr vorsichtig.
- Auf der Straße macht man ihm Platz, Einschüchtern ist leichter (SG −2), Überzeugen schwerer.
- **Verwandt: Delta Mae.** In den Subfurs (Akt 2) begrüßt sie ihn als „Cousin“, singt ihm ein Lied, das nur Krokodile kennen, und erzählt mehr über den Pakt mit dem Alten in der Tiefe. In Akt 2 kennen die Kanalbewohner ihn und lassen ihn einen Weg nehmen, den andere erst freikämpfen müssen.

### Kängurus
Zugereiste aus Down Under, Fremde wie der Held selbst. Das passt zu seiner Herkunft von außerhalb.
- **Roach:** „Und woher kommst du? Nein, warte, sag's nicht. Hört man.“
- Die Garde prüft Papiere besonders genau, und er hat keine.
- **Verwandt: die Schausteller auf Boney Island (Akt 3).** Kängurus boxen dort auf dem Jahrmarkt. Ein alter Boxer erkennt ihn und bringt ihn in den Ring, ein eigener Weg ins Lager des Ordens. Fitz' Familie kennt die Boxerfamilien, das gibt eine eigene Zeile mit Fitz.

### Mäuse und Ratten
Die Arbeiter in Küchen, Lagern und Kellern.
- **Roach:** „Ratte? Wir zwei verstehen uns, Bruder.“
- In der Mission kennt ihn das Küchenpersonal, als Helfer kommt er ohne Junos Armband hinein. Bosse unterschätzen ihn, Überzeugen bei ihnen ist schwerer.
- **Verwandt: Big Dig.** Für den Maulwurf ist er „einer von unten“. Big Dig erzählt früher von Pips, und in Roachs Garage gräbt er ihm von sich aus einen Gang.

### Füchse *(Standard)*
Der Fremde schlechthin. Niemand erwartet etwas von ihm.
- **Roach:** „Fuchs? Dann zähl ich meine Finger nach der Fahrt, Bruder.“
- **Keine Verwandtschaft, aber auch keine verschlossene Tür.** Der Fuchs ist die Wahl für Spieler, die die Welt ohne Färbung erleben wollen.

### Dachse und Marder
Die Gestrandeten der Straße.
- **Roach:** „Marder? Lass die Finger von meinem Auto.“
- **Waschbär:** Juno ist Waschbärin. Alle halten ihn für ihren leiblichen Bruder, obwohl er es nicht ist. Odile erkennt ihn sofort („Dieselbe Maske!“), Täuschen bei ihr wird schwerer (SG +3), Ehrlichkeit wärmer. In Akt 2 trifft ihn Junos Abweisung härter, weil Fremde sie für Geschwister halten.
- **Dachs:** Bruder Ansgar ist ein Dachs. Er öffnet sich einem Dachs leichter und wirbt ihn ohne Probe an. Das ist bequem und beklemmend.
- **Stinktier:** Man hält Abstand. Eine eigene komische Zeile bei Hummel.
- **Verwandt: Juno** (Waschbär) **und Ansgar** (Dachs). Für die übrigen Marder gilt die Straßengemeinschaft der Gestrandeten.

### Insekten
Die Ärmsten von Hairlem und der größte Sündenbock der Stadt, noch vor den Tauben. Unten hält man zusammen, und man wird übersehen, was ein Vorteil sein kann.
- **Roach:** „Einer von uns.“ Er raubt ihn trotzdem aus, und das ist härter als bei jedem anderen: „Geschäft ist Geschäft, Bruder. Du hättest dasselbe gemacht.“
- Ilse gibt mehr Hinweise ohne Probe, Hummel gibt Rabatt, Antonia öffnet die Garage ohne Probe. Der Orden nimmt ihn sofort auf („Gerade die Kleinsten nehmen wir zuerst“), und das passt bedrückend zu Roachs Liste. Die Garde hält ihn schon bei `orden_wachsam` 1 an.
- **Sündenbock:** Pfötchen lenkt Wut am liebsten auf Insekten, denn der Hass auf sie ist alt, abstrakt und kaum verknotet. Bei der Schlägerei und in der Gründungsnacht richtet sich ein Teil der Welle gegen den Helden selbst, wie bei der Taube.
- **Verwandt: Mercy** (Gottesanbeterin, Akt 1). Sie spricht mit ihm über Glauben, wie mit keinem anderen.

### Spinnen
Spinnen gelten in Meow York als unheimlich. Man fürchtet sie und braucht sie.
- **Beim Wählen** erscheint: „Spinnen werden in Meow York gefürchtet. Man wird dir aus dem Weg gehen.“
- **Roach:** „Acht Augen. Und keins davon guckt freundlich, Bruder.“
- Odile macht das Zeichen der Pfote, bevor sie lächelt. Kinder rennen weg, Einschüchtern ist leichter, Überzeugen bei Fremden schwerer. Die Garde nennt ihn „Achtauge“ und kontrolliert ab `orden_wachsam` 1.
- **Verwandt: die Weberin** (Akt 2). Sie erkennt ihn sofort als einen der Ihren. Sie erklärt ihm das Knäuel in Bildern, die nur Spinnen verstehen („Ein Netz, das jemand anders spinnt, und du bist der einzige Faden, der nicht klebt“). Einmal lässt sie ihn ihr Musterbuch lesen. Ihre Näherinnen behandeln ihn wie einen älteren Bruder. **Die Grenze:** Er erfährt dadurch nichts, was andere nicht auch über Corvin, Mercy oder die Weberin selbst erfahren können. Er erfährt es früher und persönlicher.

### Primaten
Die Nomapes sind Affen. Wer als Affe kommt, wird dort wie ein Neffe empfangen und von den Cats wie ein Spitzel.
- **Roach:** „Affe? Hafen ist da drüben, Bruder.“
- Don Orango nennt ihn „Junge“ und bietet ihm Arbeit an. Beim Battle lassen ihn die Cats nicht in den Kreis.
- **Verwandt: Knuckles.** Sie redet sofort mit ihm, zeigt ihm die Werkstatt und baut ihm die Attrappe des Ghettoblasters ohne Gegenleistung.

---

## Straßennamen *(entschieden 13.11.)*

Unter sich geben sich die Arten abfällige Namen, Straßenslang, so wie in den Achtzigern Bevölkerungsgruppen beschimpft wurden. Diese Namen sagen mehr über den, der sie benutzt, als über den, der gemeint ist.

**Regeln:**
- **Nur Figuren mit Vorurteil benutzen sie:** die Garde, Gang-Mitglieder im Streit, Nugget, Pöbel auf der Straße, Cathattans feine Gesellschaft (dort höflich verpackt). Freunde und Verbündete nie, außer als Zeichen, dass etwas kippt.
- **Die Erzählstimme, das Menü und Junos Stimme benutzen sie nie.** Die Gruppe heißt im Spiel immer bei ihrem Namen.
- **Ein Schimpfwort ist eine Reaktion der Welt, kein Witz auf Kosten des Spielers.** Der Held kann darauf reagieren: überhören, zurückgeben, einschüchtern. Das ist eine Gelegenheit für Haltung, nicht für Pointen.
- **Bei der Schlägerei** fallen die Namen in der Welle, aus dem Mund von Leuten, die vorher freundlich waren. So zeigt sich, was das Knäuel aus Abneigung macht.

| Gruppe oder Form | Straßenname | Wer ihn benutzt |
| --- | --- | --- |
| Hauskatzen | **Samtpfote** | Hairlem über die da oben, die Breaking Cats |
| Großkatzen | **Fleckfell** | Cathattan über die Straßenkatzen, die Nomapes |
| Vögel | **Federvieh** | Straße, Garde |
| Tauben | **Flugratte** | die ganze Stadt |
| Krokodile | **Kanalmaul** | Straße, Cathattan |
| Kängurus | **Beutler** | Garde, Zöllner, Cathattan |
| Mäuse und Ratten | **Pieper** | Bosse, Großkatzen |
| Füchse | **Rotpelz** | Nomapes (schon im Prototyp) |
| Dachse und Marder | **Stinker**, Waschbären **Maske** | Straße |
| Insekten | **Krabbler** | fast alle über die Ärmsten |
| Spinnen | **Achtauge** | Garde, Aberglaube auf der Straße |
| Primaten | **Schaukler** | Breaking Cats, Cathattan |
| Hunde | **Bestie** | der Orden, seit dem Hundekrieg |

Die Daten stehen als `schimpfwort` je Form in `tierarten.json`, die freundliche Anrede als `anrede`.

## Hunde: nicht wählbar *(entschieden)*

Ein freier Hund würde die ganze Geschichte verändern (Hundekrieg, Garde, Barkley). Deshalb stehen Hunde in der Auswahl, sind aber gesperrt, und das Spiel erklärt es in der Welt, nicht im Menü.

**Ablauf in der Charaktererstellung (im Taxi):**
- Das Hundebild ist sichtbar, aber verblasst, wie ein altes Foto.
- Wählt der Spieler es, bremst das Taxi scharf. Roach sieht in den Rückspiegel:
  > „Bruder. Einen Hund fahr ich nicht über die Brücke. Keiner tut das. Hunde gibt's nicht mehr, verstehst du? Nicht in Meow York. Nicht seit achtzig Jahren.“
- Darunter, klein und in der Schrift der Plakate: *Seit dem Hundekrieg gibt es in Meow York keine freien Hunde mehr.*
- **Beim zweiten Versuch:** „Hast du mich nicht gehört? Draußen am Pfeiler steht's dran: BEWARE OF THE BEASTS.“
- **Beim dritten Versuch:** Roach schweigt eine Weile. „Du bist mir unheimlich, Bruder.“ Danach wird das Bild endgültig grau.

Das ist zugleich der erste Hinweis auf den Hundekrieg, auf das Graffiti am Brückenpfeiler und auf Barkley, der sich in Akt 2 als andere Art verkleidet.

---

## Die Herkunft des Helden *(entschieden 13.11., geändert 14.11.)*

**In Meow York kommen Kinder nach einem Elternteil.** Der Held ist Pfötchens unehelicher Sohn und hat die Art seiner Mutter. **Pfötchens heimliche Geliebte war von genau der Unterart, die der Spieler wählt:** Ist der Held ein Rotfuchs, war sie eine Rotfüchsin. Ist er eine Vogelspinne, war sie eine Vogelspinne. Ist er eine Perserkatze, war sie eine Perserkatze. (`held_unterart` bestimmt ihr Bild in Rückblenden und auf dem Foto, das Pfötchen in seiner Kammer versteckt hält.)

**Was das für die Geschichte bedeutet:**
- **Der eigentliche Skandal ist das uneheliche Kind.** Das Oberhaupt des Ordens lebt ehelos. Eine heimliche Geliebte und ein versteckter Sohn würden sein Amt beenden, egal welcher Art sie war. Das Foto ist in Akt 4 eine Waffe gegen ihn.
- **Die Art verstärkt es:** War sie keine Katze, kommt ein zweiter Skandal dazu. War sie eine Großkatze, eine „Straßenkatze“. War sie eine Hauskatze, bleibt es beim ersten.
- **Für Malcolm:** Die Stadt sieht in ihm das Findelkind, das ein Heiliger allein großzieht. In Wahrheit war er der Ersatz für einen Sohn, den niemand kennen durfte.
- **Für den Spieler:** Seine Wahl im Taxi bekommt in Akt 4 eine Bedeutung, die er nicht erwartet hat, wenn er das Foto seiner Mutter sieht und sie aussieht wie er.
