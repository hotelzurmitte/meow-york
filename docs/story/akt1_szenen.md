# Akt 1: Hairlem – „Die Stadt, die fühlt“

Stand: 13.11.2026 · Szene für Szene. Baut auf GDD, Regelwerk und `docs/story/` auf und übernimmt, was der Prototyp schon kann (Dialoge in `data/dialogues/kapitel1_*.dialogue`). Vorschlag, bis freigegeben.

**Was der Akt leisten muss:** Der Spieler lernt allein die Grundsysteme, gewinnt Big Dig, Corvin und Shiner oder Knuckles, verfolgt Junos Spur, erlebt zum ersten Mal, dass er „fadenlos“ ist, trifft Malcolm, hört die Kassette, wählt eine Gang und erfährt am Ende: Nicht das Rathaus regiert, sondern der Orden.

**Drei Fäden laufen durch den ganzen Akt:**

1. **Juno:** Brief → leere Wohnung → ihr Name auf einer Liste → Ziel: die Tunnel.
2. **Die Mantelmänner:** Pilger und Kinder verschwinden. Werber des Ordens holen sie, Roach verkauft ihnen Namen. Das führt zu Mimi, zu Juno und am Ende zum Orden.
3. **Der Bandenkrieg:** Der goldene Ghettoblaster, Lil' Riffs Kassette, Malcolm, der beide Gangs bezahlt.

**Dauer:** etwa 10 bis 12 Stunden.

---

## Prolog

### P1 · Der letzte Brief
*Zuhause, außerhalb der Stadt · Held allein · neu*

- Junos letzter Brief, drei Monate alt: fröhlich, aber ein Satz fällt auf. „Ich glaube, ich habe endlich eine Familie gefunden, die mich gesucht hat.“ Danach nichts mehr.
- **Charaktererstellung** an Ort und Stelle: Name, Tierart, Klasse. Die Pflegemutter fragt, ob er sicher ist. Erste Dialogwahl mit Haltung, noch ohne Probe.
- Erste Notiz im Tagebuch: Junos Absender in der Mulberry Street, Hairlem.
- **Ton:** ruhig, warm, ein bisschen fremd. Der Held fragt die Pflegemutter: „Ist sie traurig? Am Telefon klang sie anders.“ Er weiß es nicht von selbst.

### P2 · Die Rückbank
*Fahrt nach Hairlem · Papa Roach · Prototyp: `kapitel1_ankunft`*

- Roach hält jeden Neuankömmling für einen Pilger: „Jede Woche kommen Pilger und wollen ein Stück vom Knäuel.“ Das Knäuel ist für ihn ein Märchen für Leute mit Geld.
- Im Autoradio läuft eine Predigt von Meister Pfötchen. Roach dreht lauter, ohne es zu merken. Durchs Fenster ziehen Wahlplakate vorbei: Hazel Hopkins, „Eine von uns“.
- Ein Monsterhund an der Brückenauffahrt nach Cathattan. Roach senkt die Stimme. Erste Andeutung des Hundekriegs. **Vorschlag:** Es ist Barkley, der hier noch als Monster unter Vale Wache steht.
- **Probe:** Wahrnehmung. Roach zählt beim Fahren heimlich, wie viel Bargeld der Held dabei hat.

### P3 · Die Gasse
*Hinterhof an der Whisker Avenue · Roachs Leute, Ilse · Prototyp*

- Roach lässt den Helden „an einer Abkürzung“ raus. Insekten überfallen ihn. **Erster Kampf**, allein, kaum zu gewinnen. Danach sind 120 Collar weg (`robbed`).
- Ilse, eine alte Insektendame, hilft ihm auf. Sie erzählt: Erst verschwinden Pilger, Fremde, die zu laut nach dem Knäuel fragen, dann Kinder. „Seit die einen verschwinden, verschwinden auch die anderen.“
- **Erster Faden:** Ilse nennt Roachs Garage und das Cuckoo's Nest, wo es Arbeit gibt.

---

## Teil A: Allein in Hairlem

### 1 · Whisker Avenue
*Zentrum · Ilse, Motte Mira, Grille Grimm · Prototyp*

