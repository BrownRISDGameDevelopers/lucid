extends MeshInstance3D

@export var speed := -0.35
@export var flowing := true
var offset_y := 0.0

var mat: ShaderMaterial

func _ready() -> void:
	mat = get_active_material(0) as ShaderMaterial

func _process(delta: float) -> void:
	if flowing:
		offset_y += delta * speed
		if offset_y <= -1.0:
			offset_y = 0.0
		material_override.uv1_offset.y = offset_y

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		flowing = false

		var tween := create_tween()  # create fresh tween
		tween.tween_property(mat, "shader_parameter/cutoff", 0.0, 1.0)

#extends MeshInstance3D
#
#@export var speed:=-0.35
#@export var flowing:=true
#var offset_y:=0.0
#
#func _process(delta:float)->void:
	#if flowing:
		#offset_y+=delta*speed
		#if offset_y<=-1.0:
			#offset_y=0.0
	#material_override.uv1_offset.y=offset_y
#
#var tween := create_tween()
#var mat := $Waterfall.get_active_material()
#func _input(event:InputEvent)->void:
	#tween.tween_property(mat, "shader_parameter/cutoff", 0.0, 1.0)
