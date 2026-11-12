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

var _nass := 0.0
var _boden_mats: Array = []      ## [Material, ursprüngliche Rauheit]

func _ready() -> void:
	add_to_group("stimmung")
	# Wetter gehört zur Stimmung: Regen wird zur Laufzeit angehängt (kein Szenenknoten nötig)
	if not has_node("Regen"):
		var r := Node3D.new(); r.name = "Regen"; r.set_script(load("res://scripts/wetter/regen.gd")); add_child(r)
	EventBus.einstellung_geaendert.connect(func(_n): _effekte())
	setze(voreinstellung, 0.0)
	_boden_sammeln.call_deferred()

## Nasse Straßen: Bodenmaterialien bekommen eigene Kopien, deren Rauheit mit „wet“ sinkt.
## Die Spiegelung selbst liefert SSR (nur Forward+; im Web-Export ohne Wirkung).
func _boden_sammeln() -> void:
	var lvl := get_parent()
	for n in lvl.find_children("Boden*", "", true, false):
		for mi in n.find_children("*", "MeshInstance3D", true, false):
			var m: MeshInstance3D = mi
			if m.mesh == null: continue
			for i in m.mesh.get_surface_count():
				var mat := m.get_active_material(i)
				if mat is BaseMaterial3D:
					var k: BaseMaterial3D = mat.duplicate()
					m.set_surface_override_material(i, k)
					_boden_mats.append([k, k.roughness])
	_effekte()

func _effekte() -> void:
	var e := environment
	e.glow_enabled = Einstellungen.an("bloom")
	var spiegeln := Einstellungen.an("spiegelungen") and _nass > 0.0
	e.ssr_enabled = spiegeln
	e.ssr_max_steps = 48; e.ssr_fade_in = 0.15; e.ssr_fade_out = 2.0; e.ssr_depth_tolerance = 0.3
	for b in _boden_mats:
		var mat: BaseMaterial3D = b[0]
		mat.roughness = lerpf(b[1], 0.12, _nass * 0.85) if spiegeln else b[1]
		mat.metallic_specular = lerpf(0.5, 0.75, _nass) if spiegeln else 0.5

func setze(name_: String, dauer := 0.0) -> void:
	var p: Dictionary = presets().get(name_, {})
	if p.is_empty(): return
	voreinstellung = name_
	_nass = float(p.get("wet", 0.0))
	if is_inside_tree(): _effekte()
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
