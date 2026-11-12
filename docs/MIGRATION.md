# Migrationsplan: Three.js-Prototyp → Godot 4

Stand: 12.11.2026 · Engine: Godot 4.7.1 · Sprache: GDScript

## 1. Ausgangslage

Der Prototyp ist ein Browserspiel in Three.js. Er läuft und enthält das komplette erste Kapitel. Er besteht aus 36 JavaScript-Dateien (rund 690 KB), die zu einer einzigen HTML-Datei zusammengebaut werden. Die Dateien erweitern sich gegenseitig durch nachträgliches Überschreiben: Die Bild-Zeichenfunktion ist zehnmal überlagert, Dialoge werden in drei Dateien nachträglich umgebogen. Für einen Prototyp war das schnell. Als Fundament für ein fertiges Spiel trägt es nicht.

**Entscheidung:** Der Prototyp wird nicht weiterentwickelt, was Technik und Grafik angeht. Er bleibt als **Story-Sandbox** erhalten, um Dialoge und Abläufe schnell durchzuspielen, bis Kapitel 1 in Godot steht.

## 2. Bestandsaufnahme

### Wird übernommen (Inhalte und Grafiken)

| Was | Wie |
|---|---|
| NPC-Atlas (22 Figuren × 4 Richtungen) | unverändert, liegt bereits unter `assets/characters/npcs/` |
| Ren, Big Dig, Corvin (Pixel-Rigs, 5 Ansichten × 40 Frames) | PNG + Layout-JSON unverändert übernehmen |
| Alte NPC-Sprites (Nugget, Adikatz, Don Orango, Insekten …) | übergangsweise übernehmen, bis eigene Sprites kommen |
| Dialoge (296 Knoten), Quests, Flags | per Skript nach JSON exportieren (siehe 4.2). Bedingungen und Effekte stehen im Prototyp als JavaScript-Funktionen; sie werden in eine kleine, lesbare Regelsprache übersetzt, Sonderfälle von Hand |
| Kartenaufteilung Hairlem, Dächer, Untergrund | aus dem Lageplan (`hairlem.map4`) als Layout-JSON für den Level-Generator |
| Häuser-Look (Cartoon-Kit: oben breiter, getönte Umrisse) | Generator in GDScript neu schreiben; die Pixeltexturen (Wände, Fenster, Dächer) aus dem Prototyp als PNG exportieren |

### Wird neu geschrieben (Regeln und Design stehen schon)

Bewegung und Gruppensteuerung, Rundenkampf mit Timing (Sea-of-Stars-Prinzip), Schleichen und Wachen, Kamera, Durchsicht durch Wände, Speichern, Dialog-Oberfläche, Questlog, Inventar, Rasten.

### Wird verworfen

Eigene Nachbearbeitungseffekte (SSR, Bloom, Unschärfe – Godot hat das eingebaut), Licht-Pool, Qualitätsautomatik und Bildratenbremse (Godot regelt das selbst), alle Patch-Dateien (`dialog_fix`, `logic_fix` …).

## 3. Zielarchitektur

### 3.1 Ordner

```
assets/      Grafiken, Modelle, Audio – nur wie geliefert
data/        Inhalte: dialogues/, quests/, characters/, items/, levels/
scenes/      characters/, world/ (Level, Häuser, Türen), ui/, tests/
scripts/
  core/        GameState, EventBus, SaveSystem (Autoloads)
  characters/  Figur, Sprite-Richtungen, Bewegung, Gruppe
  world/       Generator, Türen, Interaktion, Durchsicht
  dialogue/    Dialog-Laufzeit + Regelsprache
  quests/      Questverwaltung
  combat/      Rundenkampf (Phase 3)
  stealth/     Wachen, Sichtkegel (Phase 3)
  ui/          Oberflächen
tools/       Export, Prüfskripte, Prototyp-Konverter
docs/        dieses Dokument, Entscheidungen
```

### 3.2 Systeme und wie sie sprechen

