extends Control
@onready var color_rect: ColorRect = $PlaceholderCutscene/ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var next_scene_path: String = "res://scenes/B.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)

func do_fade_out():
	visible = true
	print("Animation starting...")
	animation_player.play("fade_out")

# I have no idea what this argument is
func _on_animation_finished(wtf_is_this_arg):
	print("Animation finished")
	get_tree().change_scene_to_file(next_scene_path)
