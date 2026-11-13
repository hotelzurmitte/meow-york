# Akt 1: Hairlem – „Die Stadt, die fühlt“

Stand: 13.11.2026, Fassung 3 (nach Prüfung auf Logik, Dramaturgie und Spielbarkeit) · Akt 1 als zusammenhängende Geschichte mit offenen Quests nach dem Vorbild von BG3. Baut auf GDD, Regelwerk, `docs/story/` und dem Prototyp (`data/dialogues/kapitel1_*.dialogue`) auf. Entschiedenes ist markiert, der Rest ist Vorschlag.

---

## Das Rückgrat in einem Absatz

Der Held kommt nach Hairlem, um Juno zu finden, und wird am ersten Abend ausgeraubt. Er findet ihre Wohnung leer und folgt ihrer Spur zu einer freundlichen Ordensschwester und in die Ordensmission. Dort erfährt er, dass Juno nicht entführt wurde, sondern vor ihm flieht. Nebenbei stößt er auf eine stille Maschine: Männer in guten Mänteln holen Straßenkinder und Knäuel-Gläubige ab, legal und freundlich. Gleichzeitig kocht Hairlem. Zwei Gangs streiten um einen goldenen Ghettoblaster, und der Streit wird immer heißer, als würde jemand nachlegen. Bei einer Massenschlägerei rastet die ganze Straße aus, nur der Held nicht. Danach verbindet ein charmanter Luchs, der gegen den Orden kämpft, die Verletzten beider Seiten und hilft dem Helden, ohne etwas zu verlangen. Wer will, hört auf einem versteckten Band genau diese Stimme, wie sie mit einer Fremden über Geld für beide Gangs spricht und über etwas, das „da unten“ liegt. Ein Zweifel, kein Urteil. Am Ende sieht der Held eine Predigt im Fernsehen, die eine ganze Straße auf einen Schlag beruhigt, und begreift: Nicht das Rathaus regiert. Juno ist nach unten gegangen, in die Tunnel. Er folgt ihr.

---

## Die Rätsel des Akts und ihre Auflösung

Spannung entsteht, wenn der Spieler Fragen hat, die das Spiel nach und nach beantwortet. Jede Antwort ist ein Ereignis, kein Vortrag.

| Rätsel | Taucht auf in | Wird beantwortet in | Antwort |
| --- | --- | --- | --- |
| Wo ist Juno? | Prolog | Quest 1, Ordensmission | Sie ist freiwillig beim Orden und flieht vor ihm, weil es ihr wehtut, ihn zu sehen |
| Wer holt die Kinder und die Gläubigen? | Ilse, Prolog | Quests 2, 3 und 1 | Die Mantelmänner des Ordens, ganz legal: Waisenhaus und Aufnahme |
| Was stimmt mit dem Helden nicht? | erste Nacht | Massenschlägerei | Er fühlt nicht mit und kann nicht gelenkt werden: „Fadenlos“ |
| Warum kocht Hairlem? | Quest 4 | Massenschlägerei, Kassette | Jemand schürt. Geld fließt in beide Gangs, auch Malcolms. Ob er schürt oder schlichtet, bleibt in Akt 1 offen |
| Wer hat die Papiere gekauft? | Roachs Garage | Malcolm-Szene (für Aufmerksame) | „Der mit den teuren Schuhen“: Malcolm *(entschieden)*. Seine Leute erklären es als Schutz vor den Listen der Garde, die wahre Absicht (er sucht den Sohn) bleibt bis Akt 2 verborgen |
| Was ist mit Lil' Riff passiert? | Quest 4 | offen bis Akt 2 | Er hat etwas aufgenommen und ist verschwunden. Die Spur führt zur Ordensgarde und nach unten |
| Wer regiert die Stadt? | überall angedeutet | Ende des Akts | Der Orden |

---

## Wie der Akt aufgebaut ist

| Abschnitt | Ablauf | Dauer |
| --- | --- | --- |
| **Prolog und erster Tag** | fest: Taxi, Gasse, Whisker Avenue, Cuckoo's Nest, erste Nacht | etwa 1 Stunde |
| **Offenes Hairlem** | vier Quests in beliebiger Reihenfolge, die sich kreuzen | 5 bis 7 Stunden |
| **Die Schlägerei** | Ereignis, ausgelöst durch den Bandenkrieg | etwa 1 Stunde |
| **Die Nacht danach** | Malcolm, die Kassette | etwa 1 Stunde |
| **Der Auftrag** | Gang-Wahl, Shiner oder Knuckles | 1 bis 2 Stunden |
| **Das Ende des Akts** | Enthüllung, Abstieg in die Tunnel | etwa 30 Minuten |

**Die vier Quests im offenen Hairlem:**

| Quest | Treibt an | Gefährte | Kreuzt sich mit |
| --- | --- | --- | --- |
| 1 · Junos Spur | Hauptquest | – | Quest 3 (Ansgar führt zur Mission), Quest 2 (Roachs Liste) |
| 2 · Roachs Garage | Ausrüstung und Papiere | Big Dig | Quest 1 (Junos Name), Quest 3 (Pips auf der Liste) |
| 3 · Der Mantelmann | Corvins Fall | Corvin | Quest 1 (Mission), Quest 2 (Pips) |
| 4 · Der goldene Ghettoblaster | Geld und Bandenkrieg | Shiner oder Knuckles später | Quest 1 (Riff im Aufnahmebuch), Malcolm |

**Sicherungen:** Big Dig und Corvin kann man nicht ganz verpassen. Wer ihre Quests auslässt, trifft beide spätestens bei der Schlägerei, dann mit weniger gemeinsamer Vorgeschichte. Die Schlägerei beginnt, sobald Quest 4 entschieden ist. Wer Quest 4 liegen lässt, erlebt sie spätestens nach Junos Nachricht in der Mission (Quest 1), weil die Gangs dann ohne ihn losschlagen.

---

## Prolog und erster Tag (fest)

### P1 · Im Taxi
*Papa Roachs Rückbank · entschieden*

- Nur Text, kein Bild vom Helden: Junos letzter Brief. Darin steht der Satz: „Ich glaube, ich habe endlich eine Familie gefunden, die mich gesucht hat.“
- Roach: „Und wer bist du eigentlich, Bruder?“ Darauf folgt die **Charaktererstellung**. Danach kommentiert Roach die Tierart, mit einem eigenen Satz je Art.
- Roach: „Und was willst du hier?“ Jede Antwort führt zum Absender auf dem Brief, Mulberry Street. Roach dazu: „Da zieht keiner freiwillig hin. Außer die Frommen.“
- **Vorkasse:** Roach sieht im Rückspiegel jeden Schein. Mit einer Probe auf Wahrnehmung bemerkt der Held den Blick und hört den Funkspruch „Paket mit Fell, Ecke Whisker“. Dann kann er Geld im Schuh verstecken (`hidMoney`).
- Im Radio predigt Pfötchen, auf den Plakaten wirbt Hazel Hopkins. An der Brücke stehen Kontrollposten der Ordensgarde, am Pfeiler das Graffiti „BEWARE OF THE BEASTS!“.

### P2 · Die Gasse
*entschieden*

- Überfall, erster Kampf allein, kaum zu gewinnen. Weg sind Geld, Papiere und der Rucksack mit Waffe und Ausrüstung.
- **Ilse** hilft ihm auf. Von ihr erfährt er:
  - Roach fährt Neuankömmlinge durch diese Gasse, und das Zeug liegt jetzt in seiner Garage.
  - Nach dem Knäuel fragt man besser nicht, das ist was für Spinner. „Manchmal ist so einer dann weg. Vermisst keiner.“
  - „Die Weißen holen die Straßenkinder ab, für ihr Waisenhaus. Ist ja nett. Sagen alle.“

### 1 · Whisker Avenue
- Freie Erkundung, erste Würfelproben.
- Im Schaufenster eines Fernsehladens segnet Pfötchen Hazel Hopkins. Die Passanten bleiben gleichzeitig stehen, der Held merkt nur, dass sie stehen.
- **Ein Steckbrief der Polizei:** „Gesucht: Malcolm Snax, wegen Aufwiegelung.“ Jemand hat ein Herz daneben gesprüht, ein anderer „Held“ darüber geschrieben. Hairlem liebt einen Mann, den es nie zu sehen bekommt.
- **Grille Grimm** ist ein früherer Knäuel-Gläubiger, der „geheilt“ aus dem Ordenslager zurückkam. Er lächelt immerzu und kann nicht mehr sagen, was ihm früher wichtig war. „Achtet auf die Pfote, Kinder.“ Hier zeigt sich zum ersten Mal, was der Orden mit Menschen macht. Erklärt wird es nicht.

### 2 · Das Cuckoo's Nest
- Hummel bietet ein Bett auf Pump an, wenn der Held am Donnerstag eine Schicht übernimmt. Er kann ablehnen und sich das Bett anders verdienen, etwa mit „Honig für Hummel“ (`schicht`).
- **Resonanz-Szene:** Ein Song aus der Jukebox, und alle wiegen sich im selben Takt. Nur der Held steht still.
- **Ein Detail für Aufmerksame:** Am Schlüsselbrett fehlt immer Haken 7. Hummel sagt dazu: „Dauermieter. Zahlt bar, donnerstags. Schläft nie hier.“

### 3 · Die erste Nacht
*entschieden*

- Erinnerung in drei Teilen: das Dorffest, das Ratespiel, der Abschied. Danach weiß der Spieler, dass der Held liebt, aber nicht mitfühlt, sondern liest, und dass Juno ihm übersetzt hat. Sie nannte ihn „Schraubenschlüssel“, weil er so geguckt hat.
- Am Morgen spricht Hummel ihn an, wenn er die Schicht zugesagt hat.

---

## Offenes Hairlem

### Quest 1 · Junos Spur (Hauptquest)

