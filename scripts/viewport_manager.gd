extends Node

@export var viewports: Array[Viewport] = []  # top → bottom

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var screen_pos: Vector2 = event.position
		for vp in viewports:
			var cam := _find_camera(vp)
			if cam == null:
				continue
			var hit := _raycast_from_camera(cam, screen_pos)
			if hit:
				print("Viewport:", vp.name, "Camera:", cam.name, "Hit:", hit.collider.name)
				if hit.collider.has_method("on_cube_click"):
					print("Has method on_cube_click")
					hit.collider.on_cube_click()
				return  # stop after first visible hit

func _find_camera(vp: Viewport) -> Camera3D:
	for child in vp.get_children():
		if child is Camera3D:
			return child
	return null

func _raycast_from_camera(cam: Camera3D, screen_pos: Vector2) -> Dictionary:
	var ray_origin: Vector3 = cam.project_ray_origin(screen_pos)
	var ray_normal: Vector3 = cam.project_ray_normal(screen_pos)
	var ray_end: Vector3 = ray_origin + ray_normal * 2000.0

	var query := PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	query.collision_mask = cam.cull_mask

	var space_state := PhysicsServer3D.space_get_direct_state(cam.get_world_3d().space)
	return space_state.intersect_ray(query)
