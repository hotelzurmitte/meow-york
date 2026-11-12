@tool
extends EditorScenePostImport
# Nach dem Import einer aus dem Prototyp exportierten Weltdatei (GLB):
# Pixeltexturen scharf (Nearest, keine Mipmaps), Umriss-Hüllen ohne Schatten.

func _post_import(scene: Node) -> Object:
	_walk(scene)
	return scene

func _walk(n: Node) -> void:
	if n is MeshInstance3D and n.mesh:
		var huelle := false
		for i in n.mesh.get_surface_count():
			var m = n.mesh.surface_get_material(i)
			if m is BaseMaterial3D:
				m.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
				if m.resource_name.ends_with("_huelle"):
					huelle = true
		if huelle:
			n.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	for c in n.get_children():
		_walk(c)