**Worum es geht:** Der Held folgt Juno von ihrer leeren Wohnung über die Frau, die sie zum Orden gebracht hat, bis in die Mission. Am Ende steht keine Befreiung, sondern ein Zettel: Juno will nicht gefunden werden.

#### 1.1 · Die Wohnung in der Mulberry Street

**Einstieg:** fest nach dem ersten Tag, Junos Absender.

**Ein Ereignis statt eines leeren Raums.** Wann der Held kommt, macht einen Unterschied:

| Wann | Was er vorfindet |
| --- | --- |
| **Vormittags** | Zwei Helfer des Ordens tragen Junos Möbel hinaus, „für die Kleiderkammer, sie braucht das ja nicht mehr“. Dabei ist **Schwester Odile**. |
| **Später am Tag** | Die Wohnung ist halb leer, die Tür nur angelehnt. Einen Karton haben sie vergessen. |
| **Nachts** | Alles ist abgeschlossen. Hinein kommt man über die Feuertreppe, mit einem Dietrich oder mit Corvin. |

**Wenn Odile da ist, gibt es mehrere Wege:**
- **Sich als Bruder zu erkennen geben.** Odile freut sich ehrlich: „Sie hat von dir erzählt! Der Stille.“ Sie lädt ihn zur Abendandacht in die Mission ein.
- **Verstecken und zuhören.** Die Helfer reden über „die Expedition am Freitag“. Juno soll dort sprechen.
- **Sich als Helfer ausgeben** (Täuschen). Er darf mittragen und Sachen beiseiteschaffen.
- **Dazwischengehen** (Einschüchtern). Die Helfer gehen, Odile ist verletzt. Der Weg über sie zur Mission ist zu, und `orden_wachsam` steigt um 1.

**Was der Held findet (Spurenlesen, Tutorial):**
- Ein Familienfoto, umgedreht auf dem Nachttisch: die **Leere an anderer Stelle**.
- Ordensblätter mit Junos Randnotizen: „Endlich jemand, der mich meint.“
- Ein unfertiger Brief an ihn, der mitten im Satz abbricht.
- **Neu:** ein Armband der Ordensmission, „Helferin“. Das ist der Schlüssel zum nächsten Ort.

**Mimi** spielt im Hof und erzählt nebenbei, dass ihr Freund Pips auch weg ist. Wer schon in Roachs Garage war, horcht auf.

**Was gezeigt statt erklärt wird:** Juno wurde nicht entführt. Alles sieht nach jemandem aus, der glücklich gegangen ist, und das ist schlimmer.

#### 1.2 · Schwester Odile

**Einstiege:** in der Wohnung (vormittags), über die Nachbarin („die nette Gans aus der Mission“), über Corvin, der sie in seinen Akten hat, oder in der Mission selbst.

**Wer sie ist:** Eine Gans, warmherzig und ehrlich. Sie glaubt, was sie sagt. Juno war einsam, und Odile hat ihr eine Familie gegeben. In ihrer Version der Geschichte ist sie die Retterin, und das ist nicht gelogen.

**Die Schlüsselszene, gezeigt statt erklärt:** Mitten im Gespräch geht ein fremder Junge vorbei. Odile hält inne, ihre Augen werden feucht, sie sieht ihm nach, als würde sie ihn lieben. Dann fängt sie sich: „Verzeihung. Das passiert mir in letzter Zeit. Ich weiß nicht, was mit mir ist.“
- Der Held sieht es als Beobachtung: ein **Sprung ohne Anlass**.
- Ist Corvin dabei, notiert er es: „Hab ich bei drei anderen auch. Alle aus der Mission.“
- Erklärt wird es hier nicht. Bei der Schlägerei sieht der Spieler dasselbe bei Hunderten und versteht. (Nach dem Regelwerk ist das Nachhall bei einer Zwischenperson: Odile ist ein Glied in Pfötchens Kette.)

**Wege, wie Odile hilft:**
- **Ehrlich als Bruder:** Sie lädt ihn zur Abendandacht in die Mission ein.
- **Als Bekehrungswilliger** (Täuschen): Sie nimmt ihn zur Aufnahme mit. Sie stutzt, weil bei ihm „nichts ankommt“, und hält ihn für besonders verschlossen.
- **Ihr Missionsschlüssel** (Fingerfertigkeit): Damit kommt er nachts hinein.
- **Ihr folgen**, mit Corvin über die Dächer: Er sieht den Hintereingang der Mission.

**Umgesetzt als Testszene** `data/dialogues/akt1_odile.dialogue` (Einstiege `odile_wohnung`, `odile_mission`, `wohnung_lauschen`):
- Ein misslungenes Täuschen ist keine Sackgasse. Odile erkennt die Falte zwischen den Augen („wie Juno, wenn sie flunkert“), und das Gespräch läuft über den Bruder-Weg weiter.
- Ehrlichkeit wird belohnt: Als Bruder bekommt er Junos Sachen zurück (`juno_sachen_gerettet`). Als Helfer muss er einen Karton heimlich beiseiteschieben, mit Einschüchtern bleiben die Sachen zwar da, aber Odile ist verletzt.
- Ein misslungener Taschendiebstahl kostet nichts außer dem Schlüssel. Odile hält ihn für bedürftig und schenkt ihm eine Suppenmarke (`suppenmarke`). Komik statt Strafe, und die Szene bleibt warm.
- Die Expedition am Freitag zählt nur einmal für `juno_spur`, egal ob gelauscht, mitgetragen oder gefragt.
- Den Sprung ohne Anlass sieht jeder, der mit ihr redet, genau einmal (`odile_moment_gesehen`). Der Weg über die Dächer gehört in die Spielwelt, nicht in den Dialog.

**In Hairlem eingebaut** (`scripts/story/akt1_juno.gd`, Daten in `data/levels/hairlem/story_akt1.json`). Die Figuren werden zur Laufzeit eingesetzt, `hairlem.tscn` bleibt unverändert:
- Junos Haus ist das Wohnhaus mit Treppe neben dem Cuckoo's Nest.
- **Morgens:** Odile, Bruder Hopp (Hase) und eine Helferin (Maus) räumen aus, dazu der Punkt „Im Hausflur lauschen“. **Tag und Abend:** Odile verteilt Suppe vor dem Haus (`odile_mission`). **Nachts:** niemand.
- Die Helfer und der Lauschpunkt verschwinden, sobald das Gespräch mit Odile gelaufen ist.
- Odile ist vorerst eine Möwe, weil der NPC-Atlas keine Gans hat. Position ändern: unter „Handgebaut“ einen Marker3D „Story_odile“ (bzw. `Story_helfer_hopp`, `Story_helfer_maus`, `Story_lauschen`) setzen.
- Testen: `godot --path . scenes/world/hairlem.tscn -- --flag=ch1robbed,ch1street --zeit=morning --pos=24,1 --sprich=Story_odile`

**Prüfung:**
- *Spaß:* eine warme Figur, die man mögen will und der man misstrauen muss. Der seltsame Moment bleibt hängen.
- *Nachvollziehbarkeit:* Sie ist der natürliche nächste Schritt nach der Wohnung.
- *Lösungswege:* vier.

#### 1.3 · Die Ordensmission

**Was sie ist:** eine Suppenküche mit Aufnahmestelle und kleiner Kapelle im Zentrum von Hairlem. Tagsüber steht jeder in der Schlange, hinten ist abgeschlossen.

**Wege hinein:**

| Weg | Voraussetzung |
| --- | --- |
| Zur Abendandacht eingeladen | Odile ehrlich gewonnen |
| Zur Aufnahme mitgenommen | Odile getäuscht, oder Ansgar hat ihn angeworben (Quest 3) |
| Als Helfer in der Küche | Junos Armband, dazu Täuschen |
| Nachts von oben | Corvin öffnet ein Oberlicht |
| Nachts von unten | Big Dig gräbt sich in den Vorratskeller |
| In der Suppenschlange | jeder, aber dann muss er hinten einbrechen (Schleichen oder Schloss) |

**Was er drinnen findet:**
- **Das Aufnahmebuch:**
  - *Juno:* „Helferin, Rednerinnen-Ausbildung, Expedition Untergrund.“
  - *Pips:* „Weitergeleitet: Waisenhaus Cathattan.“
  - *Lil' Riff:* „Kam von selbst, verstört, wollte ‚den Meister warnen‘. Erzählt wirre Dinge über das Knäuel. Zu seinem Schutz an die Garde übergeben, Cpt. V.“ Riff hat also nach dem Lauschen genau das Richtige getan, er ist zum Orden gelaufen. Und der Orden hat ihn verschwinden lassen, weil niemand über das Knäuel reden darf. Das ist der erste Hinweis auf Vale.
- **In der Kapelle:** Junos Stimme vom Band. Sie hat Andachten für die Mission aufgenommen. Sie klingt glücklich und stark: „Wir haben uns nicht gefunden. Wir wurden gefunden.“ Der Held hört ihre Stimme zum ersten Mal seit Monaten, und sie spricht zu Fremden.

**Junos Nachricht (der Wendepunkt der Quest):** Juno hat erfahren, dass ihr Bruder nach ihr fragt: von Odile, von Ansgar oder über das Gerede in der Mulberry Street, je nachdem, mit wem der Held gesprochen hat. Sie war heute in der Mission, um Andachten aufzunehmen. Als der Held vorne hereinkommt, geht sie hinten hinaus, zur Expedition, einen Tag früher als geplant. Für ihn liegt ein Zettel bereit, die Tinte ist noch feucht:
> „Such mich nicht. Mir geht es gut. Ich bin zu Hause.“

Darunter steht ein angefangenes „Schraubensch…“, durchgestrichen, und daneben eine kleine Kritzelei aus ihrer Kindheit.

