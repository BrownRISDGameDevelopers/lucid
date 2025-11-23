extends Control

func _on_credits_default_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.credits)

func _on_settings_default_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.settingsmain)

func _on_quit_default_pressed() -> void:
	get_tree().quit()

func _on_resume_default_pressed() -> void:
	pass # Replace with function body.
