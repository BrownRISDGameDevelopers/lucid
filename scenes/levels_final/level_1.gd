extends Node
#
@onready var settings_pause := $ViewportManager/UI/PauseMenu
@onready var settings_pause_button := $ViewportManager/UI/PauseButton
@onready var settings_resume_button := $ViewportManager/UI/ResumeButton
#
func _ready() -> void:
	#process_mode = Node.PROCESS_MODE_PAUSABLE
	MusicController.bgm_play1()
	settings_pause.visible = false
	settings_resume_button.visible = false

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	settings_pause.visible = true
	settings_pause_button.visible = false
	settings_resume_button.visible = true

func _on_resume_button_pressed() -> void:
	print("resume pressed")
	get_tree().paused = false
	settings_pause.visible = false
	settings_pause_button.visible = true
	settings_resume_button.visible = false
