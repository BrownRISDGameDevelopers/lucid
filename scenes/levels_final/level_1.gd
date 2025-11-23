extends Node
#
@onready var settings_pause := $ViewportManager/UI/PauseMenu
@onready var settings_pause_button := $ViewportManager/UI/PauseButton
@onready var settings_resume_button := $ViewportManager/UI/VBoxContainer/VBoxContainer/ResumeButton
@onready var settings_quit_button := $ViewportManager/UI/VBoxContainer/VBoxContainer/QuitButton
@onready var settings_credits_button := $ViewportManager/UI/VBoxContainer/HBoxContainer/CreditsButton
@onready var settings_settings_button := $ViewportManager/UI/VBoxContainer/HBoxContainer/SettingsButton
#
func _ready() -> void:
	MusicController.bgm_play1()
	settings_pause.visible = false
	settings_resume_button.visible = false
	settings_quit_button.visible = false
	settings_credits_button.visible = false
	settings_settings_button.visible = false

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	settings_pause.visible = true
	settings_pause_button.visible = false
	settings_resume_button.visible = true
	settings_quit_button.visible = true
	settings_credits_button.visible = true
	settings_settings_button.visible = true

func _on_resume_button_pressed() -> void:
	print("resume pressed")
	get_tree().paused = false
	settings_pause.visible = false
	settings_pause_button.visible = true
	settings_resume_button.visible = false
	settings_quit_button.visible = false
	settings_credits_button.visible = false
	settings_settings_button.visible = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.credits)


func _on_settings_button_pressed() -> void:
	ChangeScene.change_scene(ChangeScene.settingsmain)
