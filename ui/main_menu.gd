extends Control


func _on_settings_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.settingsmain)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.level1)

@onready var title: TextureRect = $Title
@onready var texture_rect: TextureRect = $TextureRect
@onready var credits: Control = $Credits
@onready var v_box_container: VBoxContainer = $VBoxContainer

func _on_credits_pressed() -> void:
	title.visible = false
	v_box_container.visible = false
	texture_rect.visible = false
	credits.visible = true
