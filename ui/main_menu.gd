extends Control


func _on_lvlchoice_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/new_level1.tscn")


func _on_settings_pressed() -> void:
	print("Settings pressed")


func _on_tutorial_pressed() -> void:
	print("Tutorial pressed")


func _on_exit_pressed() -> void:
	get_tree().quit()
