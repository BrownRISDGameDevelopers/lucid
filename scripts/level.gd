extends Node3D

@export var Start : Tile

@export var End : Tile

@onready var Player : Node3D = $Player

var Current : Tile

func _ready():
	Current = Start
	connect_signals()


func connect_signals():
	for child in get_children():
		child.connect("cube_clicked", Callable(self, "_on_cube_clicked"))




func _on_cube_clicked(cube: Tile) -> void:
	print("kewb clicked")
	var path = bfs(Current, cube)
	for p in path:	
		var pos = p.get_pos()
		var offset = pos - Current.get_pos()
		Player.translate(offset)
		await get_tree().create_timer(1).timeout
		Current = p
	
	



func bfs(start, seek):
	var q = [[start]]
	var seen = []
	while len(q) > 0:
		var next = q.pop_front()
		var new = next[-1]
		seen.append(new)
		if new == seek:
			print(next)
			return next
		for q_append in new.paths:
			if seen.has(q_append) == false:
				q.append(next + [q_append])
	return []
			
				
		
		
		
	
	
