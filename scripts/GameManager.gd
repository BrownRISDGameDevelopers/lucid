#The GameManager keeps track of the state of the game.
# The state of the level, any events that have happened, etc.
# Most importantly, it facilitates communication between the pathfinding (TileManager)
# and the player (Player)

extends Node

class_name GameManager

@onready var player : LucidPlayer = $Player

@onready var tileManager: Node = $TileManager
#The tile that the player is currently on. Initialized by the TileManager
#to be the start of the level.

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
	
# This function is called by the Player whenever they reach a tile.
func player_reached_tile(tile: Tile):
	tileManager.color_tile_orange(tile)

# This function is called by the Player whenever they're given a new path.
func path_complete():
	tileManager.path_complete()

# Attaches the player's movement to a tile, useful for moving
func lock_player(tile: Tile, speed: int):
	player.lock_movement(tile, speed)

# Resets player's movement access
func unlock_player():
	player.unlock_movement()
