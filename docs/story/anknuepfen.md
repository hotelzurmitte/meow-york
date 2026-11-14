# Anknüpfen: was es heißt, wenn ein Fadenloser sich verbindet

*Stand 14.11.2026 · entschieden · Grundlage: Regelwerk, Abschnitt D2 · Code: `GameState.anknuepfen()`, `GameState.lange_rast()`, berechnet `held_zustand`*

## Was Anknüpfen ist (Regelwerk)

Der Held kann seinen Faden bewusst an den einer Person binden, die ihm etwas bedeutet, wie zwei Wollenden, die man zusammenknotet. Solange er festhält, fließen Resonanz und Zug hindurch. Lässt er los, ist er wieder getrennt.

- **Nur bei gegenseitigen Beziehungen,** nie bei Fremden. Eine einseitige Schlinge trägt nicht.
- **Die Person spürt es auch.** Wer lügt, merkt, dass er geprüft wird.
- **Wie er es lernt:** zuerst unabsichtlich (Akt 2), später erklärt Malcolm es ihm, scheinbar hilfsbereit. In Wahrheit hofft Malcolm, dass der Held es oft tut.

## Warum es für ihn eine erhebliche Sache ist

Für jeden anderen wäre Anknüpfen eine Kleinigkeit. Für den Helden ist es **das Einzige, was ihn je fühlen lässt,** und **das Einzige, was ihn erreichbar macht.** Jede Anknüpfung ist darum zugleich Geschenk und Gefahr. Vorher wusste er nicht, was ihm fehlt. Nach dem ersten Mal weiß er es genau, und es wird zur Versuchung, es wieder zu tun.

---

## Dauer: drei Stufen

Jede Anknüpfung hat eine Dauer, die der Spieler bestimmt, indem er festhält oder loslässt.

| Stufe | Was er erlebt | Verwachsung | Aufmerksamkeit |
| --- | --- | --- | --- |
| **1 · Berühren** (ein Atemzug) | Er fühlt die Person: Angst, Wärme, Lüge | +1 | +1 |
| **2 · Halten** (ein Gespräch lang) | Er fühlt die Person ganz, und schwach, was durch sie hindurchschwingt: ein Stück Stadt. Seine Ruhe fließt zu ihr hinüber | +2 | +1 |
| **3 · Sich verlieren** (länger, bis ihn etwas herausreißt) | Er schwingt mit wie alle anderen. Die Gefühle überschwemmen ihn, er kann sie nicht sortieren | +3 | +2 |

**Ist die Aufmerksamkeit des Knäuels schon hoch (ab 5),** kommt auf jede Anknüpfung +1 Verwachsung dazu: Das Knäuel wartet bereits auf ihn.

**Die Aufmerksamkeit sinkt** mit jeder langen Rast um 1. **Die Verwachsung sinkt nicht von selbst.** Sie ist die Spur, die jede Anknüpfung an seiner Narbe hinterlässt.

---

## Was die Verwachsung mit ihm macht

Die Narbe, an der er herausgeschnitten wurde, franst mit jeder Anknüpfung weiter aus. Daraus ergibt sich sein Zustand (`held_zustand`):

| Verwachsung | Zustand | Was passiert |
| --- | --- | --- |
| **0–2** | **frei** | Nur der Moment selbst. Danach ist er wieder ganz der Fadenlose |
| **3–4** | **Nachklang** | Nach jeder Anknüpfung schwingt bis zur nächsten langen Rast ein Rest mit: Er spürt die Stimmung im Raum schwach, Bardenlieder wirken auf ihn, im Kampf kann ihn Furcht treffen. Er träumt vom Knäuel. Junos Stimme wird leiser, als hätte sie Konkurrenz bekommen |
| **5–6** | **ausgefranst** | Pfötchen spürt ihn bei jeder Anknüpfung, nicht nur beim ersten Mal, und weiß, wo er ist. Hohe Aufmerksamkeit löst Gegenzüge aus: Pfötchen zieht an der Person, mit der der Held gerade verbunden war. Die Gefährten merken etwas: „Du bist anders, seit …“ |
| **7–8** | **verwachsen** | In starken Momenten beginnt die Anknüpfung von selbst (Tod, Abschied, Wiedersehen). Der Spieler kann loslassen, braucht dafür aber eine Probe. Seine Fadenlos-Fähigkeiten werden schwächer: Im Finale kann ihn Pfötchens Ziehen in Station 2 und 5 kurz erreichen |
| **9–10** | **gefährdet** | Sitzt Pfötchen oder Malcolm während einer Anknüpfung am Knäuel, kann er den Übergang schließen. Das ist der Weg zur Einwebung, ohne dass der Held sie gewählt hat. Im Finale ist er in Station 6 einspleißbar, ob er will oder nicht |

**Warnungen, damit es nicht unfair wird:** Jeder neue Zustand wird gezeigt, nicht als Zahl, sondern als Szene: der erste Traum vom Knäuel, der erste Gefährte, der „Du bist anders“ sagt, die erste Anknüpfung, die von selbst beginnt. Ab „ausgefranst“ warnt die Weberin ausdrücklich, wenn sie in der Gruppe ist.

**Was dagegen hilft:** Die Weberin kann einmal pro Akt die ausgefransten Fasern abschneiden (Verwachsung −2). Sie öffnet dafür einen winzigen Übergang an der Narbe, das kann nur sie so genau. Der Preis: Der Held verliert die Erinnerung daran, wie sich die letzte Anknüpfung angefühlt hat. Er weiß noch, dass er etwas gefühlt hat, aber nicht mehr was.

