# Akt 1: Papier-Spieltests nach Spielstil

*Stand 13.11.2026 · Grundlage: `akt1_szenen.md` · Test-Spielstände: `data/zustaende/szenarien/11_…` bis `15_…`*

Fünf Spieler gehen Akt 1 durch. Für jeden wird festgehalten: was er weiß, was er entscheidet, wer noch da ist, welche Folgen er sieht, ob irgendwo Wissen vorausgesetzt wird, das er nicht haben kann, und ob das Ende trotzdem trägt. Die Spielstände am Ende jedes Laufs prüft `tools/pruefe_zustaende.tscn` auf Widersprüche (Werte und Voraussetzungen im Register).

Laden zum Ausprobieren: `-- --szenario=11_akt1_ende_ehrlich` (usw.)

---

## 1 · Der ehrliche Spieler
*Prüft: Funktioniert Vertrauen, ohne dass der Spieler trickst?*

**Weg:** Gibt sich bei Odile als Bruder zu erkennen, bekommt Junos Sachen zurück und die Einladung zur Abendandacht. Nimmt Hummels Schicht an, geht als Kellner in Zimmer 7, beschattet Ansgar mit Corvin. Bringt den Ghettoblaster zu den Cats zurück. Sieht die Kassette beim Battle offen (Probe), Adikatz hat es gesehen und kommt nachts. Sie hören das Band zusammen. Rettet Mimi. Sagt Malcolm die Wahrheit über die Kassette. Beim Auftrag stellt er Nugget mit Band und Beobachtungen bloß.

| Frage | Ergebnis |
| --- | --- |
| Was weiß er? | Juno ist freiwillig gegangen, die Mission holt Kinder, Riff hat Malcolm und eine Fremde aufgenommen. Malcolm gibt beiden Gangs Geld, aber Corvin verteidigt ihn, und Junos Stimme sagt: „Der meint jedes Wort.“ |
| Wer ist da? | Big Dig, Corvin, Shiner. Knuckles bleibt in der Werkstatt, die Nomapes sind nicht feindlich (Waffenstillstand) |
| Sichtbare Folgen | Odile warm, Adikatz' Vertrauen, Mimi bei Big Dig, die Cats respektieren ihn |
| Unmögliches Wissen? | **Gefunden und behoben:** Malcolm fragte immer nach der Kassette, auch wenn niemand sie gesehen hatte. Jetzt nur, wenn er davon wissen kann |
| Trägt das Ende? | Ja. Die Predigt wirkt am stärksten, weil er Malcolm vertrauen möchte und trotzdem einen kleinen Riss hat |

**Schwachstelle:** Ehrlichkeit kostet ihn beim Kassetten-Ärger mit Nugget nichts, weil Adikatz sie zuerst gesehen hat. Hätte Nugget sie gesehen, hätte der ehrliche Spieler kaum Wege (Bluffen ist Lügen). **Lösung, schon da:** Hummel versteckt ihn, wenn er die Schicht gemacht hat. Ehrlichkeit wird über Vertrauen belohnt, nicht über Proben.

---

## 2 · Der Opportunist
*Prüft: Sind kurzfristige Vorteile und langfristige Folgen erkennbar?*

**Weg:** Täuscht Odile als Bekehrungswilliger (Aufnahme) und stiehlt ihren Schlüssel. Lehnt die Schicht ab, stiehlt den Zimmerschlüssel, schreibt die Liste nur ab. Erpresst Roach als Fahrer. Lässt Knuckles eine Attrappe des Ghettoblasters bauen und kassiert bei Nugget. Findet das Geheimfach, Nugget merkt es. Nimmt Malcolms Geld und verkauft die Kassette ungehört an Nugget. Nimmt beide Aufträge an und lässt die Cats fallen.

| Frage | Ergebnis |
| --- | --- |
| Was weiß er? | Wenig über Malcolm (er hat das Band nie gehört). Viel über Wege und Preise |
| Wer ist da? | Big Dig, Corvin, Knuckles. Shiner ist nicht verloren, nur nicht dabei |
| Sichtbare Folgen in Akt 1 | **Gefunden und behoben:** Langfristige Folgen kamen erst in Akt 2. Neu: Nugget schmeißt Runden im Nest, Hummel fragt „Von wem hat der das Geld?“ Der Spieler sieht sofort, dass sein Verkauf etwas in Gang gesetzt hat |
| Unmögliches Wissen? | Keins |
| Trägt das Ende? | Ja, aber kühler. Für ihn ist die Predigt ein Rätsel ohne Kassette. Dass Malcolm in Akt 2 weiß, dass das Band existierte, ist eine Folge, die er selbst verursacht hat |

---

## 3 · Der gewalttätige Spieler
*Prüft: Reagiert die Welt glaubwürdig auf Eskalation?*

**Weg:** Lässt die Ordenshelfer einschüchtern (Odile verletzt), bricht in die Mission ein, lässt Big Dig Ansgar verprügeln, stellt Roach bloß, stiehlt den Ghettoblaster, verpasst die Schicht. Führt den Auftrag aus und tötet Adikatz.

