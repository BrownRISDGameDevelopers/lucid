extends Node
#
@onready var settings_pause := $ViewportManager/UI/Settings
#
func _ready() -> void:
	#process_mode = Node.PROCESS_MODE_PAUSABLE
	MusicController.bgm_play1()
	settings_pause.visible = false

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	settings_pause.visible = true
