@warning_ignore("missing_tool")
extends Tile

enum b_activation {ROTATE, MOVE, NONE}


@export var target_tile : Tile

@export var move_tile : Tile

@export var buttonType : b_activation

@export var gameManager: GameManager

@export var waterfall : Node

signal button_pressed()

func _ready():
	if buttonType == b_activation.ROTATE:
		connect("button_pressed", _on_r_button_click)
	if buttonType == b_activation.MOVE:
		connect("button_pressed", _on_m_button_click)
		
	if waterfall:
		connect("button_pressed", activate_waterfall)

func my_static_body3d_clicked():
	target_tile.my_static_body3d_clicked()
	
	#if (gameManager.get_current_tile() == target_tile):
	#	emit_signal("button_pressed")
	if (gameManager.get_current_tile() == target_tile):
		emit_signal("button_pressed")

func _on_r_button_click():
	gameManager.player_wants_to_rotate(self)

func _on_m_button_click():
	move_tile.activate()

func activate_waterfall():
	waterfall.toggle_waterfall()
