extends Node


@onready var floor_indicator_default: TextureRect = $FloorIndicatorDefault
@onready var floor_pop_up: TextureRect = $FloorPopUp
@onready var button_indicator_default: TextureRect = $ButtonIndicatorDefault


func click_indicator(toggle: bool):
	floor_indicator_default.visible = toggle
	floor_pop_up.visible = toggle;
	
func gravity_indicator(toggle: bool):
	floor_indicator_default.visible = toggle

func button_indicator(toggle: bool):
	button_indicator_default.visible = toggle
