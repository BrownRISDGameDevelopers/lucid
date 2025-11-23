extends CanvasLayer
#

@onready var settings_pause: TextureRect = $PauseMenu
@onready var settings_quit_button: TextureButton = $VBoxContainer/QuitButton
@onready var settings_credits_button: TextureButton = $VBoxContainer/HBoxContainer/CreditsButton
@onready var settings_settings_button: TextureButton = $VBoxContainer/HBoxContainer/SettingsButton
@onready var settings_resume_button: TextureButton = $VBoxContainer/ResumeButton
@onready var settings_pause_button: Button = $PauseButton
@onready var credits: Control = $Credits

@onready var pause_menu: TextureRect = $PauseMenu
@onready var pause_button: Button = $PauseButton
@onready var v_box_container: VBoxContainer = $VBoxContainer

#
func _ready() -> void:
	settings_pause.visible = false
	settings_resume_button.visible = false
	settings_quit_button.visible = false
	settings_credits_button.visible = false
	settings_settings_button.visible = false

func _on_pause_button_pressed() -> void:
	print("PAUSE BUTTON PRESSED")
	get_tree().paused = true
	settings_pause.visible = true
	settings_pause_button.visible = false
	settings_resume_button.visible = true
	settings_quit_button.visible = true
	settings_credits_button.visible = true
	settings_settings_button.visible = true
	v_box_container.visible = true

func _on_resume_button_pressed() -> void:
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
	credits.visible = true
	pause_menu.visible = false
	v_box_container.visible = false


func _on_settings_button_pressed() -> void:
	pass
	#ChangeScene.change_scene(ChangeScene.settingsmain)
