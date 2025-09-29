extends Node3D

class_name Tile

@export var paths : Array[Tile] = []
@onready var point = $transform
var original_mat : Material


signal cube_clicked(this_cube)

func my_static_body3d_clicked():
	emit_signal("cube_clicked", self)
	
func get_pos():
	return point.global_position


func _ready():
	var mesh = $StaticBody3D/MeshInstance3D
	original_mat = mesh.get_active_material(0)

func turn_red():
	var mesh = $StaticBody3D/MeshInstance3D
	if original_mat:
		var mat = original_mat.duplicate()
		mat.albedo_color = Color.RED
		mesh.set_surface_override_material(0, mat)

func turn_blue():
	var mesh = $StaticBody3D/MeshInstance3D
	if original_mat:
		var mat = original_mat.duplicate()
		mat.albedo_color = Color.BLUE
		mesh.set_surface_override_material(0, mat)

func turn_orange():
	var mesh = $StaticBody3D/MeshInstance3D
	if original_mat:
		var mat = original_mat.duplicate()
		mat.albedo_color = Color.ORANGE
		mesh.set_surface_override_material(0, mat)

func reset_material():
	var mesh = $StaticBody3D/MeshInstance3D
	if original_mat:
		mesh.set_surface_override_material(0, original_mat)
