# The player. The player is the definitive source on where the player is.
# The player handles movement between target tiles

class_name LucidPlayer
extends CharacterBody3D


# The properties that the physics process is interpolating toward
var target_tile: Tile
var target_rotation : Vector3 = Vector3(0,0,0)


# This is the difference between the player's global_position and their feet (i love feet)
var player_offset: Vector3 = Vector3(0,1,0)

var is_flipped: bool = false

var path: Array[Tile]
@onready var gameManager: GameManager = get_parent();
@export var speedMultiplier = 3;

var actual_speed;
@export var current: Tile

func set_path(myPath: Array[Tile]):
	gameManager.path_complete(current)
	if myPath.size() == 0: return
	path = myPath;
	
	if (path[0] == current):
		path.pop_front()
	target_tile = myPath.pop_front()
	
	_update_speed()

func _update_speed():
	if target_tile:
		actual_speed = ((target_tile.get_my_active_edge_pos()) - current.get_my_active_edge_pos()).length() * speedMultiplier
	
func _physics_process(delta :float):
	if (target_tile == null):
		return
		# Move toward target tile
	global_position = global_position.move_toward(target_tile.get_my_active_edge_pos() + player_offset, delta * actual_speed)
	
#	If our target is upside down, we need to rotate!!
	
	# If we have reached the target tile
	if global_position == target_tile.get_my_active_edge_pos() + player_offset:		
		reached_tile(target_tile)

# Called by the game manager; tells us to switch gravity
func flip():
	print("flip")
	is_flipped = !is_flipped
	
#	flip the player's offset
	print(player_offset)
	player_offset.y = -player_offset.y
	print(player_offset)
	
	rotation_degrees = Vector3(180, 0, 0)
	
	target_tile = current.gravity_path
	target_rotation.x += 180

func _input(event):
	if event.is_action_pressed("flip_gravity"):
		gameManager.player_wants_to_flip(current)


func reached_tile(tile: Tile):
#	Tell the gameManager we reached a tile (so it can tell the tileManager)	
	print("Reached tile. Player Position:")
	print(position)
	print("Player rotation")
	print(rotation_degrees)
	
	gameManager.player_reached_tile(target_tile)

#		Update the tile we're currently on
	current = tile
#		Update our target to the next element in our path
	target_tile = path.pop_front()
	if target_tile == null:
#			We have reached the end of our path
		gameManager.path_complete(current)
	else:
		_update_speed()	