- **Was gezeigt statt erklärt wird:** Sie flieht vor ihm, weil es wehtut, ihn zu sehen. Das durchgestrichene Wort zeigt: Etwas in ihr hält noch an ihm fest. Nach dem Regelwerk ist es der Knoten aus der Kindheit, den niemand verschieben kann. Das erfährt der Spieler erst später.
- **Wer sofort losrennt** (zum Hinterhof, über die Dächer mit Corvin oder durch die Küche), sieht am Ende der Straße das Gittertor der stillgelegten U-Bahn, eine Gruppe in Weiß und eine Waschbärin, die sich einmal umdreht. Das Tor schließt sich, Wachen der Garde stehen davor. Ein Gespräch gibt es nicht, die erste Begegnung bleibt in Akt 2 (GDD).
- **Warum der Orden nach unten geht,** gezeigt durch das Aufnahmebuch und Odiles Begeisterung: Die Ausgestoßenen in den Subfurs kennen den Orden nicht. Die Expedition bringt ihnen Suppe und Predigten. Nach dem Regelwerk entstehen dadurch Schlingen, an denen Pfötchen später ziehen kann. Für den Spieler bleibt es zunächst Barmherzigkeit mit unheimlichem Beigeschmack.

**Big Dig im Aufnahmebuch** (wenn dabei): Er liest „Pips: weitergeleitet, Waisenhaus Cathattan“. Er sagt nichts, faltet die Zeichnung auf und wieder zu. Später, auf dem Heimweg, redet er zum ersten Mal von sich aus: „Cathattan. Da komm ich nicht hin. Da kommt keiner von uns hin.“

**Zustand:** `juno_spur` steigt. Ab jetzt ist das Ziel klar: die Tunnel. Das Tor ist bewacht, ein anderer Weg muss her.

**Prüfung:**
- *Spaß:* Einbruch oder Einladung, der Fund des Buchs, die Stimme, der Zettel. Ein emotionaler Höhepunkt mitten im Akt.
- *Nachvollziehbarkeit:* Jeder Schritt folgt aus dem letzten.
- *Lösungswege:* sechs Wege hinein.

---

### Quest 2 · Roachs Garage (Big Dig)

**Worum es geht:** Ausrüstung, Geld und Papiere zurückholen. Der Held findet die Ausrüstung, einen Verbündeten und eine Liste, die alles verbindet, aber keine Papiere.

**Einstiege:** Ilses Hinweis, Roach am Bahnhof, Antonia vor der Garage oder Big Dig, der an Pips' Karton gräbt.

**Wege hinein:**

| Weg | Wie | Folge |
| --- | --- | --- |
| **Antonia überreden** | Sie ist unterbezahlt und hasst Roach. Überzeugen oder Bestechen | Antonia wird später Informantin |
| **Schleichen** | nachts durchs Fenster | keine Zeugen |
| **Kanalisation** | über den Abwasserkanal in den Keller | Der Held trifft Big Dig beim Graben |
| **Frontal** | Kampf gegen Roachs Leute, schwer | Big Dig bricht mitten im Kampf aus dem Boden |
| **Roach selbst** | ihn am Bahnhof abpassen und mit Ilses Aussage erpressen oder einschüchtern | Roach öffnet den Schrank selbst. Big Dig trifft man dann an Pips' Karton |

**Im Geldschrank liegen:**
- Rucksack, Ausrüstung und Geld des Helden
- das Geld anderer Neuankömmlinge
- Roachs Namensliste mit „Mantel – Do.“, darauf **Juno** („fragt nach dem Orden, allein“) und **Pips** („Waise, Karton hinter der Garage“)
- **nicht die Papiere.** In Roachs Buchführung steht: „Papiere: verkauft, bar, an den mit den teuren Schuhen.“ Weiter oben stehen ältere Einträge derselben Art: Der Käufer nimmt seit Monaten die Papiere aller Neuankömmlinge, die allein kommen und um die 25 sind. Er sucht jemanden. (Malcolm hat Pfötchens Schlinge ins Leere gespürt und sucht den verschwundenen Sohn.)

**Big Dig:** Er gräbt von unten hinein, weil er Roachs Liste sucht. Danach schließt er sich an (`dig_beigetreten`): „Du suchst wen. Ich such wen. Und du lässt dich hier sonst umbringen.“

**Was mit Roach passiert:**
- ihn vor Ilse und den Insekten bloßstellen: Ansehen bei den Insekten steigt.
- ihn erpressen: Roach wird Fahrer und Informant, später nützlich.
- ihn laufen lassen.
- ihn Corvin übergeben, wenn der schon dabei ist: Er landet an der Pinnwand.

**Das Geld der anderen:** Ilse bringen oder behalten (`pilgerGeld`). Big Dig reagiert darauf.

**Folgeszenen:**
- **Pips' Karton:** Mimi führt hin, dort liegt Pips' Zeichnung: „DER MANN SAGT ICH DARF MIT ZUM KNEUL.“ Big Dig steckt sie ein. Das ist ab jetzt seine Requisite: „Ich find dich, Kleiner.“
- **Lagerszene Big Dig (Pflicht):** Pips, der Fluss, „Ich bin nicht sein Vater.“
- **Unschöne Seite:** Big Dig will einen Ordensbruder verprügeln, der von nichts weiß. Der Held kann ihn bremsen oder lassen.

**Prüfung:**
- *Spaß:* klassischer Einbruch mit fünf Wegen und einem Gefährten, der aus dem Boden bricht.
- *Nachvollziehbarkeit:* Er will sein Zeug zurück. Einfacher geht's nicht.
- *Lösungswege:* fünf hinein, vier für Roach.

---

### Quest 3 · Der Mantelmann (Corvin)

**Worum es geht:** Wer bringt jeden Donnerstag Listen ins Nest? Corvin will es wissen, der Held auch.

**Einstiege** (fünf, je mit anderem erstem Treffen mit Corvin):

| Einstieg | Voraussetzung | Treffen mit Corvin |
| --- | --- | --- |
| Roachs „Mantel – Do.“ | Quest 2 | am Donnerstag auf der Feuertreppe vor Zimmer 7 |
| Haken 7 am Schlüsselbrett | Wahrnehmung im Nest | ebenso |
| Zu laut gefragt | an zwei Orten nach Juno oder dem Orden gefragt | Corvin spricht ihn auf der Straße an. Er hat ihn als Köder benutzt und gibt es zu, wenn man nachbohrt |
| Das Büro | Ilse oder die Nachbarin empfehlen „den Detektiv, der Verschwundene sucht“ | im Büro vor der Pinnwand |
| Mimi | Quest 1.1 | Mimi hat „einen Raben auf dem Dach“ gesehen, jeden Donnerstag |

**Corvins Hausverbot:** Beim Lagerhausbrand vor zwölf Jahren hat er Hummel stundenlang verhört, weil Rook Stammgast im Nest war. Hummel hat das nie verziehen.

**Wege in Zimmer 7** (am Donnerstagabend):

| Weg | Voraussetzung |
| --- | --- |
| Als Kellner | Schicht angenommen |
| Mit dem Schlüssel | stehlen oder leihen, wenn „Honig für Hummel“ erledigt ist |
| Über die Feuertreppe | Corvin oder eine Kletterklasse |
| Von unten | Big Dig, durch den alten Speiseaufzug |
| Angeworben | Täuschen in der Bar. Der Mantelmann nimmt ihn mit hinauf und stutzt: „Normalerweise spüren die Leute was.“ |

**Im Zimmer:** Namen von Roachs Liste mit „aufgenommen“ oder „Waisenhaus“, darunter Pips. Dazu ein weißes Wachssiegel mit Knäuel. Ist Big Dig dabei, will er sofort hinunter, und der Held muss ihn bremsen oder lassen.

**Bruder Ansgar, der Mantelmann:** Ein freundlicher Dachs, der glaubt, Verlorene zu retten. Was das Knäuel wirklich ist, weiß er nicht.

| Wahl | Ergebnis |
| --- | --- |
| **Beschatten** (mit Corvin über die Dächer) | Er führt zur Ordensmission und öffnet so Quest 1.3. Die Dachebene ist danach frei |
| **Stellen und befragen** | Er erzählt bereitwillig und meldet es dem Orden. `orden_wachsam` +1 |
| **Nur die Liste abschreiben** | Corvins Pinnwand wächst, kein Alarm |
| **Big Dig gewähren lassen** | Ansgar wird verprügelt, `orden_wachsam` +2. Mimi hat danach Angst vor Big Dig |

**Corvin schließt sich an** (`corvin_beigetreten`): „Du kannst mich nicht bezahlen. Also bezahlst du mich später.“ Es erscheint nur „Corvin wird sich daran erinnern“. Der erste Knoten kommt erst nach der Schlägerei.

**Folgeszenen:**
- **Lagerszene Corvin (Pflicht):** Notizbuch und Rooks Foto, erzählt als Justizirrtum. Im Büro steht er dabei vor der Pinnwand.
- **Die Dächer:** Corvin öffnet die zweite Ebene. Vincenzo Frankinetti, ein Chamäleon, klebt dort an den Fassaden und fotografiert die Stadt, ohne dass ihn jemand bemerkt. **Eins seiner Fotos zeigt Lil' Riff vor zwei Monaten am U-Bahn-Gitter, neben einer Gestalt mit Kapuze und zu vielen Armen.** Das ist die Weberin, aber das weiß noch niemand.
- **Die Tauben (Fenster Akt 1–2):** Augustin „Gus“ Rook, Rooks Bruder. Corvin weiß das seit zwölf Jahren und hat die Dächer deshalb gemieden. Keine Enthüllung, sondern seine Vorgeschichte: Er geht nur hinauf, weil der Fall es verlangt. Der Spieler kann das Netz nutzen und erfährt dann, wo die Expedition unten hingeht, oder die Tauben befreien. Corvin schlägt vor, eine Taube unter Druck zu setzen. Das ist dieselbe Methode wie im Fall Rook.

