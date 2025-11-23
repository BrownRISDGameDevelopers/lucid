extends Control

@export var main_menu: bool
#
#func _on_back_pressed() -> void:
	#print(self, " back pressed")
func _on_back_pressed() -> void:
	print("credits.gd: ON BACK PRESSED")
	visible = false
#	lol, lmao even
	if main_menu:
		var texture_rect: TextureRect = $"../TextureRect"
		var title: TextureRect = $"../Title"
		var v_box_container: VBoxContainer = $"../VBoxContainer"
		title.visible = true
		texture_rect.visible = true
		v_box_container.visible = true
	else:
		print("BACK PRESSED")
		var pause_menu: TextureRect = $"../PauseMenu"
		var v_box_container: VBoxContainer = $"../VBoxContainer"
		pause_menu.visible = true
		v_box_container.visible = true