| Frage | Ergebnis |
| --- | --- |
| Was weiß er? | Genug für das Ende: Zettel, Aufnahmebuch, Kassette |
| Wer ist da? | Big Dig, Corvin, Knuckles. **Shiner für immer verloren**, die Cats bis Akt 4 feindlich |
| Sichtbare Folgen | `orden_wachsam` 4: Streife der Garde, Ansgar beobachtet ihn im Nest, eine Schwester lädt ihn in die Mission ein. Mimi meidet Big Dig. Hummel redet nicht mit ihm |
| Unmögliches Wissen? | **Gefunden und behoben:** Bei `orden_wachsam` 4 lud ihn Odile ein, obwohl sie verletzt war. Jetzt kommt eine fremde Schwester |
| Trägt das Ende? | Ja. Die Predigt trifft hier am härtesten: Er hat selbst Gewalt gesät, und ein anderer erntet die Dankbarkeit |

**Prüfung des Verlusts:** Shiner warnt vorher selbst („Dann kletter ich ab morgen allein“), wenn er sie kennt, sonst Big Dig. Der Verlust ist gewählt.

---

## 4 · Der neugierige Ermittler
*Prüft: Werden Hinweise belohnt, ohne Pflichtwissen zu verstecken?*

**Weg:** Alles. Odiles Moment mit Corvin, die Dächer, Vincenzos Foto, die Tauben, Roachs Buchführung, das Geheimfach selbst gefunden, die Kassette gehört, die teuren Schuhe bemerkt. Nugget bloßgestellt.

| Frage | Ergebnis |
| --- | --- |
| Was weiß er? | Alles, was Akt 1 hergibt. Über Malcolm: Er kauft Papiere, gibt beiden Gangs Geld, spricht mit einer Fremden über „etwas da unten“. Jeder Punkt hat eine gute Erklärung |
| Wer ist da? | Big Dig, Corvin, Shiner |
| Sichtbare Folgen | Corvins Pinnwand voll, Big Dig und Corvin streiten über Malcolm, `malcolm_risse` höchstens 2 |
| Unmögliches Wissen? | Keins. Riskant war, dass der Ermittler Malcolm zu früh durchschaut. **Geprüft:** Die Kassette, die Schuhe und das Geld zusammen ergeben einen Verdacht, aber keinen Beweis. Der junge Kater erklärt die Papiere als Schutz, Corvin verteidigt ihn, Junos Stimme bestätigt seine Ehrlichkeit. Der Ermittler bleibt im Zweifel, wie gewollt |
| Trägt das Ende? | Ja, am reichsten. Er geht mit der Frage „Wer ist Malcolm?“ in Akt 2, nicht mit der Antwort |

---

## 5 · Der Spieler, der alles verpasst
*Prüft: Bleibt die Hauptgeschichte verständlich, wenn optionale Inhalte fehlen?*

**Weg:** Nach dem ersten Tag streift er durch Hairlem, redet mit ein paar Leuten, beendet keine Quest. Betritt die Mission nie, findet den Zettel nicht, sieht die Kassette nicht.

| Frage | Ergebnis |
| --- | --- |
| Was weiß er? | Aus dem Prolog: Juno, der Orden, Roach. Auf der Straße: Plakate, Grimm, Steckbrief |
| Wer ist da? | Big Dig und Corvin stoßen bei der Schlägerei dazu, eine Gang über die Wahl beim Auftrag |
| Sichtbare Folgen | Kassette landet bei Nugget, also bei Malcolm. Malcolm ist für ihn nur der Wohltäter |
| Unmögliches Wissen? | Keins |
| Trägt das Ende? | **Gefunden und behoben, zwei Lücken:** (1) Die Schlägerei kam nur nach Quest 4 oder dem Zettel, ein Verpasser hätte ewig warten können. Jetzt spätestens an Tag 7. (2) Wer den Zettel nie fand, wusste am Ende nicht, dass Juno nach unten gegangen ist. Jetzt zeigt die Predigt im Fernsehen den Aufbruch der Expedition und Juno für zwei Sekunden. Das Ziel ist klar, und die Szene ist für alle anderen eine Bestätigung |

---

## Zusammenfassung

| Fund | Behoben in |
| --- | --- |
| Malcolm fragt nach der Kassette, ohne davon wissen zu können | Malcolm-Szene |
| Corvin im Nest, obwohl er Hausverbot hat (Morgen danach) | Fadenlos |
| Odile lädt ein, obwohl sie verletzt ist (`orden_wachsam` 4) | Druck von außen |
| Kein Endpunkt für die Schlägerei | Auslöser der Schlägerei (Tag 7) |
| Verpasser weiß am Ende nicht, wohin Juno ging | Predigt (Juno im Fernsehen) |
| Opportunist sieht in Akt 1 keine Folge seines Verkaufs | Ärger um die Kassette (Nugget schmeißt Runden) |
| Hummels Kaffee, obwohl er nach der verpassten Schicht schweigt | Fadenlos (das Schweigen bleibt, der Kaffee kommt trotzdem) |
| Mimis Vertrauen hatte keine Variable | Register: `mimi_vertraut` |
| Prototyp-Flag `auftrag` kollidierte mit der neuen Variable | Register: `auftrag_ausgang` |

**Neue Regeln im Register, die das Prüfwerkzeug jetzt durchsetzt:** Einladung in die Mission nur mit gewonnener Odile; Kassette gehört nur, wenn sie nicht im Gerät oder bei Nugget ist; „gesehen von“ nur, wenn sie herausgefallen ist; Gang-Wahl nur mit Ausgang des Auftrags; Zimmer 7 als Kellner nur mit Schicht, durch den Keller und Ansgar verprügeln nur mit Big Dig, beschatten nur mit Corvin; Junos Stimme ab Stufe 2 nicht in Akt 1. Drei ältere Szenarien hatten eine Gang-Wahl ohne Auftrag und wurden ergänzt.
