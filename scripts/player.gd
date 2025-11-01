# The player. The player is the definitive source on where the player is.
# The player handles movement between target tiles

class_name LucidPlayer
extends CharacterBody3D


# The properties that the physics process is interpolating toward
var target_tile: Tile

const DIR_TO_LOOK = {
	SOUTHEAST = 90,
	SOUTHWEST = 0,
	NORTHEAST = 180,
	NORTHWEST = 270
}

var target_rotation : Vector3 = Vector3(0,0,0)


# This is the difference between the player's global_position and their feet (i love feet)
var player_offset: Vector3 = Vector3(0,1,0)

# Is the player upside down/on a foreground tile?
var is_flipped: bool = false

# Suppress all movement while we are flipping or on a moving-tile. Checked by the GameManager
# before a path is assigned.
# Specifically blocks a path being added to
var deny_new_path = false

# A boolean that controls if the player can move through the elements of the path, used for moving-tile
# blocks a path from being modified at all, a stronger version of deny_new_path
var locked_path = false

var path: Array[Tile]
@onready var gameManager: GameManager = get_parent();
@export var speedMultiplier = 3;

var actual_speed;
@export var current: Tile

# Any number larger than then maximum speed of all the moving tiles should work here.
# Essentially, the player needs this to move when the current tile is the target tile, but
# not the player's actual location anymore
var max_tile_speed;

# Tells the player to walk the path supplied. Called by the GameManager
func set_path(myPath: Array[Tile]):
	gameManager.path_complete()
	if myPath.size() == 0: return
	path = myPath;
	if (path[0] == current && !locked_path):
		path.pop_front()
		
	if (locked_path):
		target_tile = path.front()
	else:
		target_tile = path.pop_front()
		
	_update_speed()

# Forces the player to a target at a given speed, locking down movement until complete
func lock_movement(tile: Tile, speed: int):
	if  !player_busy():
		locked_path = true
		set_path([tile])
		max_tile_speed = speed
		_update_speed()

# Unlocks the player's movement
func unlock_movement():
	locked_path = false
	deny_new_path = false
	
	
func _update_speed():
	if target_tile:
		actual_speed = ((target_tile.get_my_active_edge_pos()) - current.get_my_active_edge_pos()).length() * speedMultiplier
	if locked_path:
		# Essentially it needs some magnitude to move, but if the player is locked to a tile
		# the current tile and target tile are the same, so we need to add a dummy value for it to
		# calculate.  This number should always be positive, and always be equal to or
		# greater than the maximum speed of all tiles
		actual_speed = max_tile_speed

func look_at_tile(tile: Tile):
	var dir = tile.get_my_active_edge_pos() - global_transform.origin
	if (tile.is_foreground):
#		The tile is an "upside down tile"
		rotation.y = atan2(dir.x, dir.z)
	else:
#		The tile is on the floor
		rotation.y = atan2(dir.x, dir.z)
		
func _physics_process(delta :float):
	if (target_tile == null):
		return
		# Move toward target tile
	look_at_tile(target_tile)
	
	global_position = global_position.move_toward(target_tile.get_my_active_edge_pos() + player_offset, delta * actual_speed)
	
#	If our target is upside down, we need to rotate!!
	
	# If we have reached the target tile
	if global_position == target_tile.get_my_active_edge_pos() + player_offset && !locked_path:		
		reached_tile(target_tile)

func player_busy() -> bool:
#	If any of these are true, we are busy
	return (deny_new_path || locked_path || target_tile || path)


# Called by the game manager; tells us to switch gravity
func flip():
	print("flip")
	is_flipped = !is_flipped
#	flip the player's offset
	#print(player_offset)
	player_offset.y = -player_offset.y
	#print(player_offset)
	deny_new_path = true
	target_tile = current.gravity_path
	
func _input(event):
	if event.is_action_pressed("flip_gravity"):
		gameManager.player_wants_to_flip(current)


func reached_tile(tile: Tile):
	print("Reached tile")
	deny_new_path = false
#	Tell the gameManager we reached a tile (so it can tell the tileManager)	
	#print("Reached tile. Player Position:")
	#print(position)
	#print("Player rotation")
	#print(rotation_degrees)
	
	gameManager.player_reached_tile(target_tile)

#		Update the tile we're currently on
#		Update our target to the next element in our path
	current = tile
	target_tile = path.pop_front()
		
	if target_tile == null:
#			We have reached the end of our path
		gameManager.path_complete()
	else:
		_update_speed()	
