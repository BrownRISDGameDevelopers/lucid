#The GameManager keeps track of the state of the game.
# The state of the level, any events that have happened, etc.
# Most importantly, it facilitates communication between the pathfinding (TileManager)
# and the player (Player)

extends Node3D

class_name GameManager

@onready var player : LucidPlayer = $Player

@onready var tileManager: Node3D = $TileManager
#The tile that the player is currently on. Initialized by the TileManager
#to be the start of the level.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

# The player is the definitive source on the tile they are
func get_current_tile() -> Tile:
	return player.current;

func move_player(path: Array[Tile]):
	player.set_path(path)

# Called by TileManager. Contains the path that the TileManager wants the player
# to traverse.
func process_path_queue(path_queue: Array[Tile]):
	if path_queue == null or path_queue.size() == 0:
		return
#	Our TileManager has found a valid path for us. 
	
#	Do we want to do go down the path that the TileManager found?
#	For now, yes, always.

#	Tell the player to dump whatever they're doing and go down this new path.
	player.set_path(path_queue.duplicate(true))
	
	#	 Color the path (for debugging)
	tileManager.color_path_red(path_queue)
#	TileManager: Issue with array size 0
	tileManager.color_tile_blue(path_queue[-1])
	
# This function is called by the Player whenever they reach a tile.
func player_reached_tile(tile: Tile):
	tileManager.color_tile_orange(tile)

# This function is called by the Player whenever they're given a new path.
func path_complete():
	tileManager.path_complete()
