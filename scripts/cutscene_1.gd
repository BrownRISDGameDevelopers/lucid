extends Control
@onready var fade_out: Control = $FadeOut


func _input(event: InputEvent) -> void:
	print("I'm eating mouseinput")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("cutscene go next")
		fade_out.do_fade_out()
