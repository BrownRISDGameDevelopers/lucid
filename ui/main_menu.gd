extends Control


func _on_settings_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.settingsmain)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.level1)


func _on_credits_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.credits)
