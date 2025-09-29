extends Node3D

@export var Start : Tile

@export var End : Tile

@onready var Player : CharacterBody3D = $Player

var Current : Tile

func _ready():
	Current = Start
	connect_signals()


func connect_signals():
	for child in get_children():
		child.connect("cube_clicked", Callable(self, "_on_cube_clicked"))



func move_player_along_path(path) -> void:
	for p in path:	
		var pos = p.get_pos()
		var offset = pos - Current.get_pos()
		Player.translate(offset)
		await get_tree().create_timer(1).timeout
		Current = p

func color_path_red(path: Array[Tile]) -> void:
	for p in path:
		p.turn_red()
	
func reset_path(path: Array[Tile]) -> void:
	for p in path:
		p.reset_material()

func _on_cube_clicked(cube: Tile) -> void:
	print("kewb clicked")
	var path = bfs(Current, cube)
	color_path_red(path)
	move_player_along_path(path)
	reset_path(path)

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
		
		
		
	
	
