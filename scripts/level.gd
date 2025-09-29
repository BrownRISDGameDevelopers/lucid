extends Node3D

@export var Start : Tile

@export var End : Tile

@onready var Player : Node3D = $Player

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
	
	
	



func bfs(start, seek):
	var q = [[start]]
	var seen = []
	while len(q) > 0:
		var next = q.pop_front()
		var new = next[-1]
		seen.append(new)
		if new == seek:
			print(next)
			next.pop_front()
			return next
		for q_append in new.paths:
			if seen.has(q_append) == false:
				q.append(next + [q_append])
	return []
			
				
		
		
		
	
	
