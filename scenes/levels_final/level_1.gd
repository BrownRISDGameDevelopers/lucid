extends Node
#
#@onready var settings_pause := $ViewportManager/UI/SettingsPause
#
func _ready() -> void:
	#process_mode = Node.PROCESS_MODE_PAUSABLE
	MusicController.bgm_play1()
	

	#
#func _on_PauseButton_pressed() -> void:
	#get_tree().paused = true
	#show()
	
