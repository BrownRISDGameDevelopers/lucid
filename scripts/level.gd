extends Node3D

@export var Start : Tile

@export var End : Tile

@onready var Player : CharacterBody3D = $Player

var Current : Tile

@onready var path_queue = []

var target_tile

func _ready():
	Current = Start
	connect_signals()


func connect_signals():
	for child in get_children():
		child.connect("cube_clicked", Callable(self, "_on_cube_clicked"))



func _on_cube_clicked(cube: Tile) -> void:
	print("kewb clicked")
	var path = bfs(Current, cube)
	if path_queue == []:
		target_tile = path.pop_front()		
	path_queue = path
		

func _physics_process(delta :float):
	if path_queue.is_empty():
		return
	Player.global_position = Player.global_position.move_toward(target_tile.get_pos() + Vector3(0, 1, 0), delta)
	
	if Player.global_position == target_tile.get_pos()+ Vector3(0, 1, 0):
		Current = target_tile
		target_tile = path_queue.pop_front()
	
func color_path_red(path: Array[Tile]) -> void:
	for p in path:
		p.turn_red()
	
func reset_path(path: Array[Tile]) -> void:
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
		
		
		
	
	
