#The TileManager keeps track of Tiles in the level. It handles pathfinding
#and detecting clicks on Tiles.

extends Node
class_name TileManager


@onready var gameManager: GameManager = get_parent()
var tiles_colored : Array[Tile] = []

func _ready():
	connect_signals(self)

# Tell my children (which should only be Tiles!) to tell me if they are clicked
#made this recursive :)
func connect_signals(node):
	for child in node.get_children():
		if child is Tile:
			print("Tile Manager Detects Tile: %s" % child)
			# when cube_clicked signal is emitted from the tile,
			# call _on_cube_clicked() to start up bfs
			child.connect("cube_clicked", Callable(self, "_on_cube_clicked"))
		connect_signals(child)
		
			
	

func _on_cube_clicked(cube: Tile) -> void:
	print("TileManager: Cube " + cube.name + "clicked")
	print(cube.neighbors)
	var path: Array[Tile] = bfs(gameManager.get_current_tile(), cube)
	if path.size() > 0:
		gameManager.process_path_queue(path.duplicate(true))
	
	
func color_tile_blue(tile: Tile):
	tile.turn_blue()
	tiles_colored.append(tile)

func color_tile_orange(tile: Tile):
	tile.turn_orange()
	tiles_colored.append(tile)

func color_path_red(path: Array[Tile]) -> void:
	for p in path:
		p.turn_red()
		tiles_colored.append(p)

# Things to do when we finish traversing along a path
func path_complete(tile: Tile) -> void:
	reset_tiles(tiles_colored)

func reset_tiles(tiles: Array[Tile]) -> void:
	for t in tiles:
		t.reset_material()

			##
func bfs(start: Tile, seek) -> Array[Tile]:
	print("Start %s" % start)
	var q: Array = [[start]]
	var seen: Array[Tile] = []
	while len(q) > 0:
		var next: Array = q.pop_front()
		# with stairs, "new" is null
		# does that mean that it is not treated as part of the path
		# or is this an issue with how eveything is linked together?
		
		var new: Tile = next[-1]
		seen.append(new)
		if new == seek:
			var path: Array[Tile] = []
			for e in next:
				if e is Tile:
					path.append(e)
			return path
		if new: # this check prevents a null-pointer error when player selects a tile
			for q_append in new.neighbors:
				if not seen.has(q_append) && q_append.active && q_append.neighbors.has(new):
					q.append(next + [q_append])
	return [] as Array[Tile]
		
		
		
	
	
