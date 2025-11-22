extends Node3D

class_name Pivot 

@export var rotate_by := 90

@export var big_mesh : Composite

var rotation_time := 2

# if true, rotate clockwise, if false, counterclockwise
@export var direction: bool = false

@onready var rotation_busy: bool = false

var rotated : float

var children : Array[Tile]

func _ready():
	var n_children = get_children()
	for child in n_children:
		if child is Tile:
			children.append(child)

func rotate_children():
	for child in children:
		if (child.pivot && !child.trigger_pivot):
			child.deactivate()
	rotation_busy = true
	rotated = 0

func rotation_completed():
	print("done")
	for child in children:
		if (child.pivot && !child.trigger_pivot):
			child.update_point_to_up_face()
			child.activate()
	for child in children:
		if (child.rotation_path_bool):
			var temp = child.neighbors
			child.neighbors = child.rotation_path
			child.rotation_path = temp
	rotation_busy = false
	direction = !direction


func _physics_process(delta: float):

	if rotation_busy:
		var to_rotate = delta/rotation_time * rotate_by
		var rotate_direction = Vector3.LEFT if direction else Vector3.RIGHT
		var angle = deg_to_rad(to_rotate)	
		for child in children:
			if ((child.pivot && !child.trigger_pivot) || child is not Tile):
				print("rotating child")
				child.rotate_around_pivot(self.global_position, rotate_direction, angle)
		big_mesh.rotate_around_pivot(self.global_position, rotate_direction, angle)
		rotated += to_rotate
		if rotated == rotate_by:
			rotation_completed()
	