- Freie Erkundung, die ersten **Würfelproben** in kleinen Gesprächen.
- Im Schaufenster eines Fernsehladens: Pfötchen segnet Hazel Hopkins. Alle Passanten bleiben stehen. Der Held sieht nur, dass sie stehen bleiben.
- **Grille Grimm** verlangt einen Collar für eine Weisheit: „Achtet auf die Pfote, Kinder.“
- **Motte Mira:** „Die Pilger werden mehr. Und die Männer in den guten Mänteln auch.“

### 2 · Das Cuckoo's Nest
*Bar und Absteige · Hummel · Prototyp: `kapitel1_bar`*

- Hummel gibt dem Helden Arbeit: eine Schicht am nächsten Abend. Dafür bekommt er das Zimmer über der Bar billiger. **Hauptunterschlupf von Akt 1** (`unterschlupf = cuckoos_nest`).
- Gerücht an der Theke: Zimmer 7 steht oft leer, aber ein Mann im Mantel geht dort ein und aus.
- **Nebenquest „Honig für Hummel“** (Prototyp) kann hier beginnen.
- **Erste lange Rast:** noch allein, keine Lagerszene. Der Held liest Junos Brief noch einmal. Ein stiller Moment, der zeigt, wie leer der Unterschlupf ohne Gefährten ist.

### 3 · Junos Wohnung
*Mulberry Street · Nachbarin, Pips · neu, mit Prototyp-Figur Pips*

- Die Wohnung ist leer und aufgeräumt, zu aufgeräumt. Die Nachbarin sagt: Juno ist „zu den Weißen“ gegangen, zum Orden, und war dabei glücklich wie nie.
- **Erstes Spurenlesen (Tutorial):** Das System „Beobachtung statt Bauchgefühl“ wird eingeführt. Der Held findet:
  - ein Familienfoto, umgedreht auf dem Nachttisch. Das ist die **Leere an anderer Stelle**.
  - Ordensblätter, sorgfältig gesammelt, mit Junos Randnotizen: „Endlich jemand, der mich meint.“
  - einen unfertigen Brief an ihn, nie abgeschickt. Mitten im Satz hört er auf.

  Jede Spur ist eine Beobachtung ohne Urteil. Erst zusammen ergeben sie ein Bild: Ihre Sehnsucht hat eine neue Richtung bekommen.
- **Pips**, ein Straßenkind, rennt im Hof herum: „Fang mich doch!“ Er erwähnt nebenbei seine Freundin Mimi, die auch weg ist.
- **Zustand:** `juno_spur` +1 (neue Variable, siehe unten).

### 4 · Roachs Garage
*Garage im Süden · Antonia, Big Dig · Prototyp: `kapitel1_strasse`, umgebaut*

- Ziel: das gestohlene Geld zurückholen. Antonia bewacht die Kellertür. Es gibt drei Wege: überreden, schleichen oder durch die Kanalisation. Damit lernt der Spieler, dass jede Aufgabe mehrere Wege hat.
- **Im Keller trifft der Held Big Dig.** Der Maulwurf hat sich von unten in Roachs Keller gegraben. Er sucht nicht Geld, sondern Roachs Liste. Er hat gehört, dass Roach Namen verkauft, und Mimi ist verschwunden.
- Zusammen knacken sie den Geldschrank. Darin liegen das Geld des Helden, das Geld anderer Pilger und die **Pilgerliste**: Namen und Preise, ein Eintrag „Mantel – Do.“. Weiter unten steht **Juno**, mit dem Vermerk „fragt viel, allein, keine Familie in der Stadt“. Und: **Mimi**, „Waise, Karton hinter der Garage“.
- Roachs Leute kommen zurück. **Erster Kampf zu zweit:** Big Dig taucht hinter den Gegnern aus dem Boden auf. Hier lernt der Spieler das Zusammenspiel.
- **Big Dig schließt sich an** (`dig_beigetreten`). Sein Grund: „Du suchst wen. Ich such wen. Und du lässt dich hier sonst umbringen.“
- **Entscheidung:** das Geld der anderen Pilger Ilse bringen oder behalten (Prototyp: `pilgerGeld`). Big Dig reagiert darauf.
- **Unschöne Seite, angelegt:** Auf dem Rückweg sieht Big Dig einen Ordensbruder in Weiß und will ihn verprügeln. Der Held kann ihn anstacheln oder bremsen. Der Bruder weiß von nichts.

