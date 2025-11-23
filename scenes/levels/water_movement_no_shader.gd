extends MeshInstance3D

@export var speed := 0.35
@export var flowing := true
@export var height_min := 0.0
@export var height_max := 8.0

var offset_y := 0.0
var cutoff_value := 1.0

var mat : StandardMaterial3D


func _ready() -> void:
	# Make sure we have a unique material instance
	mat = get_surface_override_material(0)
	if mat:
		mat = mat.duplicate()
		set_surface_override_material(0, mat)


func _process(delta: float) -> void:
	if not mat:
		return

	mat.uv1_offset.y += delta * speed
	mat.uv1_offset.y = fposmod(mat.uv1_offset.y, 1.0)
