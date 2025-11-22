# The player. The player is the definitive source on where the player is.
# The player handles movement between target tiles

class_name LucidPlayer
extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $Player_Animated/Lucid_MC/AnimationPlayer
@onready var animation_manager: Node3D = $AnimationManager

# The properties that the physics process is interpolating toward
var target_tile: Tile

# This is the difference between the player's global_position and their feet (i love feet)
var player_offset: Vector3 = Vector3(0,0.245,0)

# Is the player upside down/on a foreground tile?
var is_flipped: bool = false

# The speed at which the player moves while flipping
@export var flip_speed: float = 5

# Suppress all movement while we are flipping. Checked by the GameManager
# before a path is assigned.
# Specifically blocks a path being added to
var deny_new_path = false

# Prevent the player model from looking directly at the tile were pathing to.
# Useful when we're flipping gravity.
var deny_new_look = false
# A boolean that controls if the player can move through the elements of the path, used for moving-tile
# blocks a path from being modified at all, a stronger version of deny_new_path
var locked_path = false

var path: Array[Tile]
@onready var gameManager: GameManager = get_parent();
@export var speedMultiplier = 3;

var actual_speed = 0;
@export var current: Tile

# Any number larger than then maximum speed of all the moving tiles should work here.
# Essentially, the player needs this to move when the current tile is the target tile, but
# not the player's actual location anymore
var max_tile_speed;

# Tells the player to walk the path supplied. Called by the GameManager
func set_path(myPath: Array[Tile]):
	gameManager.path_complete(current)
	if myPath.size() == 0: return
	path = myPath;
	if (path[0] == current && !locked_path):
		path.pop_front()
		
	if (locked_path):
		target_tile = path.front()
	else:
		target_tile = path.pop_front()
		
	_update_speed()


func _ready() -> void:
	assert(current != null)

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
	print("Player: Look at Tile")
	var dir = tile.get_my_active_edge_pos() - global_transform.origin
	var target_rot = atan2(dir.x, dir.z)
	rotation.y = lerp_angle(rotation.y, target_rot, 0.1)

func _physics_process(delta :float):
	if (target_tile == null):
		#actual_speed = 0
		return
		# Move toward target tile
		
	if (!deny_new_path):
		look_at_tile(target_tile)
	
	global_position = global_position.move_toward(target_tile.get_my_active_edge_pos() + player_offset, delta * actual_speed)
	
#	If our target is upside down, we need to rotate!!
	
	# If we have reached the target tile
	if global_position == target_tile.get_my_active_edge_pos() + player_offset && !locked_path:		
		reached_tile(target_tile)

func player_busy() -> bool:
#	If any of these are true, we are busy
	return (deny_new_path || locked_path || target_tile || path)

@onready var JumpEffectScene := preload("res://scenes/effects/jump_2danim.tscn")

# Called by the game manager; tells us to switch gravity
func flip():
	is_flipped = !is_flipped
#	flip the player's offset: This lets us walk on the bottom of tiles.
	player_offset.y = -player_offset.y
	
#	Jump animation
	if (is_flipped):
		var e = JumpEffectScene.instantiate()
		e.position = position - player_offset
			#e.position = position + Vector3(0,-0.5,0)
		get_parent().add_child(e)
	
#	Rotate the player: this flips the animation
	animation_manager.do_flip()
	
	deny_new_path = true
	
#	Prevent the flip action from changing the direction the player is looking
	deny_new_look = true

	target_tile = current.gravity_path
	
	print(target_tile)
	actual_speed = flip_speed
	
func _input(event):
	if event.is_action_pressed("flip_gravity"):
		print("flip graV")
		gameManager.player_wants_to_flip(current)
	if event.is_action_pressed("rotate_node"):
		print("rotate_node")
		gameManager.player_wants_to_rotate(current)


@onready var TpEffectScene := preload("res://scenes/effects/teleport_2danim.tscn")

func reached_tile(tile: Tile):
	print("Reached tile")
	deny_new_path = false
#	Tell the gameManager we reached a tile (so it can tell the tileManager)	
	
	gameManager.player_reached_tile(target_tile)

#		Update the tile we're currently on
#		Update our target to the next element in our path
	current = tile
	target_tile = path.pop_front()
		
	if target_tile == null:
		# We have reached the end of our path
		if tile.teleport_tile:
			var e = TpEffectScene.instantiate()
			e.position = global_position + Vector3(0,0.5,0)
			#e.position = position + Vector3(0,-0.5,0)
			get_parent().add_child(e)
			
			print("teleported!")
			global_position = tile.teleport_tile.get_my_active_edge_pos() + player_offset
			current = tile.teleport_tile
#			We have reached the end of our path
		gameManager.path_complete(current)
	else:
		_update_speed()	
