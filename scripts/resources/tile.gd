extends Node3D

class_name Tile

@export var paths : Array[Node3D]

@onready var point = $transform

signal cube_clicked(this_cube)

func my_static_body3d_clicked():
	#print("MY STATIC BODY 3D CLICKED")
	emit_signal("cube_clicked", self)
	
func get_pos():
	return point.global_position
