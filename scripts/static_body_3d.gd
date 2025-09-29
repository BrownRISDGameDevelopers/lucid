extends StaticBody3D

# This function runs when the cube is clicked on.
func _input_event(camera: Camera3D, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_parent().my_static_body3d_clicked()
