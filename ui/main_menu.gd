extends Control


func _on_lvlchoice_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.level1)


func _on_settings_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.settingsmain)


func _on_tutorial_pressed() -> void:
	print("Tutorial pressed")


func _on_exit_pressed() -> void:
	get_tree().quit()
