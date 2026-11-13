# Tierarten: wie Meow York auf den Helden reagiert

*Stand 13.11.2026 · Daten: `data/characters/tierarten.json` · Zustand: `held_art`*

## Grundsatz

**Die Art ist ein Milieu, keine Fähigkeit.** Was der Held kann, entscheidet die Klasse. Was die Stadt in ihm sieht, entscheidet die Art. Ein Insekt ist nicht schwächer als eine Katze, aber eine Katze kommt in Cathattan durch Türen, an denen ein Insekt abgewiesen wird.

**Keine Art ist die bessere.** Jede öffnet etwas und verschließt etwas. Wer oben willkommen ist, ist unten verdächtig, und umgekehrt.

**Reaktionen laufen über Systeme, nicht über tausend Sonderzeilen:**
1. **Startansehen** bei den Fraktionen
2. **Preise** in Bars, Läden und beim Zimmer
3. **Kontrollen der Garde:** ab welchem Wert von `orden_wachsam` sie ihn anhalten
4. **Anrede:** wie Fremde ihn nennen, bis er einen Namen hat (und später „Fadenlos“)
5. **Schlüsselzeilen** bei wenigen festen Figuren: Roach im Taxi, Hummel, Ilse, Odile, Malcolm, Adikatz, Don Orango, Gus Rook
6. **Ein eigener Weg pro Akt,** den nur diese Art hat (sozial, nicht körperlich)

Der Held bleibt in allen Fällen derselbe: Herkunft, Juno, Fadenlos. Die Art färbt die Welt, sie ändert die Geschichte nicht.

---

## Die wählbaren Arten

| Gruppe (`held_art`) | Arten im Atlas | Kurz gesagt |
| --- | --- | --- |
| `gestrandet` *(Standard)* | Fuchs, Waschbär, Otter | gehört nirgends hin, fällt nirgends auf |
| `hauskatze` | Katze, Schwarzkatze, Tigerkatze, Siamkatze, Perserkatze, Ragdoll | oben willkommen, unten verdächtig |
| `grosskatze` | Löwe, Leopard, Panther | Katze, aber die falsche |
| `insekt` | Kakerlake, Ameise, Käfer, Hummel *(Sprites fehlen noch)* | ganz unten, und unten hält man zusammen |
| `affe` | Schimpanse | Werkstatt, Hafen, Familie |
| `vogel` | Rabe, Spatz, Eule, Möwe | über den Dächern zu Hause |
| `taube` | Taube | die Art, die alle hassen |
| `nager` | Maus, Ratte, Eichhörnchen | die Arbeiter, die keiner sieht |
| `hase` | Hase | Hazels Leute |

---

## Wer wie reagiert

| | Straße Hairlem | Insekten | Breaking Cats | Nomapes | Orden und Garde | Cathattan (Akt 4) |
| --- | --- | --- | --- | --- | --- | --- |
| **Gestrandet** | neutral | neutral | neutral | neutral | neutral, Kontrollen ab 2 | höflich kühl |
| **Hauskatze** | Misstrauen, Preise +20 % | verschlossen | Verachtung („Sofakissen“) | Spott | herzlich, Kontrollen erst ab 4 | Türen offen |
| **Großkatze** | Respekt, etwas Angst | vorsichtig | schneller Zugang, Adikatz vertraut eher | feindlich, Nugget misstraut | „Katze, aber nicht die richtige“, Kontrollen ab 2 | herablassend |
| **Insekt** | wird übersehen | Familie, Preise −20 % bei Hummel | unterschätzen ihn | unterschätzen ihn | Suppe und Aufnahme sofort, Kontrollen ab 1 | abgewiesen, Hintereingänge |
| **Affe** | neutral | neutral | feindlich | schneller Zugang, Don Orango nennt ihn „Junge“ | neutral, Kontrollen ab 2 | herablassend |
| **Vogel** | neutral | neutral | neutral | neutral | neutral, Kontrollen ab 2 | höflich kühl |
| **Taube** | Abscheu, Preise +50 %, manche bedienen ihn nicht | Mitleid | Spott | Spott | Garde schikaniert ihn, Kontrollen ab 1 | wird hinausgeworfen |
| **Nager** | übersehen | Solidarität | neutral | neutral | neutral, Kontrollen ab 2 | Dienstboteneingang |
| **Hase** | freundlich (Hazels Leute) | neutral | neutral | Benny begeistert, Don Orango misstrauisch (Hazels Kredit) | freundlich, Kontrollen ab 3 | freundlich herablassend |

---

## Die Gruppen im Einzelnen

