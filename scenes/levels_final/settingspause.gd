extends Control

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
	
func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
	
func _on_back_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.mainmenu)
