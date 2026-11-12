class_name Portraet
extends RefCounted
## Gesichtsausschnitte für Dialogfeld und Gruppenkarten – genau wie portrait() im Prototyp:
##  Gruppen-Rigs: fester Ausschnitt aus data/characters/gruppe.json („gesicht“)
##  alte NPC-Blätter: 22 × 22 px über dem Kopf des ersten Leerlaufbilds
##  NPC-Atlas: 24 × 24 px ab der obersten deckenden Zeile des Vorderbilds
## Die Pixel werden nur ausgeschnitten, nie verändert.

static var _cache := {}

static func fuer_figur(figur: String) -> Texture2D:
	if figur == "": return null
	if _cache.has(figur): return _cache[figur]
	var t: AtlasTexture = null
	var conf := PixelFigur.konfig(figur)
	if not conf.is_empty():
		t = AtlasTexture.new(); t.atlas = load(conf.bild); t.filter_clip = true
		if figur in ["ren", "dig", "corvin"]:
			var g: Array = GameState.gruppen_daten()[figur].gesicht
			t.region = Rect2(g[0], g[1], g[2], g[3])
		elif conf.art == "atlas":
			var f: Dictionary = PixelFigur._json(PixelFigur.ATLAS_JSON).frames.get(conf.key + "_vorne", {}).get("frame", {"x": 0, "y": 0})
			var oben := _oberste_zeile(t.atlas, Rect2i(f.x, f.y, 34, 66))
			t.region = Rect2(f.x + 5, f.y + max(0, oben - 1), 24, 24)
		else:
			var A: Array = conf.layout.get("idle", [0, 1])
			var idx := int(A[0])
			t.region = Rect2((idx % 40) * 64 + 32 - 11, 54 - 46, 22, 22)
	_cache[figur] = t
	return t

static func _oberste_zeile(tex: Texture2D, r: Rect2i) -> int:
	var img := tex.get_image()
	if img == null: return 0
	if img.is_compressed(): img.decompress()
	for y in r.size.y:
		for x in r.size.x:
			if img.get_pixel(r.position.x + x, r.position.y + y).a > 0.5: return y
	return 0

## Porträt für einen Sprechernamen aus dem Dialog: Gruppe über gruppe.json, sonst die Figur im Level.
static func fuer_sprecher(name: String, baum: SceneTree, notfall: Node = null) -> Texture2D:
	if name == "": return null
	for k in GameState.gruppen_daten():
		if GameState.gruppen_daten()[k].name == name: return fuer_figur(k)
	for n in baum.get_nodes_in_group("npcs"):
		if n.anzeigename == name or name in n.sprechernamen: return fuer_figur(n.figur)
	if notfall and "figur" in notfall and "anzeigename" in notfall and notfall.anzeigename == name:
		return fuer_figur(notfall.figur)
	return null