**Prüfung:**
- *Spaß:* Beschattung über die Dächer, Einbruch auf fünf Arten, eine Figur zum Mögen, die eigentlich Täter ist.
- *Nachvollziehbarkeit:* Corvins Fall und Junos Spur treffen sich in der Mission.
- *Lösungswege:* fünf Einstiege, fünf Wege hinein, vier Ausgänge.

---

### Quest 4 · Der goldene Ghettoblaster

**Worum es geht:** Ein Botenjob für 80 Collar wird zum Bandenkrieg, und der Bandenkrieg wird heißer, als er sein dürfte.

**Einstieg:** Nugget im Nest bietet Geld für den Ghettoblaster, den die Breaking Cats auf ihrem Platz spielen. Er lügt über den Besitzer (`nuggetLie`).

**Warum Nugget ihn will (zeigt sich erst später):** Malcolm weiß, dass Riff ihn belauscht hat. Bei Riff wurde kein Band gefunden, also muss es im Ghettoblaster stecken. Malcolm zahlt Nugget dafür. Nugget weiß nicht, was er sucht, nur dass es viel Geld bringt.

**Die beiden Seiten:**
- **Künstlerviertel, Breaking Cats:** Der Ghettoblaster gehörte **Lil' Riff**, Adikatz' kleinem Bruder. Riff kam vor zwei Monaten nicht nach Hause. **Shiner** malt kopfüber an einer Wand und fordert jeden zum Wettklettern heraus.
- **Industrie und Hafen, Nomapes:** Don Orango, Nugget, **Knuckles** unter einem Motorrad. **Benny**, ein Mechaniker, schwärmt für Hazel. Über ihn kommt ein Beamter aus ihrem Wohnungsprogramm mit einem Kreditangebot, wenn die Nomapes Frieden schließen. Malcolm war letzte Woche da, mit teuren Schuhen.

**Wege zum Ghettoblaster:**

| Weg | Wie | Folge |
| --- | --- | --- |
| Stehlen | nachts, Schleichen | Cats sauer |
| Abkaufen | teuer, Verhandeln | beide mittel zufrieden |
| Beim Battle gewinnen | Breakdance als Rhythmusspiel (Breaker im Vorteil) | Cats respektieren den Helden |
| Fälschen | Knuckles baut eine Attrappe, wenn man sie gewonnen hat | Nugget merkt es erst später |
| Die Wahrheit herausfinden und zurückgeben | Proben bei Nugget oder Adikatz | Nugget wird zum Feind |

**Das Geheimfach (erste Gelegenheit, Würfelproben):** Wer den Ghettoblaster in den Händen hat, egal auf welchem Weg, kann bemerken, dass er zu schwer ist und hohl klingt.
- **Wahrnehmung SG 14** zeigt den doppelten Boden. Big Dig hat dabei einen Vorteil (er fühlt den Hohlraum), Knuckles findet ihn ohne Probe, wenn man ihr das Gerät zeigt.
- **Fingerfertigkeit SG 12** öffnet das Fach, ohne dass man es sieht. Bei Misserfolg bricht die Klappe ab, und jeder, der den Ghettoblaster danach in die Hand nimmt, merkt es.
- **Gibt der Held ihn ab, ohne das Fach zu finden,** wandert das Band mit dem Gerät weiter, zu Nugget oder zurück zu den Cats. Dann kommt die zweite Gelegenheit beim Battle.
- **Gibt er ihn mit geöffnetem, leerem Fach ab,** merkt Nugget es sofort: „Da war was drin.“ Das ist der Prototyp-Moment (`kapitel1_bar`). Der Ärger beginnt sofort, siehe „Der Ärger um die Kassette“.

**Das Unheimliche daran:** Egal, was der Held tut, der Streit wird schärfer, als er sein dürfte. Nugget wechselt mitten im Satz von gelassen zu rasend. Wer Odile schon erlebt hat, erkennt das Muster (Wahrnehmung). Adikatz' Trauer kippt in Hass, wann immer Nugget im Raum ist. Am Ende rufen beide Gangs für Samstag zum großen Battle auf dem Basketballplatz.

**Prüfung:**
- *Spaß:* fünf Lösungen, zwei Gangs mit Charakter, ein Battle als Minispiel.
- *Nachvollziehbarkeit:* Geld, dann Gewissen.
- *Lösungswege:* fünf.

---

## Die Schlägerei

### Der Battle, der kippt
*Basketballplatz · beide Gangs, die Gefährten, halb Hairlem als Publikum · der Kern des Akts*

- Es beginnt als Tanz-Battle, mit Musik und Jubel. Der Ghettoblaster steht in der Mitte und gibt den Takt.

**Vor dem Kippen: die Kassette (zweite Gelegenheit, Würfelproben).** Nur wenn das Band noch im Gerät steckt.
- Ein Tänzer tritt gegen den Ghettoblaster, das Fach springt auf, eine Kassette rutscht über den Asphalt. Der Beat läuft weiter, keiner achtet darauf.
- **Wahrnehmung SG 12:** Der Held sieht sie und liest „Riff, Take 3“. Ohne Erfolg merkt er nichts, und das Band geht seinen Weg (siehe „Wer die Kassette bekommt“).
- **Wie er sie holt,** ist eine Wahl mit eigener Probe:

| Weg | Probe | Besonderheit |
| --- | --- | --- |
| Unauffällig einstecken | Fingerfertigkeit SG 14 | der Standardweg |
| Mittanzen und im Tanzschritt aufheben | Akrobatik SG 13 | Breaker mit Vorteil. Wer es schafft, gewinnt nebenbei Ansehen bei den Cats |
| Ablenken, damit keiner hinsieht | Täuschen SG 13 | Shiner oder Knuckles helfen, wenn man sie schon kennt |
| Corvin holt sie von oben | Corvin würfelt Fingerfertigkeit | nur mit Corvin |
| Big Dig zieht sie durch den Gully | keine Probe, aber langsam | nur mit Big Dig. Er braucht so lange, dass Nugget es mit Wahrnehmung bemerken kann |
| Mimi holt sie | Überzeugen SG 10 | nur wenn Mimi da ist und dem Helden vertraut |
| Offen nehmen und es draufankommen lassen | Einschüchtern SG 15 | keiner traut sich, ihn aufzuhalten, aber alle haben es gesehen |

- **Misslingt die Probe,** sieht es jemand: Nugget, wenn er näher steht, sonst Adikatz. **Sieht es Nugget,** stürzt er auf den Helden zu, und das ist der Funke. Gezogen wird trotzdem woanders (siehe unten), der Spieler soll sich nur einen Moment schuldig fühlen.

- **Dann kippt es ohne Anlass, und zwar als Welle.** Erst Nugget, dann die Leute um ihn herum, dann der ganze Platz. Zuschauer werfen Flaschen, Big Dig packt einen Nomapen an der Kehle, Corvin hackt nach einem Gesicht. Der Spieler sieht dasselbe wie bei Odile, nur bei Hunderten, und er sieht, dass es von einem Punkt ausgeht. (Regelwerk: Pfötchen zieht an wenigen Schlüsselpersonen, den Rest erledigt die Resonanz.)
- **Nur der Held bleibt ruhig.** Der Kampf hat drei Aufgaben zugleich:
  - **Gefährten zurückholen:** Mit Proben auf Überzeugen und Einsicht bringt er Big Dig oder Corvin aus dem Rausch. Wer zurückkommt, sieht ihn an, als würde er erst jetzt begreifen, wer neben ihm steht. Das ist ein großes gemeinsames Erlebnis und gibt **2 Knötchen** (siehe `zuneigung_und_knoten.md`). Hatte der Spieler vorher schon ein Gespräch im Lager mit diesem Gefährten, ist das der dritte, und es erscheint **die erste Meldung „Knoten geknüpft“**. Sonst erscheint „Knötchen“, und der erste ganze Knoten folgt im nächsten Lager. Sie darf nicht wie Erfahrungspunkte aussehen: eigener Klang (ein leiser Ton, als würde eine Saite gestimmt), eigenes Bild (ein Faden, der sich zwischen den beiden Porträts zuzieht), und das Spiel hält dafür eine Sekunde an. *(Für die Umsetzung.)*
  - **Schützen, wen man schützen will:** Mimi steht am Rand. Benny geht unter. Pounce wird eingekesselt. Wen der Held rettet, hat Folgen für Ansehen, Knuckles' Quest (Benny) und Big Dig (Mimi).
  - **Nugget beobachten:** Wer ihn im Auge behält, sieht, dass er als Erster kippt.
- **Nach dem Kampf** sagt niemand etwas über den Helden. Es ist zu laut, zu viel Blut, alle suchen ihre Leute. Was er ist, kommt erst am nächsten Morgen an (siehe *Der Morgen danach*).
- **Wer Big Dig oder Corvin noch nicht hat,** sieht sie jetzt: Big Dig sucht Pips' Gesicht in der Menge, Corvin beobachtet für seinen Fall. Beide schließen sich an.

**Prüfung:**
- *Spaß:* ein Kampf, in dem Worte und Ruhe genauso zählen wie Treffer, und der einzige Moment, in dem der Held stärker ist als alle.
- *Nachvollziehbarkeit:* Was bei Odile seltsam war, wird hier riesig, und der Spieler versteht ohne Erklärung.
- *Lösungswege:* Wen er rettet und wen er zurückholt, entscheidet er selbst.

---

## Die Nacht danach

### Malcolm
*ein Hinterhof im Künstlerviertel · nach der Schlägerei*

**Ziel der Szene:** Der Spieler soll Malcolm mögen und ihm glauben wollen. Malcolm ist in Akt 1 der Köder: der einzige Erwachsene, der gegen den Orden steht, der Verletzte beider Seiten verbindet und dem Helden hilft, ohne etwas zu verlangen. Jeder Zweifel an ihm muss sich gegen dieses Bild durchsetzen. *(entschieden 13.11.)*

