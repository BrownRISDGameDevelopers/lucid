extends Control
@onready var color_rect: ColorRect = $PlaceholderCutscene/ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _unhandled_input(event: InputEvent) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	play_fade_in()

func play_fade_in() -> void:
	print("Animation Player: play_fade_in")
	animation_player.play("fade_in")

# I have no idea what this argument is
func _on_animation_finished(wtf_is_this_arg):
	print("Animation finished")	
