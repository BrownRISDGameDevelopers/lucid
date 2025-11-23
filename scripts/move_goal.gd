extends Marker3D

class_name MoveGoal

@export var neighbors : Array[Tile] = []
@export var gravity_path : Tile
@export var unlock : bool = true

func _get_neighbors():
	return neighbors