- **Malcolm war nicht auf dem Platz.** Er ist gesucht und zeigt sich nicht offen. Er hat von einem Fenster aus zugesehen. Ein junger Kater aus seiner Bewegung spricht den Helden nach dem Kampf an: „Ihr habt Verletzte. Kommt mit, da hinten fragt keiner nach Namen.“
- In einem Hinterhof hat Malcolms Bewegung ein Lazarett eingerichtet, wo keine Polizei hinkommt. Ein Luchs im teuren Mantel verbindet Verletzte beider Seiten, auch den Nomapen, der ihn eben noch „Katzenprediger“ genannt hat. Er beendet die Sätze der Leute, bevor sie sie zu Ende sprechen. Alle lieben ihn sofort.
- Er spricht den Helden an. Kurz lauscht er, als würde etwas fehlen: „Bei dir ist es still. Weißt du, wie selten das ist?“
- **Er sagt dem Spieler, was der Spieler schon ahnt, und es stimmt:** „Der Orden holt die Kinder. Ganz freundlich, mit Suppe und Formularen. Ich kämpfe seit Jahren dagegen, deshalb hänge ich an jeder Laterne.“ Wer Odile, das Aufnahmebuch oder Roachs Liste kennt, erlebt: Dieser Mann sieht dasselbe wie ich. Das ist der stärkste Köder, weil er wahr ist.
- **Er hilft, ohne zu fragen:** „Die Expedition? Die Gangs kennen die alten Tunnel. Such dir die richtigen Freunde.“ Und wer keine Papiere hat: „Wir machen dir neue. Dauert eine Woche.“ Die Ironie, dass er die echten längst hat, versteht man erst in Akt 2. Die neuen Papiere sind vor dem Abstieg nicht fertig.
- **Teure Schuhe:** Wer Roachs Buchführung gelesen hat, bemerkt die Schuhe (Wahrnehmung). Fragt er nach, erklärt der junge Kater stolz: „Malcolm kauft die Papiere der Neuen, bevor die Garde sie kriegt. Wer keine Papiere hat, steht auf keiner Liste.“ Ein Zweifel, sofort entschärft. Er kehrt erst in Akt 2 zurück.
- **Ganz beiläufig fragt er,** aber nur, wenn er etwas wissen kann (`kassette_gesehen_von` ist nicht „niemand“, oder die Kassette fiel beim Battle heraus): „Bei eurem Tanz ist doch was aus dem Ghettoblaster gefallen, oder?“ beziehungsweise „Nugget sagt, in dem Ghettoblaster war was drin.“ Weiß er nichts, fragt er auch nichts. Wer lügt, braucht Täuschen gegen Malcolm, und das ist schwer, denn er liest jeden. **Beim Helden kann er es nicht lesen**, und das irritiert ihn kurz (Einsicht). Wer die Wahrheit sagt, bekommt ein Angebot: Geld, „als Andenken für Adikatz, der Junge war wie ein kleiner Bruder für uns alle“.
- **Junos Stimme** (Einsicht gelingt): „Juno hätte gesagt: Der meint jedes Wort.“ Sie hat recht, und genau das ist das Problem. Malcolm meint es ernst, nur nicht so, wie der Held denkt. Es ist der erste Moment, in dem ihre Deutung später kippt (siehe *Junos Stimme*).
- **Corvin** vertraut ihm, er ist sein bester Informant, seit zwölf Jahren. Dass er sich regelmäßig mit einem gesuchten Mann trifft, hat er nie jemandem erzählt. **Big Dig** brummt nur, aber er lässt sich die Pfote verbinden und bedankt sich.

### Der Ärger um die Kassette
*ab dem Moment, in dem jemand sieht, dass der Held sie hat · beim Geheimfach in Quest 4 oder beim Battle*

| Wer es gesehen hat | Was passiert | Wege |
| --- | --- | --- |
| **Nugget** | Seine Leute passen den Helden am nächsten Abend in einer Gasse ab, oder sie warten im Nest. Verkauft der Held ihm die Kassette freiwillig, schmeißt Nugget am Abend Runden im Nest, und Hummel fragt: „Von wem hat der das Geld?“ | kämpfen, bluffen (eine falsche Kassette, Knuckles kann eine bespielen), über die Dächer fliehen (Corvin), Hummel versteckt ihn im Keller (wenn er ihm vertraut), die Kassette herausgeben |
| **Adikatz** | Er steht nachts vor dem Unterschlupf: „Das ist von meinem Bruder.“ Er will sie haben, nicht kaufen | geben (er hört sie allein und grübelt danach), zusammen anhören (stärkste Szene, siehe unten), verweigern (die Cats werden feindlich) |
| **Malcolm, über Nugget oder seinen Späher** | Er wird nicht laut. Lehnt der Held sein Geldangebot ab, kommt am nächsten Morgen der junge Kater: „Nugget sucht dich. Malcolm sagt, pass auf dich auf.“ Am Abend tauchen Nuggets Leute auf | wie bei Nugget. Malcolm wirkt wie der Warner, nicht wie der Auftraggeber. Dass er Nugget den Tipp gegeben hat, erfährt man erst in Akt 2 |
| **niemand** | kein Ärger, aber auch keiner weiß, dass der Held etwas Wichtiges hat | – |

**Versteckt man die Kassette**, gibt es mehrere Orte: Big Dig vergräbt sie, Corvin legt sie auf einen Wasserturm, Hummel nimmt sie hinter die Theke. Wer sie bei sich trägt, verliert sie bei einem verlorenen Kampf.

### Die Kassette anhören
*ein ruhiger Ort mit Abspielgerät · freiwillig, jederzeit bis zum Ende des Akts*

- **Der Held hat kein Abspielgerät.** Er braucht eins: Hummels Küchenradio, das Tonbandgerät in Corvins Büro, die Werkstatt der Nomapes oder einen Walkman, den man kaufen oder stehlen kann. Anhören ist also ein bewusster Schritt an einem ruhigen Ort, nicht etwas, das im Kampf passiert.
- **Wer sie nicht anhört,** trägt sie herum. Die Gefährten fragen nach: Corvin („Wir haben ein Band und hören es nicht?“), Big Dig („Vielleicht ist der Kleine drauf“, er meint Pips). Es bleibt trotzdem freiwillig.
- **Was drauf ist:** „Lil' Riff, Take drei …“, ein selbstgebauter Beat mit Tunnelhall.
- **Zwei Stimmen.** Die kühle gehört Malcolm, das erkennt die Gruppe sofort. Die raue ist eine fremde Frau, in Wahrheit die Weberin (GDD). **Jede Zeile lässt sich gut und schlecht lesen** *(entschieden 13.11.: die Kassette sät Zweifel, sie liefert kein Urteil)*:
  - Frau: „Die Tagebücher sagen, es liegt noch da unten.“ – Malcolm: „Dann hole ich es, bevor er es tut.“ *(Gute Lesart: Er will es vor dem Orden retten.)*
  - „Warum trägt er dann Tag und Nacht einen Schlüssel um den Hals?“
  - „Er hat dich aufgezogen wie sein eigenes Blut.“ – „Wie sein eigenes Blut. Ja. So kann man's sagen.“ *(Wer ist „er“? Das weiß der Spieler noch nicht.)*
  - Malcolm: „Das Geld für die Werkstatt ist raus. Die Katzen kriegen ihres morgen.“ – Frau: „Und wenn sie sich davon Eisenstangen kaufen?“ – Malcolm, nach einer Pause: „Dann wissen sie wenigstens, wofür sie kämpfen.“ *(Gute Lesart: Er hilft beiden Seiten. Schlechte: Er bezahlt den Krieg.)*
  - Dann ein Knacken, „Da ist jemand“, und das Band bricht ab.
- **Was gezeigt statt erklärt wird:** Malcolm gibt beiden Gangs Geld und spricht mit einer Fremden über etwas, das „da unten“ liegt. Riff hat das aufgenommen, und Riff ist verschwunden. Mehr steht nicht fest. Ob Malcolm Riff zum Schweigen gebracht hat oder ob Riff vor jemand anderem fliehen musste, kann der Spieler nicht entscheiden.
- **Die Gefährten streiten, statt zu urteilen:** Corvin verteidigt ihn: „Der kauft Frieden. So macht er das seit zwölf Jahren.“ Big Dig: „Wer beiden Geld gibt, will, dass beide ihn brauchen.“ Der Spieler wählt, wem er recht gibt, und nichts davon ist falsch.
- **Junos Stimme** (Einsicht gelingt, beim Abhören): „Juno hätte gesagt: Der hat Angst. Nicht vor der Frau. Um jemanden.“ Das stimmt, und es macht Malcolm noch sympathischer.
- **Zusammen mit Adikatz anhören** (wenn er gekommen ist): Der Tiger hört die Stimme seines Bruders zum ersten Mal seit zwei Monaten, dann Malcolm. Er sagt lange nichts. Dann: „Der war bei Riffs Beerdigung. Ohne Leiche. Er hat die Rede gehalten. Er hat als Einziger geweint.“ Das ist die stärkste Fassung der Szene, weil sie beide Lesarten in einem Satz trägt.
- **Danach:** die Kassette behalten (Beweis), Adikatz geben oder Nugget geben (dann erfährt Malcolm, dass sie gehört wurde). Gibt der Spieler Big Dig recht statt Corvin, steigt `malcolm_risse` um 1. Mehr nicht: In Akt 1 bekommt Malcolms Maske höchstens einen Riss.

### Wer die Kassette bekommt, wenn der Held sie nicht aufhebt

