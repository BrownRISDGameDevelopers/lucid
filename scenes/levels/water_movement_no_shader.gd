extends MeshInstance3D

@export var speed := 0.35
@export var flowing := true
@export var height_min := 0.0
@export var height_max := 8.0

var offset_y := 0.0
var cutoff_value := 1.0   # this is what the tween will animate


func _process(delta: float) -> void:
	get_surface_override_material(0).uv1_offset.y += delta * speed
	if get_surface_override_material(0).uv1_offset.y >= 1:
		get_surface_override_material(0).uv1_offset.y = 0.0
