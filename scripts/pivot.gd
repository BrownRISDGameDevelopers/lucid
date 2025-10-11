extends Node3D

class_name Pivot 

@export var rotation_speed := 90.0  # degrees per second

@export var children : Array[Tile]

func rotate_children(delta):
	for child in children:	
		
		if (child.rotation_path):
			var temp = child.neighbors
			child.neighbors = child.rotation_path
			child.rotation_path = child.neighbors
		
		if child.pivot:
			var angle = deg_to_rad(rotation_speed * delta)
			print(child)
			print(angle)
			child.rotate_around_pivot(self.global_position, Vector3.RIGHT, angle)
