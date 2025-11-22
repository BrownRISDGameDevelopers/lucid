extends Node3D

class_name Composite

func rotate_around_pivot(pivot_vec: Vector3, axis: Vector3, angle_rad: float) -> void:
	print("big boy is gonna move")
	# Translate so pivot is at origin
	var relative_pos = self.global_position - pivot_vec
	# Create a rotation transform around the axis
	print("pivot origin: ", relative_pos)
	var rotation_transform = Transform3D(Basis(axis, angle_rad), Vector3.ZERO)
	# Apply rotation
	relative_pos = rotation_transform * relative_pos
	# Move back to pivot position
	self.global_position = pivot_vec + relative_pos
	
	print("node pos: ", self.global_position)
	# Rotate the node itself so its orientation changes
	
	self.rotate(axis, angle_rad)
