extends Node3D

class_name Pivot 


@export var children : Array[Tile]

@export var rotate_by := 90.0

# if true, rotate clockwise, if false, counterclockwise
@export var direction: bool = false

func rotate_children():
	for child in children:	
		
		if (child.ghost):
			child.visible = !child.visible
		
		if (child.rotation_path):
			var temp = child.neighbors
			child.neighbors = child.rotation_path
			child.rotation_path = temp
		
		if (child.pivot && !child.trigger_pivot):
			print("rotating child")
			var angle = deg_to_rad(rotate_by)
			var rotate_direction = Vector3.LEFT if direction else Vector3.RIGHT
			child.rotate_around_pivot(self.global_position, rotate_direction, angle)

	direction = !direction
