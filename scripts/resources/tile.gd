extends Node3D

class_name Tile

@export var neighbors : Array[Tile] = []

@export var is_foreground : bool = false

# The tile that we go to if we press Spacebar (if any)
@export var gravity_path : Tile

@onready var point = $transform
var original_mat : Material


signal cube_clicked(this_cube)

func my_static_body3d_clicked():
	print("Tile: my_static_body3d_clicked")
	emit_signal("cube_clicked", self)

func get_my_active_edge_pos() -> Vector3:
	if (is_foreground):
#		We want to return the bottom edge of the tile
		return point.global_position + Vector3(0,-1,0)
	else:
#		We want to return the top edge of the tile
		return point.global_position
	
func _ready():
	var mesh = $StaticBody3D/MeshInstance3D
	original_mat = mesh.get_active_material(0)
	set_visiblity_layers()

func set_visiblity_layers():
	var mesh = $StaticBody3D/MeshInstance3D
	original_mat = mesh.get_active_material(0)
	if (is_foreground):
	# 	If this tile is in the FOREGROUND (infront of the player)
	#	Set the CULL LAYER TO 3
		mesh.set_layer_mask_value(3,true)
		mesh.set_layer_mask_value(1,false)
	else:
	#	If this tile is in the BACKGROUND (behind the player)
	#	SET THE CULL LAYER TO 1
		mesh.set_layer_mask_value(1,true)
		mesh.set_layer_mask_value(3,false)	

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
