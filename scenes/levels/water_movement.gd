class_name Waterfall
extends MeshInstance3D

@export var speed := -0.35
@export var flowing := true
@export var height_min := 0.0
@export var height_max := 8.0

var offset_y := 0.0
var cutoff_value := 1.0   # this is what the tween will animate

signal shutoff_finish
signal activation_finish

var mat: ShaderMaterial

func _ready() -> void:
	mat = material_override as ShaderMaterial
	mat.set_shader_parameter("height_max", height_max)
	mat.set_shader_parameter("height_min", height_min)


func _process(delta: float) -> void:
	offset_y += delta * speed
	if offset_y <= -1.0:
		offset_y = 0.0

	mat.set_shader_parameter("uv_offset", Vector2(0.0, offset_y))
	mat.set_shader_parameter("reverse", flowing)
	mat.set_shader_parameter("cutoff", cutoff_value)  # <- ALWAYS applied here
	
		


func start_waterfall():
	flowing = true
	var tween := create_tween()
	tween.tween_property(self, "cutoff_value", 1.0, 1.0)
	tween.finished.connect(_on_activation_finish)

func stop_waterfall():
	flowing = false
	var tween := create_tween()
	tween.tween_property(self, "cutoff_value", 0.0, 1.0)
	tween.finished.connect(_on_shutoff_finish)

func _on_activation_finish():
	emit_signal("activation_finish")

func _on_shutoff_finish():
	emit_signal("shutoff_finish")
