@tool
extends Node3D
## Eine Nicht-Spieler-Figur. Die Figur (Sprite) wird über `figur` gewählt, z. B. "atlas:Otter" oder "npc:louse".
## Beim Ansprechen dreht sie sich zum Spieler und danach zurück in ihre Standardrichtung.

@export var anzeigename := "NPC"
@export var figur := "atlas:Fuchs":
	set(v):
		figur = v
		if has_node("Figur"): $Figur.figur = v
@export var blick := Vector2(0, 1):
	set(v):
		blick = v
		if has_node("Figur"): $Figur.blick = v
@export var dialog: DialogueResource
@export var dialog_start := ""
## Sprüche, wenn es keinen Dialog gibt (einer davon zufällig)
@export var sprueche: PackedStringArray = []
@export var ansprechbar := true:
	set(v):
		ansprechbar = v
		if is_inside_tree() and not Engine.is_editor_hint():
			if v: add_to_group("interaktiv")
			elif is_in_group("interaktiv"): remove_from_group("interaktiv")

var _redet := false

func _ready() -> void:
	if not has_node("Figur"):
		var f := PixelFigur.new(); f.name = "Figur"; add_child(f)
		if Engine.is_editor_hint() and get_tree().edited_scene_root: f.owner = get_tree().edited_scene_root
	$Figur.figur = figur; $Figur.blick = blick
	if Engine.is_editor_hint(): return
	if ansprechbar: add_to_group("interaktiv")
	EventBus.dialog_beendet.connect(_dialog_ende)

var hinweis: String:
	get: return "Sprechen mit " + anzeigename

func benutzen(wer: Node3D) -> void:
	_redet = true
	$Figur.schaue(wer.global_position.x - global_position.x, wer.global_position.z - global_position.z)
	if dialog:
		Dialog.starten(dialog, dialog_start, self)
	elif sprueche.size() > 0:
		EventBus.meldung.emit("%s: %s" % [anzeigename, sprueche[randi() % sprueche.size()]])
		await get_tree().create_timer(2.5).timeout
		_dialog_ende()

func _dialog_ende() -> void:
	if _redet:
		_redet = false
		$Figur.blick = blick

func _process(dt: float) -> void:
	if Engine.is_editor_hint(): return
	if _redet:
		var s := get_tree().get_first_node_in_group("spieler") as Node3D
		if s: $Figur.schaue(s.global_position.x - global_position.x, s.global_position.z - global_position.z)
