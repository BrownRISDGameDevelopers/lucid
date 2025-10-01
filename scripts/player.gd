class_name LucidPlayer
extends CharacterBody3D

var target_tile: Tile
var path: Array[Tile]
@onready var gameManager: GameManager = get_parent();
@export var speedMultiplier = 3;

var actual_speed;
@export var current: Tile

func _ready() -> void:
	print(current.name)

func isWalking() -> bool:
	return false


func set_path(myPath: Array[Tile]):
	gameManager.path_complete()
	if myPath.size() == 0: return
	path = myPath;
	if (path[0] == current):
		path.pop_front()
	
	target_tile = myPath.pop_front()
	update_speed()
	

func update_speed():
	if target_tile:
		actual_speed = (target_tile.get_pos() - current.get_pos()).length() * speedMultiplier
	
func _physics_process(delta :float):
	if (target_tile == null):
		return
		# Move toward target tile
	global_position = global_position.move_toward(target_tile.get_pos() + Vector3(0, 1, 0), delta * actual_speed)
	
#	If we have reached the target tile
	if global_position == target_tile.get_pos() + Vector3(0, 1, 0):		
		reached_tile(target_tile)

func reached_tile(tile: Tile):
#	Tell the gameManager we reached a tile (so it can tell the tileManager)	
	gameManager.player_reached_tile(target_tile)

#		Update the tile we're currently on
	current = tile
#		Update our target to the next element in our path
	target_tile = path.pop_front()
	if target_tile == null:
#			We have reached the end of our path
		gameManager.path_complete()
	else:
		update_speed()	
