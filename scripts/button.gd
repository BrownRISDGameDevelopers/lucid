extends Node3D

class_name Interactable

@export var tile : Tile
@onready var gameManager: GameManager = get_parent()

signal button_clicked(this_button)



func my_static_body3d_clicked():
	if tile == gameManager.get_current_tile():
		emit_signal("button_clicked", self)
		print("Button clicked")