| Wer | Wann | Folge |
| --- | --- | --- |
| **Mimi** | wenn sie auf dem Platz war und der Held die Kassette nicht gesehen oder liegen gelassen hat | Kinder heben auf, was glänzt. Nuggets Leute suchen sie danach. Mimi versteckt sich und kommt zu Big Dig, wenn sie ihm vertraut. Hat er Ansgar verprügelt, geht sie zu Adikatz. Kurze Nebenquest: Mimi finden, bevor Nugget sie findet |
| **Adikatz** | wenn er nah dran stand | Er hört sie allein. Er grübelt danach, wem er glauben soll, und die Cats verhalten sich beim Auftrag vorsichtiger. Der Held erfährt den Inhalt nur, wenn er Adikatz' Vertrauen gewinnt |
| **Nugget** | sonst | Sie geht an Malcolm. Der Beweis ist für Akt 1 verloren, Malcolms Maske hält länger, `malcolm_risse` bleibt niedrig. Der Inhalt kommt in Akt 2 auf anderem Weg ans Licht: über die Weberin, deren Stimme drauf ist, oder über Riff selbst |

**Die Kassette ist keine Pflicht-Spur.** Die Enthüllung des Akts (die Predigt) hängt nicht an ihr. Sie verändert, was der Spieler über Malcolm ahnt, worüber die Gefährten streiten und welche Wege es beim Auftrag gibt.

---

## Der Morgen danach

### Fadenlos
*Whisker Avenue und das Cuckoo's Nest · am Morgen nach der Schlägerei · fest, ein stiller Atemzug*

**Ziel:** Der Spieler soll merken, dass sich etwas verändert hat, bevor ihm jemand sagt, was. Keine Erklärung, keine Entscheidung, nur Reaktionen. *(entschieden 13.11.)*

- **Die Straße flüstert.** Auf dem Weg zum Nest verstummen Gespräche, wenn er vorbeigeht, und setzen hinter ihm wieder ein. Leute treten einen halben Schritt zur Seite. Nicht feindlich, eher so, wie man einem Hund ausweicht, den man nicht kennt.
- **Ein Kind zeigt auf ihn.** Es zupft seine Mutter am Ärmel und sagt laut, wie Kinder es tun: „Das ist der ohne Fäden.“ Die Mutter zieht es weg. Mehr nicht.
- **Hummel stellt ihm wortlos einen Kaffee hin.** Ohne Honig, zum ersten Mal. Er nimmt kein Geld dafür und sieht ihn nicht an. Auch dann, wenn Hummel wegen der verpassten Schicht eigentlich nicht mit ihm redet: Dann ist das Schweigen echt, und der Kaffee sagt mehr. Wer mit ihm redet, bekommt nur: „Trink. Du warst gestern der Einzige, der nicht geschrien hat.“
- **Die Gefährten reagieren verschieden:** Big Dig setzt sich näher zu ihm als sonst. Corvin wartet draußen (Hausverbot im Nest) und schreibt am Fenster „Fadenlos?“ in sein Notizbuch, streicht das Fragezeichen durch und schreibt es wieder hin.
- **Von hier an** sprechen ihn manche NPCs als „Fadenlos“ an (`fadenlos`), manche meiden ihn. Was das Wort bedeutet, erfährt er erst in Akt 2 von der Weberin.

**Prüfung:**
- *Spaß:* Eine ruhige Szene nach dem lautesten Moment des Akts. Der Spieler kann sich frei bewegen und sammelt Reaktionen, statt eine Aufgabe zu erfüllen.
- *Nachvollziehbarkeit:* Wer auf dem Platz war, hat gesehen, dass nur der Held ruhig blieb. Die Straße hat es auch gesehen.
- *Was die Schlägerei dadurch verliert:* nichts. Sie bleibt Kampf, Rettung und erster Knoten. Die Bedeutung kommt hier, wenn es still ist.

---

## Der Auftrag

### Zwei Bosse, ein Wunsch
*Werkstatt der Nomapes, Hauptquartier der Breaking Cats*

- Nach der Schlägerei verlangen beide Bosse dasselbe: Der andere muss weg. Der Held ist neu, keiner kennt ihn, und seit dem Platz hat er einen Ruf.
- **Der Weg nach unten führt über die Gangs:** Die Cats kennen die Graffiti-Tunnel, die Nomapes ihre Schmuggelstrecken. Wer in die Subfurs will, braucht eine Seite. Das ist der Anlass, aber nicht der Grund, warum die Wahl wehtut. *(entschieden 13.11.: von der Zugangskarte zur sozialen Folge)*

**Was jede Seite unter Schutz versteht.** Beide wollen ihre Leute schützen, aber sie meinen etwas anderes damit:

| | Breaking Cats | Nomapes |
| --- | --- | --- |
| **Was sie verlieren können** | jemanden, der nicht ersetzt werden kann | ihre Existenz |
| **Das Gesicht dafür** | Riffs Platz im Studio: Sein Bandgerät steht noch aufgebaut, keiner traut sich, es abzubauen. Pounce stellt jeden Abend eine Cola daneben | die Werkstatt am Lohntag: Benny zahlt die Löhne aus einer Keksdose aus, und für zwei Familien reicht es diesen Monat nicht |
| **Schutz heißt für sie** | Zusammenhalt und Antwort. Adikatz: „Wer einen von uns nimmt, nimmt uns alle. Wenn wir nicht antworten, sind wir die Nächsten.“ | Weitermachen. Don Orango: „Stolz zahlt keine Miete. Wer tot ist, schraubt nicht.“ |
| **Was ein Krieg für sie bedeutet** | eine Ehrensache, die man gewinnen muss | ein Geschäftsrisiko, das man beenden muss, notfalls schmutzig |

- **Beide Gesichter sieht der Spieler vor der Wahl**, ohne dass ein Pflichtschritt daraus wird: das Studio beim Battle oder beim Ärger um die Kassette, die Werkstatt bei Knuckles oder über Benny. Wer eine Seite nie besucht hat, bekommt sie von dem Gefährten der anderen Seite beschrieben, damit niemand blind entscheidet.
- **Die Warnung vor dem Verlust.** Nimmt der Held den Auftrag gegen einen Boss an, sagt es ihm die Figur der Gegenseite selbst, wenn er sie schon kennt: Knuckles, ruhig und ohne Drohung, „Wenn du das machst, bin ich weg. Nicht wütend. Einfach weg.“ Shiner, lauter: „Dann kletter ich ab morgen allein.“ Kennt er sie noch nicht, warnt Big Dig: „Da drüben hängen auch Leute dran.“ Danach ist der Verlust eine Entscheidung und keine Strafe.

**Wege:**

| Weg | Wie | Folge |
| --- | --- | --- |
| Den Auftrag ausführen | Kampf gegen den anderen Boss | Brutal und möglich. Der Gefährte der Gegenseite ist für immer verloren |
| Tod vortäuschen | mit Shiner oder Knuckles als Komplizin | Der Boss überlebt im Versteck, der Krieg geht weiter |
| Den Boss warnen | Wechsel auf seine Seite | Die erste Seite wird zum Feind |
| Beide Aufträge annehmen und erst am Ende entscheiden | Täuschen, mehrere Proben | Riskant, aber der Held bestimmt, wer verliert |
| Nugget bloßstellen | mit Kassette, Beobachtungen und Corvins Pinnwand vor beiden Bossen | Schwerste Probe. Bei Erfolg kommt ein kurzer Waffenstillstand, nicht mehr. Das echte Gespräch der beiden alten Männer bleibt für Knuckles' Bogen in Akt 4 |

- **Die Gang-Wahl** (`gang_wahl`): Shiner schließt sich bei den Cats an, Knuckles bei den Nomapes. Shiner will Ruhm und Riffs Entführer finden, Knuckles will den Krieg beenden, bevor er die Werkstatt ruiniert.
- **Lagerszene Shiner oder Knuckles (Pflicht).**

**Prüfung:**
- *Spaß:* echte Wahl mit Folgen bis ins Finale, wie in Fallout: New Vegas, und ein listiger Weg für Spieler, die beide Seiten ausspielen.
- *Nachvollziehbarkeit:* Der Held braucht die Tunnel, die Gangs haben sie.
- *Lösungswege:* fünf.

---

## Das Ende des Akts

### Die Predigt
*Corvins Büro, dann die Straße*

- An der Pinnwand hängt jetzt alles: Roachs Liste, das Siegel, das Aufnahmebuch, Pips' Zeichnung, die Kassette, Vincenzos Foto. Corvin fasst zusammen, denn ein Detektiv darf das: „Die holen Kinder und Gläubige, ganz freundlich. Die bringen Leute zum Kippen. Und Geld fließt in beide Gangs.“ Er sieht die Kassette an, falls sie dort hängt, und nimmt sie ab. „Das ist Malcolms Sache. Der kauft Frieden. Aber wer zieht die Fäden?“
- **Die Antwort kommt durch ein Ereignis.** Der Fernseher im Pfandhaus unten läuft, Pfötchen ruft nach den Unruhen zur Ruhe. Draußen schreien sich noch Leute an. Dann wird es still, als Welle wie auf dem Platz, nur umgekehrt: Zuerst beruhigt sich die Ordensschwester an der Ecke, dann der Kreis um sie, dann die ganze Straße, mitten im Satz.
- Der Held sieht es als Einziger als das, was es ist: Odiles Moment, Nuggets Kippen, die Schlägerei, und jetzt das Gegenteil. **Derselbe, der das Feuer gelegt hat, löscht es auch, und am Ende lieben ihn alle dafür.** Gezeigt wird das nur durch die Reihenfolge: erst die Schlägerei, dann die Predigt, dann Menschen, die am Fernseher weinen vor Dankbarkeit.
- **Junos Gesicht im Fernsehen.** Am Ende der Predigt segnet Pfötchen „unsere Expedition in die Tiefe“. Bilder vom Aufbruch am U-Bahn-Gitter, und für zwei Sekunden Juno in Weiß, ruhig, mit einem Lächeln, das der Held nicht kennt. Wer den Zettel gefunden hat, bekommt die Bestätigung. Wer die Mission nie betreten hat, erfährt hier, wohin sie gegangen ist. So funktioniert das Ende auch für Spieler, die Quest 1 ausgelassen haben.
- Corvin, sehr leise: „Das Rathaus regiert nicht.“ Mehr Erklärung braucht es nicht.