---

## Warum er es trotzdem tut

Damit Anknüpfen eine echte Versuchung ist und kein Fallstrick, muss es sich lohnen:
- **Wahrheit:** Er spürt, ob jemand lügt, auch dort, wo Junos Stimme schweigt.
- **Halten:** Er kann ein panisches Kind beruhigen oder einen Sterbenden halten. Manche Szenen lassen sich nur so lösen.
- **Knötchen:** Erlebt er mit einem Gefährten einen schweren Moment, während er angeknüpft ist, gibt es ein Knötchen zusätzlich. Gemeinsames Erleben ist stärker, wenn man es wirklich teilt.
- **Fadensicht:** Nach einigen Anknüpfungen (`held_anknuepfen`) lernt er, die Fäden der Stadt zu sehen. Das öffnet Wege und Gespräche.

Und Malcolm erklärt ihm genau das, freundlich und geduldig.

---

## Feste Anknüpfungen in der Geschichte

| Wo | Was | Pflicht? |
| --- | --- | --- |
| **Akt 2, das erste Mal** | unabsichtlich, wenn er einen sterbenden Freund festhält. Pfötchen spürt zum ersten Mal, dass sein Sohn lebt | ja, Stufe 1 |
| **Akt 2 oder 3, Malcolm erklärt es** | ab dann bewusst einsetzbar | ja |
| **Akt 4, das Foto der Mutter** | die erste Anknüpfung an den Vater (siehe unten) | nein, der Spieler entscheidet die Dauer |
| **Finale, Station 6** | Weg „Der Sohn“: an den Vater anknüpfen, damit Pfötchen fühlt, was er getan hat | nein |

---

## Das Foto der Mutter *(Akt 4, Hauptquest 4.1)*

**Warum hier überhaupt eine Anknüpfung möglich ist:** Bisher war Pfötchens Liebe zum Sohn eine Schlinge ins Leere, einseitig, nicht belastbar. Als der Held das Foto sieht, den Babyschuh, den Satz „Er hat deine Ohren“, begreift er, dass er geliebt wurde. In diesem Moment legt sich zum ersten Mal eine Schlinge von ihm zum Vater zurück. Die Beziehung ist gegenseitig, und die Narbe zieht, denn die Kammer liegt nah am Knäuel.

**Drei Schritte, der Spieler kann nach jedem das Foto weglegen** (`kammer_resonanz`):

1. **Ansehen.** Nur das Bild. Keine Verbindung, keine Kosten. Der Spieler setzt zusammen, wer sie war. Weglegen: Er legt das Foto mit dem Bild nach unten, die Weberin sagt: „Das war klug. Und traurig.“
2. **Länger ansehen: Berühren.** Der Ton wird dünner, ein Faden spannt sich vom Foto zu seiner Brust. Er fühlt einen Atemzug lang die Liebe seines Vaters, die ihn fünfundzwanzig Jahre gesucht hat. Big Dig sieht, dass seine Hand zittert. Verwachsung +1, Aufmerksamkeit +1. Pfötchen spürt, dass sein Sohn nah ist.
3. **Nicht loslassen: Halten bis Verlieren.** Jetzt kommt alles: die Trauer des Vaters um die Frau, die Nacht, in der er ihn fortbrachte, das Suchen, und darunter schwach die ganze Stadt, wie Rauschen. Er weint, ohne zu wissen, dass es das ist. **Und Pfötchen sitzt in dieser Stunde am Knäuel,** denn vor der Gründungsnacht betet er jeden Abend dort. Er spürt seinen Sohn ganz. Er könnte den Übergang schließen. Der Held hört eine Stimme, die nicht seine ist: „Bleib.“ Dann lässt Pfötchen los, von selbst. Er will ihn nicht so. Verwachsung +3, Aufmerksamkeit +2.
   - **Ist die Verwachsung danach 9 oder mehr,** lässt Pfötchen nicht sofort los. Der Held muss sich selbst losreißen (Probe). Misslingt sie, halten ihn die Gefährten, mit denen er verknotet ist: Wer Knotenstärke 2 oder mehr hat und in der Kammer ist, zieht ihn zurück. Der Spieler sieht so, was Knoten wert sind. Ist niemand da, lässt Pfötchen am Ende doch los, aber der Held behält einen Nachklang bis zum Ende des Akts.
   - **Nachklang bis zur nächsten langen Rast** (bei jeder Verwachsung): Er schwingt mit. Er lacht zum ersten Mal wirklich über einen Witz von Fitz. Er erschrickt vor einer Taube. Die Gefährten sehen ihn an wie einen Fremden.

**Was das für das Gespräch mit dem Vater bedeutet:**
- **Weggelegt:** Pfötchen weiß nichts von der Kammer (außer über Malcolm oder die Presse). Er beginnt mit „Du hast ihre Augen.“
- **Berührt:** Die Einladung kommt am nächsten Morgen. „Du warst in meiner Nähe. Ich hab dich gespürt.“
- **Gehalten:** Die Einladung kommt noch in derselben Nacht. „Du warst in meiner Kammer. Ich hab dich gehalten. Zum ersten Mal seit fünfundzwanzig Jahren.“ Und sein Angebot klingt anders: „Du hast es gefühlt. Ich kann es dir für immer geben.“ Wer gehalten hat, weiß genau, was er ablehnt, wenn er ablehnt.
