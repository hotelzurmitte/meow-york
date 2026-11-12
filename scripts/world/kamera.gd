extends Node3D
## Spielkamera wie im Prototyp: folgt dem Ziel, frei drehbar.
##  Q / E oder mittlere Maustaste waagerecht: drehen
##  mittlere Maustaste senkrecht: Höhe/Neigung (isometrisch ↔ nah)
##  Mausrad: zoomen · W A S D: Kamera verschieben · Pos1: zurück zur Figur
## Die Kamera bewegt eine PhantomCamera3D; die PhantomCameraHost an der Camera3D übernimmt das.
## So können später Zwischensequenzen eigene PhantomCameras mit höherer Priorität nutzen.

@export var ziel_pfad: NodePath
@export var yaw := 0.0                 ## 0 = Kamera steht im Süden (+z) und schaut nach Norden
@export var iso := 1.0                 ## 0 nah … 1 isometrisch … 1.7 hoch
@export var zoom := 1.0
@export var steuerbar := true          ## false in Zwischensequenzen

var ziel: Node3D
var _yaw_ziel := 0.0
var _k := 1.0
var _versatz := Vector3.ZERO
var _mitte_drag := false
var _pos := Vector3.ZERO
var _blick := Vector3.ZERO
var fokus_override: Node3D = null      ## z. B. Gesprächspartner oder Fahrt

@onready var pcam = $SpielKamera

var _dof: CameraAttributesPractical
var _gespraech: Node3D = null          ## Gesprächspartner: Kamera rückt zwischen beide und etwas näher
var _zoom_faktor := 1.0

func _ready() -> void:
	add_to_group("kamera")
	ziel = get_node_or_null(ziel_pfad)
	EventBus.dialog_gestartet.connect(func(wer): _gespraech = wer if wer is Node3D else null)
	EventBus.dialog_beendet.connect(func(): _gespraech = null)
	_yaw_ziel = yaw; _k = iso
	_berechnen(0.0, true)

func _unhandled_input(e: InputEvent) -> void:
	if not steuerbar: return
	if e is InputEventMouseButton:
		if e.button_index == MOUSE_BUTTON_MIDDLE: _mitte_drag = e.pressed
		elif e.pressed and e.button_index == MOUSE_BUTTON_WHEEL_UP: zoom = clamp(zoom * 0.9, 0.45, 1.8)
		elif e.pressed and e.button_index == MOUSE_BUTTON_WHEEL_DOWN: zoom = clamp(zoom * 1.1, 0.45, 1.8)
	elif e is InputEventMouseMotion and _mitte_drag:
		_yaw_ziel -= e.relative.x * 0.006
		iso = clamp(iso + e.relative.y * 0.006, 0.0, 1.7)
	elif e is InputEventKey and e.pressed and e.keycode == KEY_HOME:
		_versatz = Vector3.ZERO

func _process(dt: float) -> void:
	if not steuerbar:
		_berechnen(dt, false); return
	var dreh := 0.0
	if Input.is_key_pressed(KEY_Q): dreh += 1.0
	if Input.is_key_pressed(KEY_E): dreh -= 1.0
	_yaw_ziel += dreh * 1.8 * dt
	# Kamera schwenken mit WASD (relativ zur Blickrichtung)
	var p := Vector2.ZERO
	if Input.is_key_pressed(KEY_W): p.y -= 1
	if Input.is_key_pressed(KEY_S): p.y += 1
	if Input.is_key_pressed(KEY_A): p.x -= 1
	if Input.is_key_pressed(KEY_D): p.x += 1
	if p != Vector2.ZERO and not get_tree().paused:
		var r := Vector3(cos(yaw), 0, -sin(yaw)); var f := Vector3(-sin(yaw), 0, -cos(yaw))
		_versatz += (r * p.x - f * p.y) * 14.0 * dt * zoom
	_berechnen(dt, false)

func _berechnen(dt: float, sofort: bool) -> void:
	yaw = _yaw_ziel if sofort else yaw + (_yaw_ziel - yaw) * min(1.0, dt * 10.0)
	_k = iso if sofort else _k + (iso - _k) * min(1.0, dt * 4.0)
	var f: Node3D = fokus_override if fokus_override else ziel
	var tp := Vector3.ZERO
	if f: tp = Vector3(f.global_position.x, f.global_position.y * 0.85, f.global_position.z) + _versatz
	# Im Gespräch: Mitte zwischen Spieler und Gegenüber, Zoom × 0,8 (DL.focus im Prototyp)
	var im_gespraech := is_instance_valid(_gespraech) and _gespraech.is_inside_tree() and fokus_override == null and ziel != null
	if im_gespraech:
		tp = (ziel.global_position + _gespraech.global_position) * 0.5; tp.y = 0
	_zoom_faktor = lerpf(_zoom_faktor, 0.8 if im_gespraech else 1.0, 1.0 if sofort else min(1.0, dt * 3.0))
	var hd := 17.5 + _k * 4.5
	var hy := 8.6 + _k * 15.4
	var off := Vector3(sin(yaw) * hd, hy, cos(yaw) * hd) * zoom * _zoom_faktor
	var a := 1.0 if sofort else 1.0 - exp(-dt * 4.0)
	_pos = _pos.lerp(tp + off, a)
	_blick = _blick.lerp(tp + Vector3(0, 2.1 - _k * 1.1, 0), a)
	if pcam:
		pcam.global_position = _pos
		pcam.look_at(_blick, Vector3.UP)
		pcam.set_fov(34.0 - _k * 4.0)
	_tiefenschaerfe()
	# Pixel-Figuren und Sprites zur Kamera ausrichten
	PixelFigur.kam_yaw = yaw
	PixelFigur.kam_neigung = min(_k, 1.3) * 0.5
	for s in get_tree().get_nodes_in_group("billboard"):
		s.rotation = Vector3(-PixelFigur.kam_neigung, yaw, 0)

## Tiefenunschärfe wie im Prototyp: scharf um den Blickpunkt (focus = Abstand Kamera–Blickpunkt,
## range = 4,8 × Zoom). Davor wird es ab focus − range/2 unscharf, dahinter ab focus + range, weich über 3,4 × range.
func _tiefenschaerfe() -> void:
	var cam := get_viewport().get_camera_3d()
	if cam == null: return
	if _dof == null or cam.attributes != _dof:
		_dof = cam.attributes as CameraAttributesPractical
		if _dof == null:
			_dof = CameraAttributesPractical.new(); cam.attributes = _dof
	var an := Einstellungen.an("unschaerfe")
	_dof.dof_blur_far_enabled = an; _dof.dof_blur_near_enabled = an
	if not an: return
	var fokus := _pos.distance_to(_blick)
	var weite := 4.8 * zoom * _zoom_faktor
	_dof.dof_blur_amount = 0.12
	_dof.dof_blur_far_distance = fokus + weite; _dof.dof_blur_far_transition = weite * 3.4
	_dof.dof_blur_near_distance = max(0.1, fokus - weite * 0.5); _dof.dof_blur_near_transition = weite * 0.9

## Bildschirmpunkt → Punkt auf dem Boden (y = 0)
func boden_unter_maus(maus: Vector2) -> Variant:
	var cam := get_viewport().get_camera_3d()
	if cam == null: return null
	var o := cam.project_ray_origin(maus); var d := cam.project_ray_normal(maus)
	if abs(d.y) < 0.0001: return null
	var t := -o.y / d.y
	return o + d * t if t > 0 else null
