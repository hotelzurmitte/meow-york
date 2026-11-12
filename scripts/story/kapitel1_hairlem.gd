extends Node
## Kapitel 1 in Hairlem: Überfall in der Gasse, Abfahrt der Insekten, Ilse, Verlassen der Gasse.
## Figurenknoten liegen unter Generiert/Figuren und heißen wie im Prototyp (roach, ant, flyA …).

const DIALOG := preload("res://data/dialogues/kapitel1_ankunft.dialogue")
const BANDE := ["roach", "ant", "flyA", "flyB", "beetle", "wasp"]
@onready var lvl := get_parent()

func _fig(k: String) -> Node3D:
	return lvl.get_node_or_null("Generiert/Figuren/" + k) as Node3D

func _ready() -> void:
	EventBus.ereignis.connect(_ereignis)
	# Regen erst ab der Whisker Avenue (wie im Prototyp: Gasse trocken, danach Abend mit Regen)
	Einstellungen.setze("regen", GameState.flag("ch1street"))
	await get_tree().process_frame     # Level fertig aufbauen lassen
	var ilse := _fig("louse")
	if ilse:
		ilse.dialog = DIALOG; ilse.dialog_start = "ke_0"
		ilse.visible = GameState.flag("ch1robbed")
	var ueberfall: bool = GameState.flag("ueberfall") and not GameState.flag("ch1robbed")
	for k in BANDE:
		var n := _fig(k)
		if n: n.visible = ueberfall; n.ansprechbar = false
	_auto().visible = ueberfall
	if ueberfall:
		lvl.get_node("Stimmung").setze("day", 0.0)
		for g in get_tree().get_nodes_in_group("gruppe"):
			g.figur.schaue(0, -1)
		await get_tree().create_timer(0.6).timeout
		var weiter: String = GameState.get_meta("weiter_dialog", "c1_10")
		Dialog.starten(DIALOG, weiter, _fig("roach"))
	elif not GameState.flag("ch1street"):
		lvl.get_node("Stimmung").setze("day", 0.0)

## Roachs Familienwagen in der Gasse (gleiches Modell wie in der Fahrt)
var _wagen: Node3D
func _auto() -> Node3D:
	if _wagen == null:
		_wagen = (load("res://assets/world/fahrt/teile/Auto.glb") as PackedScene).instantiate()
		_wagen.name = "RoachsWagen"; lvl.add_child(_wagen)
		# Modell so verschieben, dass seine Mitte an der Stelle aus dem Prototyp steht (x 45, z 4,2)
		var box := _umfang(_wagen)
		var m := box.get_center()
		_wagen.position = Vector3(45.0 - m.x, 0, 4.2 - m.z)
	return _wagen

func _umfang(n: Node) -> AABB:
	var box := AABB(); var erst := true
	for c in n.find_children("*", "MeshInstance3D", true, false):
		var b: AABB = c.global_transform * c.get_aabb()
		box = b if erst else box.merge(b); erst = false
	return box

func _ereignis(name_: String) -> void:
	match name_:
		"insectsLeave": _insekten_gehen()

func _insekten_gehen() -> void:
	for k in ["roach", "ant"]:
		var n := _fig(k); if n: n.visible = false
	var auto := _auto()
	var tw := create_tween()
	tw.tween_property(auto, "position:x", 32.5, 2.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	tw.tween_property(auto, "rotation:y", -PI / 2, 0.3)
	tw.tween_property(auto, "position:z", 40.0, 2.0)
	tw.tween_callback(func(): auto.visible = false)
	await get_tree().create_timer(1.6).timeout
	for k in ["flyA", "flyB", "beetle", "wasp"]:
		var n := _fig(k); if n: n.visible = false
	var ilse := _fig("louse"); if ilse: ilse.visible = true
	GameState.set_flag("ch1robbed")
	GameState.quest("arrive", "Pleite in Meow-York", "Sprich mit der Kellerassel am Eingang der Gasse.")

func _process(_dt: float) -> void:
	# Wer die Gasse nach dem Überfall verlässt, steht auf der Whisker Avenue: es dämmert und beginnt zu regnen
	if GameState.flag("ch1robbed") and not GameState.flag("ch1street") and not Dialog.aktiv:
		var s := get_tree().get_first_node_in_group("spieler") as Node3D
		if s and s.global_position.x < 36.0:
			GameState.set_flag("ch1street")
			lvl.get_node("Stimmung").setze("dusk", 3.0)
			Einstellungen.setze("regen", true)
			EventBus.meldung.emit("Die Whisker Avenue. Es dämmert, und es beginnt zu regnen.")
