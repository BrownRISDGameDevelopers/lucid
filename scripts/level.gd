extends Node3D

@export var Start : Tile

@export var End : Tile
@export var PlayerSpeed = 3;

@onready var Player : CharacterBody3D = $Player

var Current : Tile

@onready var path_queue : Array[Tile] = []

# The tiles in our given path that we have already walked on
var tiles_walked_on : Array[Tile] = []

# This is the tile we are actively walking torwards
var target_tile : Tile

# Purely for preventing coloration bugs. Can safely remove (probably, idk)
var last_colored_path: Array[Tile] = []


func _ready():
	Current = Start
	Current.turn_orange()
	connect_signals()


func connect_signals():
	for child in get_children():
		if child is Tile:
			child.connect("cube_clicked", Callable(self, "_on_cube_clicked"))



func _on_cube_clicked(cube: Tile) -> void:
	print("kewb clicked")
	var path: Array[Tile] = bfs(Current, cube)

	if path != []:
#		We found a path.
#		Dump whatever existing path we currently have.
		path_complete()
		
#		Color our new path (for debugging)
		color_path_red(path)
		last_colored_path = path.duplicate()
#		Turn the last element in our path blue (debugging)
		path[-1].turn_blue()
	
	if path_queue == []:
		target_tile = path.pop_front()		
		update_speed()

	path_queue = path
		

func update_speed():
#	idk this just updates the speed of the player between tiles
	print(target_tile.get_pos())
	print(Current.get_pos())
	print(Player.global_position)
	PlayerSpeed = (target_tile.get_pos() - Current.get_pos()).length() * 3
	


func _physics_process(delta :float):
	if target_tile == null:
		return
		
# determine speed based on offset between tiles

#	Move torward target tile
	Player.global_position = Player.global_position.move_toward(target_tile.get_pos() + Vector3(0, 1, 0), delta * PlayerSpeed)
	
#	If we have reached the target tile
	if Player.global_position == target_tile.get_pos() + Vector3(0, 1, 0) or target_tile == Current:
		tiles_walked_on.append(target_tile)
#		Update the tile we're currently on
		Current = target_tile
		Current.turn_orange()
#		Update our target to the next element in our path
		target_tile = path_queue.pop_front()
		if target_tile == null:
#			We have reached the end of our path
			path_complete()
		else:
			update_speed()

# Things to do when we finish traversing along a path
func path_complete() -> void:
	reset_colors_on_path(last_colored_path)
	reset_colors_on_path(tiles_walked_on)
	reset_colors_on_path(path_queue)
	tiles_walked_on = []
	path_queue = []
	last_colored_path = []
	
func color_path_red(path: Array[Tile]) -> void:
	for p in path:
		p.turn_red()
	
func reset_colors_on_path(path: Array[Tile]) -> void:
	for p in path:
		p.reset_material()

			##
func bfs(start: Tile, seek) -> Array[Tile]:
	print("Start %s" % start)
	var q: Array = [[start]]            # nested generics not supported
	var seen: Array[Tile] = []
	while len(q) > 0:
		var next: Array = q.pop_front()
		var new: Tile = next[-1]
		seen.append(new)
		if new == seek:
			var path: Array[Tile] = []
			for e in next:
				if e is Tile:
					path.append(e)
				else:
					print("Non-Tile in path:", e)
			return path
		for q_append in new.paths:
			if not seen.has(q_append):
				q.append(next + [q_append])
	return [] as Array[Tile]
		
		
		
	
	
