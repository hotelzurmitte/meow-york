extends WorldEnvironment
## Licht und Stimmung wie die Voreinstellungen im Prototyp („Tag“, „Abend“, „Nacht“ …).
## setze("dusk", 2.0) blendet über zwei Sekunden um.

@export var voreinstellung := "dusk"
@export var sonne_pfad: NodePath = ^"../Sonne"

static var _presets := {}

static func presets() -> Dictionary:
	if _presets.is_empty():
		_presets = JSON.parse_string(FileAccess.get_file_as_string("res://data/levels/welt_prototyp.json")).presets
	return _presets

func _ready() -> void:
	setze(voreinstellung, 0.0)

func setze(name_: String, dauer := 0.0) -> void:
	var p: Dictionary = presets().get(name_, {})
	if p.is_empty(): return
	voreinstellung = name_
	var e := environment
	var sky := Color(p.sky); var gnd := Color(p.gnd)
	var sonne := get_node_or_null(sonne_pfad) as DirectionalLight3D
	var ziel := {"background_color": sky.darkened(0.35), "ambient_light_color": sky.lerp(gnd, 0.35), "ambient_light_energy": float(p.hemiI) * 0.7,
		"fog_light_color": Color(p.fog), "fog_density": float(p.fogD) * 0.6, "tonemap_exposure": float(p.exp), "glow_intensity": float(p.bloom)}
	if dauer <= 0.0:
		for k in ziel: e.set(k, ziel[k])
		if sonne:
			sonne.light_color = Color(p.sun); sonne.light_energy = float(p.sunI) * 0.3
			var d: Array = p.dir; sonne.look_at_from_position(Vector3(d[0], d[1], d[2]) * 50.0, Vector3.ZERO, Vector3.UP)
		return
	var tw := create_tween().set_parallel(true)
	for k in ziel: tw.tween_property(e, k, ziel[k], dauer)
	if sonne:
		tw.tween_property(sonne, "light_color", Color(p.sun), dauer)
		tw.tween_property(sonne, "light_energy", float(p.sunI) * 0.3, dauer)