### 5 · Lagerszene Big Dig (Pflicht)
*erste lange Rast danach · Unterschlupf nach Wahl: Zimmer im Nest oder Big Digs Keller*

- Big Dig erzählt von Mimi, einem kleinen Mäusemädchen, das seit einem Jahr in seinem Keller schlief und malte. Er hat sie nie zum Fluss mitgenommen, wie sie wollte. „Ich bin nicht ihr Vater.“ Er sagt es zu oft.
- Der Held fragt, wie es ihm geht, weil er es nicht sieht. Big Dig antwortet ehrlich, weil ihn das noch nie jemand gefragt hat.
- **Zustand:** `dig_lagerszene = 1`.

### 6 · Mimis Karton
*hinter Roachs Garage · Big Dig, Pips · Prototyp*

- Pips führt die beiden zu Mimis Pappkarton. Darin liegen eine Decke, ein Wachsmalstift und ein gefaltetes Blatt.
- **Mimis Zeichnung:** eine große Gestalt im Mantel, ein Auto, ein Wollknäuel. Darunter: „DER MANN SAGT ICH DARF MIT ZUM KNEUL.“
- Big Dig faltet sie zusammen und steckt sie in die Brusttasche. Das ist ab jetzt seine **Requisite**: „Ich find dich, Kleine.“
- **Zustand:** `mimiFound` (Prototyp).

---

## Teil B: Corvin und die Dächer

### 7 · Die Schicht und Zimmer 7
*Cuckoo's Nest, am Abend · Hummel, Nomapes, Corvin · Prototyp, umgebaut*

- Die Schicht ist ein kleines Spiel mit Bestellungen, Gesprächsfetzen und Gästen, die man beruhigen muss. Wer sie verpasst, verliert Hummels Vertrauen (`shiftMissed`).
- Ein Nomape lallt: „Zimmer 7 war wieder offen. Der Mantelmann hat 'ne Liste dagelassen.“
- **Auftritt Corvin:** Ein Rabe sitzt draußen am Fenster von Zimmer 7, auf der Feuertreppe. Er ist Privatdetektiv und von der Familie eines verschwundenen Pilgers bezahlt. Ins Nest darf er nicht, Hummel hat dem Ex-Cop Hausverbot erteilt.
- **Erste große Probe zu dritt:** Der Held kommt als Angestellter ins Zimmer. Big Dig hält Wache, Corvin dirigiert von draußen. Im Zimmer liegen eine Liste mit Pilgernamen und ein Siegel aus weißem Wachs mit einem eingeprägten Knäuel.
- Auf der Liste steht Mimi, „Waisenhaus“. Juno steht nicht darauf, sie war keine Waise. Sie ging freiwillig.
- **Corvin schließt sich an** (`corvin_beigetreten`). Er sagt es nicht so: „Ich brauch einen, der reinkommt, wo ich nicht reinkomme. Und du kannst mich nicht bezahlen. Also bezahlst du mich später.“
- **Erster Knoten-Moment:** Wer die Szene ohne Verluste und gemeinsam schafft, bekommt bei Corvin oder Big Dig die erste Meldung „Knoten geknüpft“. Der Spieler soll sie früh sehen, ohne sie schon zu verstehen.

### 8 · Lagerszene Corvin (Pflicht)
*erste lange Rast danach · Corvins Büro über dem Pfandhaus wird als Unterschlupf frei*

- Im Büro hängt die Pinnwand mit Fäden und Fotos: verschwundene Pilger, Kinder, Mantelmänner. Mimis Zeichnung passt hinein. Corvin: „Mantel, Auto, Knäuel. Das sieht aus wie meine Akte.“
- Dann holt er das **Notizbuch** heraus und zeigt Rooks Foto. Er erzählt den Fall Rook noch als Justizirrtum, nicht als eigene Schuld.
- **Zustand:** `corvin_lagerszene = 1`.

