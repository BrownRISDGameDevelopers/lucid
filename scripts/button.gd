@warning_ignore("missing_tool")
extends Tile

#The assigned moving tile
@export var moving_tile : Tile
#The assigned position of the moving tile
@export var goal : MoveGoal

@onready var gameManager: GameManager = get_parent().get_parent();

signal button_pressed()

func _ready():
	connect("button_pressed", Callable(moving_tile, "button_pressed"))

func my_static_body3d_clicked():
	if (moving_tile.goal == goal):
		moving_tile.my_static_body3d_clicked()
		if (gameManager.get_current_tile() == moving_tile):
			emit_signal("button_pressed")
