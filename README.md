# Meow-York

Isometrisches 2,5D-Rollenspiel in Godot 4: 3D-Welt, 2D-Pixel-Charaktere.

## Einrichten (Windows)

1. **Godot 4.7.1, Standard-Version** (nicht .NET) von godotengine.org/download/windows. Entpacken und die .exe starten.
2. **GitHub Desktop** installieren, mit deinem GitHub-Konto anmelden.
3. In GitHub Desktop: *File → Clone repository → hotelzurmitte/meow-york*.
4. In Godot: *Importieren* → den geklonten Ordner wählen → `project.godot` öffnen.
5. **F5** startet das Spiel.

## Zusammenarbeit

- Claude lädt Änderungen ins Repository hoch. Du holst sie in GitHub Desktop mit **Fetch origin → Pull origin**.
- Wenn du im Editor etwas änderst (zum Beispiel ein Level): In GitHub Desktop eine kurze Beschreibung eintippen, **Commit to main**, dann **Push origin**.
- Vor dem Arbeiten immer erst **Pull**, damit ihr nicht gleichzeitig an verschiedenen Ständen arbeitet.

## Ordner

| Ordner | Inhalt |
|---|---|
| `assets/` | Grafiken, 3D-Modelle, Audio – unverändert, wie geliefert |
| `scenes/` | Godot-Szenen (Level, Figuren, Oberfläche) |
| `scripts/` | GDScript-Code, nach Systemen getrennt |
| `data/` | Spielinhalte als Daten: Dialoge, Quests, Figuren, Gegenstände |
| `tools/` | Hilfsskripte für Export und Vorschau |
| `docs/` | Architektur- und Entscheidungsdokumente |