### 9 · Die Dächer
*zweite Ebene über Hairlem · Corvin · neu*

- Corvin öffnet die Dachebene mit Feuertreppen, Wäscheleinen, Wassertürmen und Reklametafeln. Er fliegt voraus, findet Wege und lässt Leitern herunter.
- **Erkundung lernen:** Fähigkeiten der Gefährten öffnen eigene Wege, wie die Pfadaktionen in Octopath. Big Dig gräbt unten, Corvin klärt oben auf.
- Überall sind Tauben, und alle scheuchen sie weg. Corvin „verachtet“ sie laut und legt heimlich Krümel hin.
- **Vorschlag:** Hier oben fotografiert Vincenzo Frankinetti die Stadt. Er ist ein Flughörnchen mit Kamera, aus dem Prototyp, und Fitz' Onkel. Damit ist Boney Island vorbereitet.

### 10 · Die Tauben (Nebenquest, Fenster Akt 1–2)
*Taubenschläge auf den Dächern · der Taubenzüchter · neu, aus dem GDD*

- Corvin entdeckt den Züchter. Sein Name verrät ihn: Er ist Rooks Bruder. Corvin wird still.
- Das Taubennetz weiß, wohin Juno gebracht wurde. **Entscheidung** (GDD):
  - **Netz nutzen** (`tauben = netz_genutzt`): Die Tauben berichten, dass Juno mit einer Expedition des Ordens in die stillgelegten Tunnel gegangen ist. Das ist die stärkste Spur in die Subfurs.
  - **Tauben befreien** (`tauben = befreit`): Die Spur ist verloren, aber die Tauben werden Verbündete in der ganzen Stadt.
- **Unschöne Seite, angelegt:** Corvin schlägt vor, eine Taube unter Druck zu setzen, damit sie gegen den Züchter aussagt. Es ist dieselbe Methode wie im Fall Rook.
- Wer die Dächer auslässt, bekommt in Akt 2 die Botentaube.

---

## Teil C: Der Bandenkrieg

### 11 · Nuggets Auftrag
*Cuckoo's Nest · Nugget · Prototyp*

- Nugget, die rechte Hand von Don Orango, zahlt 80 Collar für den goldenen Ghettoblaster, den die Breaking Cats auf ihrem Platz spielen.
- Nugget lügt über den Besitzer (Prototyp: `nuggetLie`). Proben können die Wahrheit herausholen.

### 12 · Das Künstlerviertel
*Basketballplätze, Galerien, Plattenläden · Adikatz, Pounce, Shiner · Prototyp, von der Branx hierher verlegt*

- Die Breaking Cats tanzen um den Ghettoblaster. Er gehörte Lil' Riff, Adikatz' kleinem Bruder. Riff kam vor zwei Monaten nicht nach Hause, die Polizei sagt: Bandenkrieg.
- **Shiner** malt kopfüber an einer Hauswand. Sie fordert Corvin zum Wettklettern heraus, er fliegt und verliert trotzdem. Erste Begegnung, noch keine Gefährtin.
- **Wege zum Ghettoblaster:** stehlen, abkaufen, beim Battle gewinnen oder ihn freiwillig zurückgeben, wenn man die Wahrheit kennt.
- **Ansehen:** Breaking Cats und Nomapes ändern sich hier zum ersten Mal deutlich.

### 13 · Industrie und Hafen
*Werkstätten, Lagerhallen, Docks · Don Orango, Nugget, Knuckles, Benny · Prototyp, verlegt*

- Die Nomapes in Don Orangos Werkstatt. **Knuckles** liegt unter einem Motorrad und spricht zärtlich mit ihm. Erste Begegnung.
- Benny Hopkins, Hazels jüngster Bruder, schraubt hier. Über ihn kommt das Angebot eines Kredits aus Hazels Wohnungsprogramm, wenn die Nomapes Frieden schließen. *Anpassung:* Hazel selbst trifft der Held in Akt 1 nicht, so steht es im GDD. Das Angebot kommt über Benny und einen Beamten.
- Ein Nomape erzählt nebenbei: Malcolm Snax war letzte Woche da, mit teuren Schuhen und einem Umschlag für den Don.