### Gestrandet (Fuchs, Waschbär, Otter)
Der Standard, der Fremde schlechthin. Niemand erwartet etwas von ihm.
- **Roach im Taxi:** „Fuchs? Dann zähl ich meine Finger nach der Fahrt, Bruder.“
- **Waschbär:** Juno ist Waschbärin. Wer als Waschbär spielt, wird oft für ihren leiblichen Bruder gehalten. Odile erkennt ihn sofort („Dieselbe Maske!“), Täuschen bei ihr wird schwerer (SG +3), Ehrlichkeit wärmer. Die Ironie, dass er gar nicht ihr Blutsbruder ist, trägt die Pflegefamilien-Geschichte.
- **Eigener Weg in Akt 1:** keiner. Dafür keine verschlossene Tür.

### Hauskatze
Die Stadt gehört den Katzen, und in Hairlem weiß das jeder. Eine Hauskatze in Hairlem ist entweder ein Spitzel oder hat sich verlaufen.
- **Roach:** „Eine Hauskatze in meinem Taxi. Hast du dich verfahren, oder suchst du Ärger, Bruder?“ Er verlangt mehr Vorkasse.
- **Hummel:** „Für dich gilt der Cathattan-Preis.“ Er meint es nur halb als Witz.
- **Odile:** besonders herzlich, „eine von uns“. Das fühlt sich gut an und ist unheimlich.
- **Malcolm:** spöttisch: „Eine Hauskatze, die die Straße sucht. Das hatten wir auch mal.“
- **Breaking Cats:** Shiner nennt ihn „Sofakissen“, bis er sich auf dem Platz bewiesen hat.
- **Eigener Weg in Akt 1:** In die Mission kommt er als „verirrter Bruder“ ohne Probe. Dafür misstrauen ihm die Insekten, und Ilses Hinweise kosten Überzeugen.
- **Akt 4:** In Cathattan öffnen sich Salons, Banken und das Rathaus. Er ist der Einzige, der dort nicht auffällt, und genau deshalb wird er dort am meisten gebraucht.

### Großkatze (Löwe, Leopard, Panther)
Die Breaking Cats sind Großkatzen. Für Cathattan sind das Straßenkatzen, keine echten Katzen.
- **Roach:** „Großkatze. Gehörst du zu Adikatz' Leuten? Dann fahr ich schneller.“
- **Adikatz:** vertraut eher, sagt aber auch: „Du siehst aus wie wir. Das heißt nicht, dass du einer bist.“
- **Nugget:** sieht in ihm von Anfang an einen Cat. Beim Ghettoblaster wird Abkaufen teurer.
- **Eigener Weg in Akt 1:** Beim Battle darf er ohne Einladung in den Kreis. Dafür wird „Beide Aufträge annehmen“ schwerer, weil die Nomapes ihm nichts glauben.

### Insekt (Kakerlake, Ameise, Käfer, Hummel)
Die Ärmsten von Hairlem. Unten hält man zusammen, und man wird übersehen, was ein Vorteil sein kann.
- **Roach:** „Einer von uns.“ Er raubt ihn trotzdem aus, und das ist härter als bei jedem anderen. In der Garage sagt er: „Geschäft ist Geschäft, Bruder. Du hättest dasselbe gemacht.“
- **Ilse:** nennt ihn „Junge“ und gibt ihm mehr Hinweise ohne Probe.
- **Hummel:** gibt Rabatt und das bessere Zimmer.
- **Orden:** „Gerade die Kleinsten nehmen wir zuerst.“ Die Aufnahme geht schnell, und das ist bedrückend, weil es zu Roachs Liste passt.
- **Gangs:** unterschätzen ihn. Täuschen gegen Gang-Mitglieder ist leichter (SG −2).
- **Eigener Weg in Akt 1:** Das Insektennetz. Ilse, Antonia und die Insekten in Roachs Garage reden mit ihm, und Antonia öffnet die Garage ohne Probe. Dafür hält ihn die Garde schon bei `orden_wachsam` 1 an.
- **Akt 4:** In Cathattan wird er abgewiesen und muss Hintereingänge, Lieferanten und Dienstboten nutzen. Das ist ein anderer, oft schnellerer Weg.

### Affe (Schimpanse)
Die Nomapes sind Affen. Wer als Affe kommt, wird dort wie ein Neffe empfangen und von den Cats wie ein Spitzel.
- **Roach:** „Affe? Hafen ist da drüben, Bruder.“
- **Don Orango:** nennt ihn „Junge“ und bietet ihm Arbeit an.
- **Eigener Weg in Akt 1:** Die Werkstatt steht ihm offen, Knuckles redet sofort mit ihm. Dafür wird das Battle schwerer (die Cats lassen ihn nicht in den Kreis), und das Geheimfach beim Battle sehen die Cats eher.

