# Arbeitsregeln für dieses Repository

Sprache: Kommentare, Commit-Nachrichten und Dokumente auf Deutsch.

## Engine
- Godot 4.7.1, GDScript. Renderer Forward+ (Desktop), Compatibility im Web-Export.
- Headless prüfen: `godot --headless --path . --import --quit`
- Screenshot einer Szene: `xvfb-run -a -s "-screen 0 1280x720x24" godot --rendering-driver vulkan --path . <szene> -- --shot`
- Web-Vorschau: `godot --headless --path . --export-release "Web" build/web/index.html && python3 tools/web_pack.py build/web`
- Windows-Build: `godot --headless --path . --export-release "Windows" build/win/MeowYork.exe`

## Grafiken
- Gelieferte Pixelart nie verändern: nicht neu zeichnen, umfärben, skalieren oder „verbessern“.
- Pixel-Sprites: Nearest-Filter, keine Mipmaps, Pivot unten mittig (Füße = Position), Kollision nur an den Füßen.
- NPC-Atlas: `assets/characters/npcs/atlas_npcs.png/.json`, Zellen 34 × 66, Richtungen vorne/links/rechts/hinten.

## Code
- Keine Monolithen: ein System pro Ordner unter `scripts/`, Kommunikation über Signale.
- Inhalte (Dialoge, Quests, Figuren, Gegenstände) als Daten in `data/`, nicht im Code.
- Vom Nutzer im Editor gebaute Level nicht überschreiben. Generatoren erzeugen nur eigene Knoten und lassen von Hand Geändertes in Ruhe.
- Spielstände versioniert.
