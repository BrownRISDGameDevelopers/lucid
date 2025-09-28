extends Node3D

@export var Start : Tile

@export var End : Tile


func _ready():
	print("hi")
	bfs([[Start.paths[0]]])


func bfs(q):
	var seen = []
	while len(q) > 0:
		var next = q.pop_front()
		var new = next[-1]
		seen.append(new)
		if new == End:
			print(next)
			break
		for q_append in new.paths:
			if seen.has(q_append) == false:
				q.append(next + [q_append])
			
				
		
		
		
	
	
