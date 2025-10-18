extends Control
@onready var color_rect: ColorRect = $PlaceholderCutscene/ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _unhandled_input(event: InputEvent) -> void:
	print("stealing input")
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	print("Animation starting...")
	animation_player.play("fade_in")

# I have no idea what this argument is
func _on_animation_finished(wtf_is_this_arg):
	print("Animation finished")	