### Vogel (Rabe, Spatz, Eule, Möwe)
Über den Dächern zu Hause, auf der Straße ein Gast.
- **Roach:** „Vogel. Warum nimmst du überhaupt ein Taxi?“ (Running Gag: Der Held kann nicht weit fliegen, Klasse entscheidet.)
- **Corvin:** freundet sich schneller an (Zuneigung +2 zu Beginn), fühlt sich aber auch eher beobachtet.
- **Gus Rook:** redet offener, Vogel zu Vogel. Die Tauben-Entscheidung wiegt schwerer, weil der Held einer Art angehört, die die Tauben ausnutzt oder befreit.
- **Eigener Weg in Akt 1:** Gus lässt ihn ohne Corvin aufs Dach. Dafür gibt es bei den Insekten nichts umsonst.

### Taube *(die schwerste Wahl)*
Die Stadt hasst Tauben, weil es zu viele gibt, die andere gezüchtet haben. Wer Taube spielt, spielt ein Leben in Verachtung.
- **Beim Wählen** erscheint ein Hinweis: „Tauben haben es in Meow York schwer. Manche Türen bleiben zu.“
- **Roach:** „Eine Taube. Na, dich vermisst wenigstens keiner.“ Der Satz kommt wieder, wenn es um die verschwundenen Kinder geht.
- **Hairlem:** Manche Läden bedienen ihn nicht, Kinder werfen Brot. Preise +50 %.
- **Gus Rook:** sieht in ihm erst Ware, dann vielleicht einen Spiegel. Die Tauben-Quest wird zur persönlichsten Quest des Spiels: Befreit er sie, befreit er seine Art. Nutzt er das Netz, nutzt er seine Art.
- **Pfötchen:** Hass auf Tauben ist der Sündenbock, auf den er Wut umlenkt. Bei der Schlägerei richtet sich ein Teil der Welle gegen den Helden selbst. Er wird zum Ziel, nicht nur zum Zeugen.
- **Eigener Weg in Akt 1:** Die Tauben selbst sprechen mit ihm, ohne Gus. Sie erzählen, wohin die Expedition geht (`juno_spur` +1).
- **Das Gegengewicht:** Wer es als Taube bis Cathattan schafft, hat die stärkste Geschichte von allen. Das sagt das Spiel nicht, es zeigt es im Epilog.

### Nager (Maus, Ratte, Eichhörnchen)
Die Arbeiter in Küchen, Lagern und Kellern, die keiner sieht.
- **Roach:** „Ratte? Wir zwei verstehen uns, Bruder.“
- **Eigener Weg in Akt 1:** In der Mission kennt ihn das Küchenpersonal. Als Helfer in der Küche kommt er ohne Junos Armband hinein. Dafür halten ihn Großkatzen und Affen für unwichtig, Überzeugen bei Bossen wird schwerer.

### Hase
Hazel Hopkins ist Häsin, die erste Nicht-Katze im Amt. Hasen sind stolz auf sie.
- **Roach:** „Hase? Wählst du auch die Hopkins? Die sagt, sie macht Hairlem sauber. Ich sag: Dann bin ich arbeitslos.“
- **Benny:** begeistert, „Einer von Hazels Leuten!“ Don Orango wird misstrauischer, weil er Hazels Kredit für eine Falle hält.
- **Eigener Weg in Akt 1:** Der Beamte aus Hazels Wohnungsprogramm spricht offen mit ihm. Dafür hält ihn Malcolms Bewegung für einen Rathaus-Spitzel, bis er sich bewiesen hat.

---

## Hunde: nicht wählbar *(entschieden 13.11.)*

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

## Offene Frage: die Herkunft des Helden *(zur Freigabe)*

**Das Logikloch:** Der Held ist Pfötchens leiblicher Sohn, und Pfötchen ist eine Perserkatze. Wenn der Spieler ein Insekt wählt, passt das nicht.

**Vorschlag:** In Meow York kommen Kinder nach einem Elternteil. **Pfötchens Frau war keine Katze, und der Spieler bestimmt mit seiner Wahl, welcher Art sie war.** Wählt er eine Katze, war sie eine Hauskatze wie Pfötchen. Wählt er etwas anderes, war sie von dieser Art.

Was das gewinnt:
- **Ein Geheimnis mehr für den Orden:** Das Oberhaupt der Katzen hat eine Nicht-Katze geheiratet. Cathattan hat sie das jeden Tag spüren lassen. Das erklärt, warum sie so zermürbt war, ohne dass Pfötchen allein schuld ist.
- **Ein zweiter Grund, den Sohn zu verstecken:** Er sollte vor dem Knäuel geschützt werden (fest), und ein Erbe, der keine Katze ist, hätte den Orden gespalten.
- **Für Malcolm:** Ein Luchs, aufgenommen als Ersatz für einen Sohn, der vielleicht nicht einmal eine Katze war. Das macht seine Wut noch bitterer.
- **Für den Spieler:** Seine Wahl am Anfang bekommt in Akt 3 oder 4 eine Bedeutung, die er nicht erwartet hat.

Wählt der Spieler eine Hauskatze, entfällt der Skandal. Dann ist die Geschichte ruhiger, aber nicht schwächer: Er sieht aus wie einer von ihnen und ist es doch nicht.