### 14 · Die Massenschlägerei: der erste Immunitätsmoment
*Basketballplatz zwischen den Vierteln · beide Gangs, Big Dig, Corvin · neu, Kern des Akts*

- Der Streit um den Ghettoblaster eskaliert. Beide Gangs treffen sich auf dem Platz, erst Sprüche, dann Fäuste.
- **Dann kippt die Stimmung, ohne Anlass.** Die ganze Straße rastet aus, Zuschauer werfen Flaschen, sogar Big Dig verliert kurz die Beherrschung und Corvin hackt nach einem Nomapen. Pfötchen hat über Nugget gezogen, der Spieler weiß das noch nicht.
- **Nur der Held bleibt ruhig.** Die Mechanik dazu:
  - Der Kampf läuft wie immer, aber die Gegner sind enthemmt.
  - Der Held kann einzelne Figuren mit Worten und Ruhe aus dem Rausch holen, über Proben.
  - Er sieht die Spuren: einen **Sprung ohne Anlass** bei Dutzenden gleichzeitig.
- Danach sehen ihn alle an. Ein Kind sagt es zuerst: „Der hat keine Fäden.“ Von da an heißt er **„Fadenlos“**.
- **Zustand:** `fadenlos` (neue Variable).

### 15 · Malcolm
*Nach der Schlägerei, zwischen Verletzten · Malcolm Snax · neu*

- Ein Luchs im teuren Mantel verbindet Verletzte beider Seiten. Er weiß, was jeder braucht, bevor der es sagt. Die Leute lieben ihn.
- Er spricht den Helden an, charmant und hilfsbereit, und bietet Hilfe bei der Suche nach Juno an: „Ich kenne Leute im Orden. Ich war mal einer.“
- **Der kleine Bruch:** Einen Moment lang sieht Malcolm ihn an, als würde er auf etwas lauschen. Dann: „Bei dir ist es still. Weißt du, wie selten das ist?“ Er erkennt ihn und sagt nichts.
- **Corvin** traut ihm sofort, weil Malcolm sein bester Informant ist. Das ist sein blinder Fleck. **Big Dig** brummt nur.

### 16 · Die Kassette
*Unterschlupf, in der Nacht danach · Gruppe · Prototyp, neu gestellt*

- Big Dig oder Corvin untersuchen den Ghettoblaster. Im Fach steckt ein Band: „Lil' Riff, Take drei …“, ein selbstgebastelter Beat mit Tunnelhall.
- **Zwei Stimmen auf dem Band.** Die kühle ist Malcolm, die raue gehört jetzt der Weberin (GDD). Der Text ist aus dem Prototyp übernommen:
  - „Die Tagebücher sagen, es liegt noch da unten.“
  - „Warum trägt er dann Tag und Nacht einen Schlüssel um den Hals?“
  - „Er hat dich aufgezogen wie sein eigenes Blut.“ – „Wie sein eigenes Blut. Ja. So kann man's sagen.“
  - „Die Affen erledigen meine Drecksarbeit, die Katzen glauben an mich.“
- **Dramatische Ironie:** Die Gruppe hat diese kühle Stimme vor ein paar Stunden gehört. Corvin will es nicht glauben.
- **Entscheidung:** Die Kassette Nugget geben, Adikatz geben oder behalten. Gibt man sie Adikatz, zweifelt er an Malcolm (Prototyp: `adDoubtsSnax`). Behält man sie, bleibt sie ein Beweis für später.
- **Zustand:** `hasTape` (Prototyp), dazu `malcolm_risse` +1, wenn Corvin danach misstrauisch wird.

### 17 · Der Auftrag
*Werkstatt der Nomapes oder Hauptquartier der Breaking Cats · Don Orango oder Adikatz · Prototyp*