- **Autoloads** (überall erreichbar, aber schmal):
  - `GameState`: Flags, Geld, Gruppe, Ansehen, Tag. Einzige Quelle für den Spielzustand.
  - `EventBus`: nur Signale, keine Logik. Beispiele: `dialogue_started`, `flag_changed`, `quest_updated`, `area_entered`.
  - `SaveSystem`: schreibt `GameState` als versioniertes JSON und kann alte Stände hochrechnen.
- **Systeme kennen sich nicht gegenseitig.** Der Dialog setzt ein Flag über `GameState`, die Questverwaltung hört über `EventBus` mit. So lässt sich jedes System einzeln testen und austauschen.
- **Szenen statt Monolithen:** Figur, NPC, Tür, Haus und Interaktionspunkt sind jeweils eigene Szenen, die man im Editor in ein Level zieht.

### 3.3 Darstellung (Hybrid 3D + Pixel)

| Entscheidung | Begründung | Erwogene Alternative |
|---|---|---|
| **Orthografische Kamera**, fester Iso-Winkel, Zoom in festen Stufen, Drehung in 90°-Schritten | Pixel bleiben gleich groß und scharf, das ist deine Regel „nur ganzzahlig skalieren“. Perspektive ginge nur mit Unschärfe | Perspektive wie im Prototyp: schöner Tiefeneindruck, aber krumme Pixelgrößen |
| **Sprite3D** mit Nearest-Filter, Alpha-Schnitt, Billboard nur um die Hochachse | Der Tiefenpuffer sortiert Figuren korrekt gegen Wände und andere Figuren. Alpha-Schnitt statt weicher Transparenz, sonst sortiert es falsch | AnimatedSprite3D: gut für feste Animationen, aber die Richtungswahl (8 bzw. 4 Ansichten, Spiegeln) ist mit eigenem Code klarer |
| **Pivot unten mittig**, Sprite-Unterkante = Fußpunkt | wie für den Atlas festgelegt | – |
| **Kollision** als kleine Kapsel an den Füßen (`CharacterBody3D`) | deine Regel 14 × 6 px statt ganzer Zelle | – |
| **Durchsicht** (BG3-Kreis) als Shader auf den Gebäudematerialien, die Figuren-Positionen werden pro Bild hineingegeben | im Prototyp schon bewährt; in Godot sauberer, weil ein Shader für alle Häuser gilt | Häuser ausblenden: grober, man verliert den Raum |
| **Pixelraster**: Figuren-Positionen auf ganze Sprite-Pixel runden | ruhigere Pixel beim Laufen | – |

**Maßstab:** Alle Atlas-NPCs teilen sich einen festen Wert (Pixel pro Meter). Ren hat im Prototyp einen feineren Sprite als deine 32 × 80-Version. Bis diese kommt, gilt dasselbe Größenverhältnis wie im Prototyp. Danach haben alle denselben Maßstab, echtes 1:1.

### 3.4 Level-Workflow (du baust, ich generiere)

Jedes Level hat zwei Bereiche:

```
Level (Node3D)
├── Generiert      ← gehört dem Generator, wird beim Neu-Erzeugen ersetzt
└── Handgebaut     ← gehört dir, wird nie angefasst
```

- Den Generator startest du im Editor über einen Knopf am Level (Inspector: „Neu generieren“). Er baut Straßen, Gehwege und Häuser aus `data/levels/<name>.json`.
- Willst du ein generiertes Haus behalten und ändern, ziehst du es von „Generiert“ nach „Handgebaut“. Ab dann gehört es dir.
- Der Generator ist deterministisch: gleicher Startwert, gleiches Ergebnis. Mit einem anderen Startwert bekommst du eine neue Variante.

## 4. Datenformate

### 4.1 Figuren (`data/characters/npcs.json`)

```json
{ "id": "maria", "anzeigename": "Maria", "spriteKey": "Otter", "richtung": "vorne",
  "level": "cuckoos_nest", "position": [99.0, 1.05], "dialog": "maria", "wandern": [97.6, 102.4] }
```

