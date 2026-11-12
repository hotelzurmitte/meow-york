extends Node3D
## Regen wie im Prototyp (fx.js): ~900 bläuliche Striche, die mit der Kamera mitwandern,
## dazu Ringe auf dem Boden, wo Tropfen aufschlagen. An/aus über Einstellungen.regen.

const ANZAHL := 900

var _striche: CPUParticles3D
var _ringe: CPUParticles3D

func _ready() -> void:
	_striche = CPUParticles3D.new(); _striche.name = "Striche"
	_striche.amount = ANZAHL; _striche.lifetime = 0.75; _striche.preprocess = 0.75
	_striche.local_coords = false; _striche.visibility_aabb = AABB(Vector3(-25, -12, -25), Vector3(50, 30, 50))
	_striche.emission_shape = CPUParticles3D.EMISSION_SHAPE_BOX; _striche.emission_box_extents = Vector3(18, 8, 15)
	_striche.direction = Vector3(0.06, -1, 0.03); _striche.spread = 2.0; _striche.gravity = Vector3.ZERO
	_striche.initial_velocity_min = 18.0; _striche.initial_velocity_max = 26.0
	var q := QuadMesh.new(); q.size = Vector2(0.022, 0.6)
	var m := StandardMaterial3D.new()
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED; m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	m.blend_mode = BaseMaterial3D.BLEND_MODE_ADD; m.no_depth_test = false; m.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_DISABLED
	m.albedo_color = Color(0.55, 0.62, 0.8, 0.35)
	m.billboard_mode = BaseMaterial3D.BILLBOARD_FIXED_Y; m.billboard_keep_scale = true
	q.material = m; _striche.mesh = q
	_striche.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(_striche)
	# Aufschlagringe
	_ringe = CPUParticles3D.new(); _ringe.name = "Ringe"
	_ringe.amount = 48; _ringe.lifetime = 0.55; _ringe.local_coords = false
	_ringe.visibility_aabb = AABB(Vector3(-25, -2, -25), Vector3(50, 4, 50))
	_ringe.emission_shape = CPUParticles3D.EMISSION_SHAPE_BOX; _ringe.emission_box_extents = Vector3(14, 0, 11)
	_ringe.gravity = Vector3.ZERO; _ringe.initial_velocity_min = 0; _ringe.initial_velocity_max = 0
	_ringe.scale_amount_min = 0.25; _ringe.scale_amount_max = 0.4
	var sk := Curve.new(); sk.add_point(Vector2(0, 0.35)); sk.add_point(Vector2(1, 1.0)); _ringe.scale_amount_curve = sk
	var fr := Gradient.new(); fr.set_color(0, Color(1, 1, 1, 0.55)); fr.set_color(1, Color(1, 1, 1, 0)); _ringe.color_ramp = fr
	var pm := PlaneMesh.new(); pm.size = Vector2(1, 1)
	var rm := StandardMaterial3D.new()
	rm.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED; rm.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	rm.blend_mode = BaseMaterial3D.BLEND_MODE_ADD; rm.vertex_color_use_as_albedo = true; rm.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_DISABLED
	rm.albedo_color = Color(0.5, 0.6, 0.8)
	var g := GradientTexture2D.new(); g.fill = GradientTexture2D.FILL_RADIAL; g.fill_from = Vector2(0.5, 0.5); g.fill_to = Vector2(1, 0.5)
	g.width = 32; g.height = 32
	var gr := Gradient.new(); gr.offsets = PackedFloat32Array([0.0, 0.66, 0.78, 0.9, 1.0])
	gr.colors = PackedColorArray([Color(1, 1, 1, 0), Color(1, 1, 1, 0), Color(1, 1, 1, 1), Color(1, 1, 1, 0), Color(1, 1, 1, 0)])
	g.gradient = gr; rm.albedo_texture = g
	pm.material = rm; _ringe.mesh = pm
	_ringe.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(_ringe)
	EventBus.einstellung_geaendert.connect(func(n): if n == "regen": _schalten())
	_schalten()

func _schalten() -> void:
	var an := Einstellungen.an("regen")
	_striche.emitting = an; _ringe.emitting = an
	visible = an

func _process(_dt: float) -> void:
	if not visible: return
	# mit dem Blickpunkt der Kamera mitwandern (wie rain.position im Prototyp)
	var kam := get_tree().get_first_node_in_group("kamera")
	var f: Node3D = kam.ziel if kam and kam.ziel else null
	if f == null: return
	var p := f.global_position
	_striche.global_position = Vector3(p.x, 8.0, p.z - 2.0)
	_ringe.global_position = Vector3(p.x, 0.04, p.z - 1.0)
