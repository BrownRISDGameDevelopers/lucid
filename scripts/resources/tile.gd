@tool
extends Node3D

class_name Tile

@export var neighbors : Array[Tile] = []

@onready var mesh_instance: MeshInstance3D = $StaticBody3D/MeshInstance3D
@export_flags_3d_render var cull_mask:= 1:
	set(value):
		cull_mask = value
		print(cull_mask)
		
@export var texture : Material:
	set(newTexture):
		texture = newTexture
		_apply_texture()
	
# The tile that we go to if we press Spacebar (if any)
@export var gravity_path : Tile

@onready var point = $transform
var original_mat : Material


signal cube_clicked(this_cube)


func my_static_body3d_clicked():
	emit_signal("cube_clicked", self)

func get_my_active_edge_pos() -> Vector3:
	return point.global_position
	
func _ready():
	original_mat = mesh_instance.get_active_material(0)
	mesh_instance.set_layer_mask(cull_mask)

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
		
func _apply_texture():
	if not mesh_instance:
		return
	var mat := mesh_instance.material_override
	if not (mat is StandardMaterial3D):
		mat = StandardMaterial3D.new()
		mesh_instance.material_override = mat
	mat.albedo_texture = texture
		