### 4.2 Dialoge (`data/dialogues/<datei>.json`)

```json
{ "id": "ke.0", "sprecher": "louse",
  "text": "Papa Roach. Jeden Tag ein paar Neue.",
  "effekte": ["flag ke"],
  "optionen": [
    { "text": "Wo bunkert Roach sein Geld?", "wenn": "!quest garage", "weiter": "ke.gar" },
    { "text": "Hier verschwinden Leute, oder?", "einmal": true,
      "probe": { "fertigkeit": "Straßenwissen", "sg": 13, "wer": "corvin" },
      "erfolg": "ke.4", "misserfolg": "ke.4f" } ] }
```

**Regelsprache**, absichtlich klein:
- **Bedingungen:** `flag x`, `!flag x`, `flag x = wert`, `geld >= 20`, `quest garage`, `mitglied dig`, verknüpft mit `und` / `oder`.
- **Effekte:** `flag x`, `flag x = 0`, `geld +15`, `ansehen insekten +1`, `zuneigung dig -1`, `quest garage "Text"`, `hinweis "…"`.

Was sich nicht in Regeln fassen lässt (zum Beispiel Kampf starten oder eine Zwischensequenz), wird als benanntes **Ereignis** aufgerufen (`"ereignis": "kampf_antonia"`). Das Ereignis ist dann Code, aber an genau einer Stelle.

### 4.3 Spielstand

```json
{ "version": 1, "tag": 2, "geld": 40, "flags": {}, "quests": {}, "gruppe": [], "level": "hairlem", "position": [0,0] }
```

Jede neue Version bringt eine Funktion mit, die den Stand der Vorgängerversion hochrechnet.

## 5. Risiken

| Risiko | Gegenmaßnahme |
|---|---|
| Sortierfehler bei halbtransparenten Pixeln (Rauch, Glas) | Figuren nur mit Alpha-Schnitt; Halbtransparentes als eigene Ebene, sparsam |
| Sprite steht schräg zur Wand, wenn die Kamera dreht | Drehung nur in 90°-Schritten; Billboard nur um die Hochachse |
| Pixel flimmern beim Laufen und Scrollen | Kamera und Figuren auf das Pixelraster rasten |
| Schatten von flachen Sprites wirken dünn | zusätzlich ein weicher Bodenschatten (Blob) unter jeder Figur |
| Web-Vorschau sieht anders aus als der PC (einfacherer Renderer) | maßgeblich sind Screenshots mit dem Vulkan-Renderer und der Windows-Build |
| Konvertierung der Dialoge: JavaScript-Bedingungen sind nicht alle übersetzbar | Konverter übersetzt die häufigen Muster, markiert den Rest mit `TODO`. Die markierten Stellen gehe ich von Hand durch |
| Wir bearbeiten gleichzeitig dieselbe Szene | Regel: vor dem Arbeiten Pull; Level-Szenen bearbeitest nur du, ich ändere Generator und Daten |

## 6. Phasen

1. **Vertical Slice** (jetzt): ein Stück Whisker Avenue mit generierten Häusern, Ren mit 8 Richtungen und Laufanimation, Kollision, Verdeckung und Durchsicht, eine Tür in einen Innenraum, ein NPC mit Dialog aus JSON, Windows-Build und Web-Vorschau.
2. **Kapitel-1-Gerüst:** Dialog-Konverter, alle Kapitel-1-Dialoge und Quests, Gruppe (Dig, Corvin folgen), Speichern, Hairlem komplett generiert, Bar innen.
3. **Systeme:** Rundenkampf mit Timing, Schleichen, Questlog, Inventar, Rasten.
4. **Kapitel 1 spielbar**, danach Branx und Szene 5.
5. **Steam:** GodotSteam, Achievements, Cloud-Speicherstände – erst, wenn das Spiel lokal stabil läuft.