### Abstieg
*über den Tunnel der gewählten Gang*

- **Warnung vor dem Übergang**, als Kommentar der Gefährten: Corvin erinnert an offene Tauben, Big Dig sagt: „Wenn wir runtergehen, sind wir eine Weile weg.“ Hummel gibt Honig mit, wenn ihre Quest erledigt ist.
- Über die Brücken kommt der Held nicht: Er hat keine Papiere, und „der Fadenlose“ steht jetzt auf den Listen der Garde. Unten sind Juno, Riffs Spur und das, was „noch da unten liegt“.
- `akt_wechseln(2)`.

---

## Prüfung des Akts

### 1. Logik

| Loch | Lösung |
| --- | --- |
| Warum will Nugget den Ghettoblaster? | Malcolm sucht Riffs Band und zahlt Nugget, ohne zu sagen, was drin ist |
| Wie kommt Riff ins Aufnahmebuch der Mission? | Er ist nach dem Lauschen selbst zum Orden gelaufen, um „den Meister zu warnen“, und der Orden hat ihn der Garde übergeben |
| Warum kauft jemand gestohlene Papiere? | Malcolm kauft seit Monaten die Papiere aller allein angereisten Neuankömmlinge um die 25. Er sucht den Sohn |
| Warum schürt Pfötchen den Bandenkrieg? | Brandstifter und Feuerwehr: Erst heizt er an, dann beruhigt er per Predigt. Danach lieben ihn mehr Menschen, und jede neue Schlinge ist mehr Hebel |
| Eine ganze Straße kippt gleichzeitig? | Nach dem Regelwerk geht das nicht. Es ist eine Welle, die von wenigen Schlüsselpersonen ausgeht. Das ist sogar besser, denn der Held sieht, wo sie anfängt |
| Juno ging „am Morgen“, aber der Held soll sie noch sehen? | Sie geht in genau dem Moment, in dem er die Mission betritt. Die Tinte auf dem Zettel ist noch feucht |
| Wie hört man im Tumult eine Kassette? | Gar nicht. Gefunden wird sie per Würfelprobe, entweder im Geheimfach (Quest 4) oder beim Tanz, bevor es kippt. Anhören ist ein eigener Schritt an einem ruhigen Ort mit Abspielgerät |
| Malcolm ist gesucht, warum steht er zwischen Verletzten auf dem Platz? | Er steht dort nicht. Er sieht vom Fenster aus zu, sein Späher holt den Helden in ein verstecktes Lazarett im Hinterhof |

### 2. Dramaturgie

**Kurve:** Ankunft und Verlust (Prolog) → Rätsel (Wohnung, Odile) → emotionaler Mittelpunkt (Junos Zettel) → Eskalation (Ghettoblaster) → Höhepunkt (Schlägerei) → Atemzug (Morgen danach, Fadenlos) → Zweifel (Malcolm und die Kassette) → Entscheidung (Auftrag) → Enthüllung (Predigt) → Aufbruch.

**Druck von außen:** Bisher wehrt sich der Orden nie. Neu: `orden_wachsam` hat spürbare Folgen.
- **Ab 2:** Eine Streife der Garde hält den Helden auf der Straße an. Er hat keine Papiere. Er kann fliehen, bluffen, oder Corvin zeigt einen alten Dienstausweis, was ihn etwas kostet.
- **Ab 4:** Bruder Ansgar sitzt abends im Nest und beobachtet den Helden. Hummel warnt ihn leise. Am nächsten Tag lädt ihn Odile „ganz unverbindlich“ in die Mission ein. Ist Odile verletzt, kommt eine andere Schwester, die ihn nicht kennt, und das ist unheimlicher.
- **Nach der Schlägerei immer:** „Der Fadenlose“ steht auf den Listen der Garde.

**Rhythmus von Ernst und Komik:** Nach jedem schweren Moment kommt ein leichter, damit der Ernst wirkt und nicht erdrückt.

| Schwerer Moment | Danach, leicht |
| --- | --- |
| Überfall in der Gasse | Ilse schimpft auf Roach wie eine Großmutter |
| Erste Nacht, Erinnerung | Hummel am Morgen, verschlafen, mit zu viel Honig im Kaffee |
| Junos Zettel | Big Dig versucht zu trösten, ungeschickt. Er bietet einen Stein an: „Der hier hilft mir manchmal.“ |
| Pips im Aufnahmebuch | Mimi will Big Dig beibringen, wie man „Fang mich doch“ spielt |
| Die Schlägerei | Knuckles entschuldigt sich bei jedem, den sie getroffen hat, einzeln |
| Die Kassette | Corvins Monolog über Vertrauen, so übertrieben noir, dass Shiner ihn nachäfft. Bei Nuggets Hinterhalt: Knuckles' falsche Kassette spielt ihr Lieblingslied aus der Telenovela |
| Die Predigt | keiner. Hier soll es kalt bleiben bis zum Abstieg |

### 3. Spielbarkeit

**Wenn der Spieler … dann …**

| Situation | Was passiert |
| --- | --- |
| zuerst in die Mission geht, ohne Gefährten | nur Wege für einen: Einladung, Küche mit Armband, Suppenschlange mit Einbruch. Big Dig und Corvin fehlen dort, alles andere funktioniert |
| die Garage nie macht | Er kämpft mit improvisierter Ausrüstung, und die Schlägerei ist darauf abgestimmt. Big Dig trifft er bei der Schlägerei, die Garage bleibt danach offen |
| die Mission nie betritt | Er sieht Juno am Ende in der Predigt im Fernsehen, beim Aufbruch der Expedition. Das Ziel „nach unten“ ist damit klar |
| Quest 4 nie anfängt | Die Schlägerei kommt am Samstag nach Junos Zettel, spätestens an Tag 7. Der Ghettoblaster ist trotzdem auf dem Platz, denn die Cats spielen ihn immer |
| Odile verletzt | Andere Wege in die Mission bleiben offen. Odile taucht in Akt 3 im Lager wieder auf und erinnert sich |
| Hummels Vertrauen verliert | Kein Zimmer auf Pump mehr. Big Digs Keller oder Corvins Büro werden zum Unterschlupf |
| Big Dig Ansgar verprügeln lässt | Mimi meidet Big Dig bis Akt 2. Big Digs Zuneigung zum Helden steigt trotzdem, das ist seine unschöne Seite |
| den Auftrag ausführt | Der Gefährte der Gegenseite ist verloren, die andere Gang bleibt bis Akt 4 feindlich |

**Die Kassette:** keine Pflicht-Spur mehr, siehe „Wer die Kassette bekommt“. Ohne sie fehlt beim Auftrag der Weg „Nugget bloßstellen“ mit dem Band als Beweis. Er bleibt mit Beobachtungen allein möglich, ist dann aber deutlich schwerer.

**Auslöser der Schlägerei:** am nächsten Samstag, nachdem Quest 4 entschieden ist oder Junos Zettel gefunden wurde, je nachdem, was zuerst kommt. Es gibt keinen Zeitdruck, aber auch kein Warten ohne Ende: Spätestens an Tag 7 nach dem Überfall findet der Battle statt, die Gangs haben ihn überall plakatiert.

---

## Was gezeigt und was erklärt wird

| Thema | Gezeigt durch | Direkt erklärt? |
| --- | --- | --- |
| Der Held fühlt nicht mit | Jukebox, Erinnerung | nein |
| Manipulation | Odiles Moment, Nuggets Kippen, die Schlägerei, die Predigt | nein |
| Was der Orden mit Menschen macht | Grille Grimm, Junos Zettel | nein |
| Der Orden holt Kinder | Roachs Liste, Zimmer 7, Aufnahmebuch | nur als Gerede (Ilse) |
| Malcolm ist vielleicht nicht nur, wer er scheint | Kassette nach seinem warmen Auftritt, nur wenn gehört, und nur als Zweifel | nein |
| Wer regiert | die Predigt | Corvin zieht die Summe, ein Satz |
| Warum der Held so ist | – | erst in Akt 2, durch die Weberin |

---

## Was der Spieler wann über den Helden erfährt

| Wann | Was | Wie |
| --- | --- | --- |
| Akt 1, erste Nacht | Er liebt, fühlt aber nicht mit, er liest | Erinnerung |
| Akt 1, Odile und Ansgar | Bei ihm „kommt nichts an“ | Andeutung |
| Akt 1, Schlägerei | Er ist immun, die Stadt nennt ihn „Fadenlos“ | Ereignis |
| Akt 1, Malcolm | „Bei dir ist es still.“ | Andeutung |
| Akt 2, Lagerszene der Weberin | Warum: Jemand hat ihn aus dem Faden geschnitten. Das Taschen-Bild erklärt, was das heißt | Gespräch, bevor das Anknüpfen kritisch wird |
| Akt 2, Mitte | Was es kostet: das erste, unabsichtliche Anknüpfen | Ereignis |
| Akt 2 | Er ist von hier: eine Narbe im Knäuel mit seinem Geburtsdatum | Musterbuch |
| Akt 3 | Wer geschnitten hat: der Meister, die Weberin zeigte ihm die Stelle | Beichte |
| Akt 4 | Wessen Sohn er ist | die Wahrheit (GDD) |

---

## Nebeninhalte

| Inhalt | Wo | Bindet an |
| --- | --- | --- |
| Honig für Hummel (Prototyp) | Nest | Hummels Schlüssel für Zimmer 7 |
| Grille Grimm | Whisker Avenue | zeigt, was das Lager aus Menschen macht |
| Vincenzo Frankinetti | Dächer, an Fassaden geklebt | Chamäleon und Paparazzo. Sein Foto zeigt Riff und die Kapuzengestalt am Gitter |
| Gus Rook und die Tauben | Dächer | Corvin, Juno-Spur, Finale |
| Antonia | Garage | Informantin, wenn überredet |
| Hazels Wahlkampfauftritt | Platz vor dem Bezirksamt, aus der Ferne | Benny jubelt in der ersten Reihe, Big Dig arbeitet für ihr Programm |
| Shiners Wettklettern | Künstlerviertel | Corvin, Shiners Rivalität |

