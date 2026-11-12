extends Node3D
## Kapitel 1 · Szene 1: Fahrt im Familienwagen von Papa Roach (Laufband-Kulisse wie im Prototyp).
## Die Kulissen fahren am stehenden Auto vorbei; Brücke und Bar tauchen auf, wenn der Dialog es verlangt.

const DIALOG := preload("res://data/dialogues/kapitel1_ankunft.dialogue")
var tempo := 11.0
var _strasse_mat: BaseMaterial3D
var _zeit := 0.0

func _ready() -> void:
	GameState.set_flag("ch1")
	GameState.geld = 120; EventBus.geld_geaendert.emit(120)
	for n in $Kulissen.get_children():
		if n.has_meta("stueck"): n.visible = false
	_strasse_mat = _finde_material($Kulissen/Strasse)
	EventBus.ereignis.connect(_ereignis)
	$HUD.zeige_ueberspringen(true)
	$HUD.ueberspringen.connect(_ueberspringen)
	await get_tree().create_timer(4.6).timeout
	$HUD.kapitelkarte("Die Ankunft", "KAPITEL 1 · SZENE 1")
	await get_tree().create_timer(3.4).timeout
	Dialog.starten(DIALOG, "c1_0", null)

func _finde_material(n: Node) -> BaseMaterial3D:
	if n is MeshInstance3D and n.mesh:
		var m = n.mesh.surface_get_material(0)
		if m is BaseMaterial3D:
			m = m.duplicate(); n.set_surface_override_material(0, m); return m
	for c in n.get_children():
		var r := _finde_material(c)
		if r: return r
	return null

func _process(dt: float) -> void:
	_zeit += dt
	if _strasse_mat: _strasse_mat.uv1_offset.x += tempo * dt / 8.0
	for n in $Kulissen.get_children():
		if n.has_meta("span"):
			var span: float = n.get_meta("span"); var k: float = n.get_meta("k")
			n.position.x -= tempo * k * dt
			if n.position.x + float(n.get_meta("basis_x", 0.0)) < -span / 2.0 - 10.0: n.position.x += span
		elif n.has_meta("stueck") and n.visible:
			n.position.x -= tempo * dt
			if n.position.x + float(n.get_meta("start_x", 0.0)) < -90.0: n.visible = false
	var auto := $Kulissen/Auto as Node3D
	auto.position.y = abs(sin(_zeit * 9.0)) * 0.03

func _ereignis(name_: String) -> void:
	match name_:
		"ridePiece:bridge": _stueck("Bruecke")
		"ridePiece:bar": _stueck("Bar")
		"fahrt:abbiegen": tempo = 4.0
		"alleyCut": _in_die_gasse()

func _stueck(n: String) -> void:
	var s := $Kulissen.get_node(n) as Node3D
	s.position.x = 0.0; s.visible = true

func _in_die_gasse() -> void:
	# Der Dialog geht in der Gasse (Hairlem) weiter
	GameState.set_flag("ueberfall")
	GameState.naechster_spawn = "Gasse"
	GameState.set_meta("weiter_dialog", "c1_10")
	await $HUD.abblenden()
	Dialog.abbrechen()
	get_tree().change_scene_to_file("res://scenes/world/hairlem.tscn")

func _ueberspringen() -> void:
	Dialog.abbrechen()
	GameState.geld = 0; GameState.set_flag("robbed", 120); GameState.set_flag("ch1robbed"); GameState.set_flag("ch1street")
	GameState.quest("arrive", "Pleite in Meow-York", "Geht ins Cuckoo's Nest an der Whisker Avenue und fragt nach Arbeit.")
	GameState.naechster_spawn = "Strasse"
	get_tree().change_scene_to_file("res://scenes/world/hairlem.tscn")
