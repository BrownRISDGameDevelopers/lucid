extends Tile

class_name MovingTile

#@export var goals : Array[Marker3D] = []
var goal : Marker3D
var speed = 5;
var moving = false;

@onready var gameManager: GameManager = get_parent().get_parent();

#func next_target(target : Tile):

func _physics_process(delta : float):
	if (moving):
		global_position = global_position.move_toward(goal.global_position, delta * speed)