---

## Neue Variablen für das Zustandsregister

Alle stehen jetzt im Register (für die Papier-Spieltests), dazu `mimi_vertraut` und `juno_stimme`. Der Ausgang des Auftrags heißt dort `auftrag_ausgang`, weil `auftrag` im Prototyp schon den Auftraggeber meint. Zahlen werden mit `GameState.erhoehen(name, d)` gezählt.

| Variable | Werte | Gesetzt in | Gelesen von |
| --- | --- | --- | --- |
| `schicht` | offen, angenommen, abgelehnt, verpasst | Nest | Hummel, Zimmer 7 |
| `juno_spur` | 0–5 | Quest 1, Tauben | Junos Begegnung in Akt 2 |
| `odile` | unbekannt, gewonnen, getaeuscht, verletzt | Quest 1.2 | Weg in die Mission, Akt 3 (Lager) |
| `mission_weg` | einladung, aufnahme, kueche, oben, unten, einbruch | Quest 1.3 | Odile, `orden_wachsam` |
| `juno_zettel_gesehen` | ja, nein | Quest 1.3 | Junos erste Worte in Akt 2 |
| `roach` | bloßgestellt, erpresst, laufen_gelassen, corvin | Quest 2 | Roach als Fahrer oder Informant |
| `mantelmann` | unbekannt, beschattet, gestellt, abgeschrieben, verpruegelt | Quest 3 | Big Dig, Ansgar im Lager (Akt 3) |
| `zimmer7_weg` | kellner, schluessel, feuertreppe, keller, anwerbung | Quest 3 | Hummel, Ansgar erkennt ihn wieder |
| `ghettoblaster` | gestohlen, gekauft, gewonnen, gefaelscht, zurueckgegeben | Quest 4 | Ansehen, Auftrag |
| `fadenlos` | ja, nein | Schlägerei | Anrede der NPCs |
| `gerettet` | Liste: mimi, benny, pounce | Schlägerei | Big Dig, Knuckles, Cats |
| `kassette` | im_geraet, geheimfach, battle_heimlich, battle_gesehen, mimi, adikatz, nugget | Quest 4, Battle | Ärger danach, Auftrag, Malcolm in Akt 2 |
| `kassette_gesehen_von` | niemand, nugget, adikatz | Quest 4, Battle | Ärger um die Kassette, Malcolm erfährt es über Nugget |
| `kassette_gehoert` | ja, nein | Anhören | Corvins Vertrauen, Auftrag, Weberin in Akt 2 (Stimme erkannt) |
| `auftrag_ausgang` | offen, ausgefuehrt, vorgetaeuscht, gewarnt, doppelt, nugget_entlarvt | Der Auftrag | Gang-Wahl, Bosse in Akt 4 |
| `orden_wachsam` | 0–5 | mehrere | Listen der Garde, Gegenzüge in Akt 2 |

Die Prototyp-Flags (`mimiFound`, `hasTape`, `pilgerGeld` …) bleiben, bis die Dialoge umgebaut sind.

---

## Was sich gegenüber dem Prototyp ändert

- Der Held kommt allein. Ab dem zweiten Tag ist Hairlem offen.
- Der Brief wird im Taxi gelesen, die Charaktererstellung steckt in Roachs Fragen.
- Der Überfall nimmt auch Papiere und Ausrüstung. Die Papiere hat Malcolm gekauft.
- Big Digs vermisstes Kind heißt Pips, das helfende Mädchen Mimi.
- Die Branx gibt es nicht mehr. Die Cats sitzen im Künstlerviertel, die Nomapes in Industrie und Hafen.
- Die Kassette wird erst nach der Schlägerei gefunden, im aufgesprungenen Gehäuse. Die raue Stimme gehört der Weberin.
- Neu: Junos Wohnung als Ereignis, Schwester Odile, die Ordensmission, Junos Zettel, Bruder Ansgar, Vincenzos Foto.
- Vincenzo ist ein Chamäleon statt eines Flughörnchens und sitzt auf den Dächern von Hairlem.

## Was sich gegenüber dem GDD ändert

- Keine sichtbaren Monsterhunde: Kontrollposten der Ordensgarde an den Brücken, Monsterhunde nur im Verborgenen *(entschieden)*.
- Juno sieht der Held in Akt 1 nur aus der Ferne. Die erste Begegnung bleibt in Akt 2.

---

## Junos Stimme *(entschieden 13.11.)*

**Die Idee:** Der Held liest Menschen, aber er fühlt nicht mit. Früher hat Juno ihm übersetzt, was andere fühlen. Ihre Übersetzungen sind in ihm geblieben. Gelingt eine Einsicht-Probe, erscheint statt einer neutralen Auskunft ihr Satz:
> *Juno hätte gesagt: Der ist nicht wütend. Der hat Angst.*

So ist Juno in jedem Gespräch dabei, auch wenn sie fehlt, und der Spieler spürt, warum der Held sie sucht: Ohne sie ist er halb blind.

**Regeln, damit sie keine allwissende Kommentarfunktion wird:**
1. **Sie bietet eine Deutung an, kein Urteil.** Sie sagt, was Juno gesehen hätte, nicht, was wahr ist.
2. **Sie kann sich irren.** Fehldeutungen sind geschrieben, nie zufällig. Die wichtigste in Akt 1 betrifft Malcolm: „Der meint jedes Wort.“ Das stimmt, aber es führt in die falsche Richtung.
3. **Manchmal bleibt sie aus.** Bei misslungener Probe kommt nichts, nur die Beschreibung. Und bei manchen Menschen schweigt sie auch bei Erfolg, weil Juno so jemanden nie kennengelernt hat (etwa bei der Weberin in Akt 2).
4. **Manche Menschen tragen zwei Deutungen.** „Juno hätte gesagt: Die ist glücklich. Oder sie hätte gesagt: Die hat Angst, es nicht zu sein.“
5. **Ihre Stimme verändert sich mit dem Helden:**
   - Akt 1: „Juno hätte gesagt: …“ Er verlässt sich darauf.
   - Akt 2, nachdem er Juno begegnet ist und sie ihn abweist: „Ich glaube, Juno hätte gesagt: …“ Er ist unsicher, ob er sie noch kennt.
   - Akt 3, nachdem er gesehen hat, dass sie sich bei Malcolm geirrt hat: Manchmal widerspricht er ihr. „Juno hätte gesagt: Die lügt. Ich glaube nicht.“ Je nach `juno_offenheit` und den Knoten seiner Gruppe.
   - Akt 4 und Ende: Bei einem guten Bogen sagt er es selbst, ohne Juno. Er hat nicht gelernt, mitzufühlen, aber er hat von seinen Gefährten gelernt, anders zu lesen. Bei einem schlechten Bogen bleibt ihre Stimme die einzige, oder sie verstummt ganz.
6. **Die Spiegelung:** Junos Regeln passen auf alle, nur nicht auf Malcolm und nicht auf den Helden selbst. Wer erkennt, dass sie sich bei Malcolm geirrt hat, erkennt, dass sie auch ihn nie ganz lesen konnte (siehe Malcolm in `charakterbiografien.md`).
7. **Der Kern:** Juno ist nicht unfehlbar, und der Held darf nicht für immer von ihrer Deutung abhängen. Sein Bogen ist nicht, Gefühle zu bekommen, sondern zu verstehen, was Verbindung ist, auch wenn er nicht mitschwingt.

**Feste Stellen in Akt 1:**

| Wo | Junos Satz | Richtig? |
| --- | --- | --- |
| Odiles Moment (Einsicht 12) | „Die weint nicht um den Jungen. Die weint, weil sie nicht weiß, um wen.“ | ja |
| Hummel am ersten Abend | „Der redet viel, damit keiner fragt, wie's ihm geht.“ | ja |
| Nugget vor der Schlägerei | „Der will nicht den Ghettoblaster. Der will, was jemand ihm dafür gibt.“ | ja |
| Malcolm im Lazarett | „Der meint jedes Wort.“ | ja, aber irreführend |
| Malcolm auf der Kassette | „Der hat Angst. Nicht vor der Frau. Um jemanden.“ | ja |
| Big Dig, wenn er nach Pips fragt | keine Stimme. Juno kannte niemanden, der ein Kind verloren hat | – |

**Umsetzung:** Sprecher „Juno (Erinnerung)“ in den Dialogen, eigene Schrift (kursiv, etwas blasser) und ein eigener leiser Ton. Der Fortschritt läuft über `juno_stimme` (1 bis 4).

## Grundsatz: Verbindungen über Systeme, nicht über Zufälle *(entschieden)*

Figuren begegnen sich über den Orden, das Knäuel, die Mission und den Bandenkrieg, denn die berühren ganz Hairlem. Verwandtschaften und alte Bekanntschaften sind Zufälle und werden sparsam eingesetzt, höchstens eine persönliche Verbindung pro Gefährte. Die meisten Figuren bleiben Fremde mit eigenem Leben.

## Entschieden (13.11.)

- **Neue Figuren und Namen:** Schwester Odile (Gans), Bruder Ansgar (Dachs), Augustin „Gus“ Rook (Taubenzüchter).
- **Corvins Hausverbot im Nest** wegen der Verhöre zum Fall Rook.
- **Lil' Riff** wurde der Ordensgarde übergeben (Cpt. V., also Vale). Das verbindet den Bandenkrieg mit Barkleys und Corvins Geschichte.
- **Warum der Orden nach unten geht:** Die Expedition bringt den Ausgestoßenen Suppe und Predigten. Dadurch entstehen Schlingen, an denen Pfötchen später ziehen kann.
