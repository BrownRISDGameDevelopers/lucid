#The GameManager keeps track of the state of the game.
# The state of the level, any events that have happened, etc.
# Most importantly, it facilitates communication between the pathfinding (TileManager)
# and the player (Player)

extends Node

class_name GameManager

@onready var player : LucidPlayer = $Player

@onready var tileManager: Node = $TileManager


@export var endTile: Tile

#The tile that the player is currently on. Initialized by the TileManager
#to be the start of the level.

func _ready() -> void:
	assert (endTile != null)

# Called when the node enters the scene tree for the first time.

# The player is the definitive source on the tile they are
func get_current_tile() -> Tile:
	return player.current;

# Move's a player to a position
func move_player(path: Array[Tile]):
	player.set_path(path)	


# Called by TileManager. Contains the path that the TileManager wants the player
# to traverse.
func process_path_queue(path_queue: Array[Tile]):
	if path_queue == null or path_queue.size() == 0:
		return
#	Our TileManager has found a valid path for us. 
	
#	Do we want to do go down the path that the TileManager found?
#	Does the Player want us to?
	if (player.deny_new_path || player.locked_path): return
#	Tell the player to dump whatever they're doing and go down this new path.
	player.set_path(path_queue.duplicate(true))
	
	#	 Color the path (for debugging)
	tileManager.color_path_red(path_queue)
#	TileManager: Issue with array size 0
	tileManager.color_tile_blue(path_queue[-1])
	
func player_wants_to_flip(tile: Tile):
	if (player.player_busy()): return
	if (tile.gravity_path != null):
		#	If the player has somewhere to go when we flip gravity, let it happen
		player.flip()
		pass
		
func player_wants_to_rotate(tile: Tile):
	if (tile.trigger_pivot && !tile.pivot.rotation_busy):
		print("rotating")
		tile.pivot.rotate_children()
	
# This function is called by the Player whenever they reach a tile.
func player_reached_tile(tile: Tile):
	tileManager.color_tile_orange(tile)
	if (endTile == tile):
		execute_end_routine()
@onready var fade_out: Control = $FadeOut

# Called when the player reaches the goal
func execute_end_routine():
	print("End routine")
	fade_out.do_fade_out()
	
# This function is called by the Player whenever they finish a path or they're given a new path.
func path_complete(tile: Tile):
	tileManager.path_complete(tile)
	
# Switch the scene to the next scene; depending on how we implement this, we may want to change etr to take in a string of the scene we're changing to
func end_tile_reached():
	get_tree().change_scene_to_file("res://scenes/components/level_2.tscn")
# This function is called by the Player whenever they're given a new path.
func path_complete():
	tileManager.path_complete()

# Attaches the player's movement to a tile, useful for moving
func lock_player(tile: Tile, speed: int):
	player.lock_movement(tile, speed)

# Resets player's movement access
func unlock_player():
	player.unlock_movement()