- Beide Bosse verlangen dasselbe: Der andere muss weg, „nicht verprügelt, WEG“. Ihr seid neu, keiner kennt euch.
- Der Held kann annehmen, verhandeln oder ablehnen. Wer annimmt, muss es nicht tun, aber jede Zusage hat Folgen fürs Ansehen.
- **Der Knoten des Akts:** Spuren zeigen, dass der Hass zwischen den Bossen gerade jetzt aufgeblasen wird, über Nugget bei den Nomapes und über Adikatz' Trauer bei den Cats. Der Held kann es erkennen, beweisen kann er es noch nicht.

### 18 · Die Gang-Wahl
*je nach Weg · Shiner oder Knuckles · GDD*

- Der Held schlägt sich auf eine Seite: Breaking Cats oder Nomapes. Die Folgen reichen bis ins Finale, wie in Fallout: New Vegas (`gang_wahl`).
- **Shiner** schließt sich bei den Cats an, **Knuckles** bei den Nomapes (`<gefährte>_beigetreten`). Der Grund ist profan: Shiner will Ruhm und Riffs Mörder, Knuckles will den Krieg beenden, bevor er die Werkstatt ruiniert.
- **Die Allianz öffnet den Weg nach unten:** Die Cats kennen die Graffiti-Tunnel, die Nomapes ihre Schmuggelstrecken in die stillgelegte U-Bahn.
- Ab hier ist die Gruppe zum ersten Mal komplett: Held und drei Gefährten.

### 19 · Lagerszene Shiner oder Knuckles (Pflicht)
*nächste lange Rast*

- **Shiner** zeigt ihr Skizzenbuch mit dem größten Bild der Stadt und fragt den Helden, ob es gut ist: „Du bist der Einzige, den ich nicht beeindrucken kann.“
- **Knuckles** repariert schweigend Big Digs Schaufel und weint ein bisschen bei der Telenovela im Radio. Niemand sagt etwas.

### 20 · Die Enthüllung: Wer regiert
*Corvins Büro, dann die Straße · ganze Gruppe · neu*

- An Corvins Pinnwand kommt alles zusammen:
  - die Pilgerliste, das weiße Wachssiegel, Mimis Zeichnung, die Kassette
  - das Taubennetz, falls genutzt
  - der Beamte, der Benny den Kredit anbot, und der vorher im Tempel war
- **Der Beweis vor aller Augen:** Am Abend läuft Pfötchens Predigt im Fernsehen. Er ruft zur Ruhe nach den Unruhen, und innerhalb einer Minute wird die ganze Straße friedlich. Nicht langsam, sondern alle auf einmal. Der Held sieht es als Einziger als das, was es ist: ein **Sprung ohne Anlass**, bei Hunderten.
- Corvin flüstert: „Das Rathaus regiert nicht. Die regieren.“ Das ist die **Enthüllung des Akts** (GDD).
- Aus der Kassette und der Pilgerliste folgt: Juno ist mit dem Orden nach unten gegangen, in die Tunnel.

### 21 · Point of no Return
*stillgelegter U-Bahn-Eingang Whisker Avenue · Gruppe*

- Die Brücken nach Cathattan bewacht der Orden mit Monsterhunden. Der einzige Weg führt nach unten.
- **Warnung vor dem Übergang**, als Kommentar der Gefährten (Zustandsplan):
  - Corvin: „Auf den Dächern ist noch was offen.“ Das gilt, wenn die Tauben-Quest offen ist. Sie verfällt nicht, das Fenster reicht bis Akt 2.
  - Big Dig: „Wenn wir runtergehen, sind wir eine Weile weg.“
  - Hummel gibt beim Abschied einen letzten Honig mit, wenn ihre Nebenquest erledigt ist.
- Abstieg in die Subfurs. **`akt_wechseln(2)`**.

---

## Nebeninhalte in Akt 1

| Inhalt | Wo | Herkunft | Bindet an |
| --- | --- | --- | --- |
| Honig für Hummel | Cuckoo's Nest, Annegret | Prototyp | Hummels Vertrauen, Zimmerpreis |
| Grille Grimm | Whisker Avenue | Prototyp | „Achtet auf die Pfote“ |
| Vincenzo Frankinetti | Dächer | Prototyp, verlegt | Boney Island (Fitz' Onkel) |
| Gefangen bei einer Gang | Werkstatt oder Hauptquartier | Prototyp (`prisoner`) | anderer Einstieg in den Auftrag |
| Pips | Mulberry Street | Prototyp | Mimi, Big Dig |
| Hazels Wahlkampfauftritt | Platz vor dem Rathaus von Hairlem, aus der Ferne | neu | Benny, Big Dig arbeitet für ihr Programm |

---

## Was gelernt wird, in dieser Reihenfolge

| Szene | Neu für den Spieler |
| --- | --- |
| P1 | Charaktererstellung, Dialogwahl |
| P2 | Wahrnehmungsprobe |
| P3 | Kampf allein |
| 1–2 | Erkundung, Würfelproben, Unterschlupf, lange Rast |
| 3 | Spurenlesen (Beobachtung statt Bauchgefühl) |
| 4 | mehrere Wege pro Aufgabe, Kampf zu zweit, Gefährte rekrutieren |
| 5 | Lagerszene |
| 7 | Probe zu dritt, Gefährten würfeln für den Helden, erste Meldung „Knoten geknüpft“ |
| 9 | Erkundungsfähigkeiten, Dachebene |
| 11–13 | Ansehen bei Gangs |
| 14 | Manipulation sehen: Sprung ohne Anlass, der Held ist immun |
| 16 | Beweise sammeln und weitergeben |
| 18 | große Entscheidung mit Langzeitfolgen |
| 21 | Point of no Return |

---

## Was sich gegenüber dem Prototyp ändert

- **Der Held kommt allein.** Big Dig kommt in Szene 4 dazu, Corvin in Szene 7.
- **Die Branx gibt es nicht mehr.** Die Breaking Cats sitzen im Künstlerviertel, die Nomapes in Industrie und Hafen.
- **Die raue Stimme auf der Kassette** gehört der Weberin.
- **Der Auftrag „Lageplan“** verweist im Prototyp auf Vincenzo in Cathattan. Vincenzo sitzt jetzt auf den Dächern von Hairlem.
- **Corvins „Akte“** aus dem Prototyp ist seine Pinnwand mit den verschwundenen Pilgern und Kindern. Seine Schuld ist der Fall Rook.

---

## Neue Variablen für das Zustandsregister

Erst eintragen, wenn die Szenen gebaut werden:

| Variable | Werte | Gesetzt in | Gelesen von |
| --- | --- | --- | --- |
| `juno_spur` | 0–4 | Szenen 3, 4, 10, 20 | Junos Begegnung in Akt 2 |
| `fadenlos` | ja, nein | Szene 14 | Anrede der NPCs, Malcolm |
| `kassette` | keine, behalten, nugget, adikatz | Szene 16 | Szenen 17, 20, Malcolm in Akt 2 und 3 |
| `auftrag` | abgelehnt, angenommen, verhandelt | Szene 17 | Gang-Wahl, Ansehen |

Die Prototyp-Flags (`mimiFound`, `hasTape`, `pilgerGeld` …) bleiben, bis die Dialoge umgebaut sind.

---

## Zwei Entscheidungen für dich

1. **Mimi statt Pip.** Im Prototyp sucht Big Dig schon ein Kind: Mimi, ein Mäusemädchen. Ihre Zeichnung zeigt sogar das Knäuel. „Pips“ ist dort ein anderes Kind, das Big Dig hilft. Ich habe Akt 1 mit Mimi geschrieben, weil die Szenen schon existieren und weil „Pip“ und „Pips“ zu ähnlich sind. Wenn du zustimmst, benenne ich Pip in allen Story-Dokumenten in Mimi um. Big Digs Requisite ist dann Mimis Zeichnung.
2. **Zwei Flughörnchen.** Vincenzo aus dem Prototyp und Fitz sind beide Flughörnchen. Mein Vorschlag: Vincenzo ist Fitz' Onkel, der den Zirkus verlassen hat, um Fotograf zu werden. Damit gibt es in Akt 1 schon einen Faden nach Boney Island.
