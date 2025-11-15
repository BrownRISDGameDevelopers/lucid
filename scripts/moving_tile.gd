extends Tile

# The list of positions that the tile cycles through.
# On initiation, set this to the list of positions that
# WITHOUT includiong the starting position.  List these
# postions in the order they should be visited
@export var goals : Array[MoveGoal] = []

# The starting position
@export var goal : MoveGoal

enum activation {CLICK, WAIT}

signal move_complete()

@export var activation_cond : activation = activation.CLICK

# The matrix of neighors for each position.
# similar to goals, this should NOT include the neighbors
# list of the starting position.  Instead, assign that in
# the neighbors variable like you would any other tile.
# To assign subsequent positions corresponding neighbors,
# create a TileArray2DRow node for each beyond the starting position.
# link them in order with their "next" variables, but DON'T
# link the last one to the first in a cylce.
# In each of these nodes, you can set a list of neighbors for
# the corresponding position.

var speed = 5;
var moving = false;

@onready var gameManager: GameManager = get_parent().get_parent();


func _ready():
	neighbors = goal._get_neighbors()
	if activation_cond == activation.WAIT:
		connect("move_complete", _on_move_complete)
		wait_loop()
	else: connect("move_complete", _on_move_complete_stop)
		

# This function works the same as it does for tile, but
# will make the tile move when it's clicked with the player
# standing on it
func my_static_body3d_clicked():
	print("Tile: my_static_body3d_clicked")
	# Include this part to have the tile start moving when clicked with the player on it
	if (gameManager.get_current_tile() == self && activation_cond == activation.CLICK):
		activate()
	else:
		emit_signal("cube_clicked", self)

# This function makes the tile start moving to it's next position
# if the player is on the tile, it will force the player to move
# with itself until this motion is complete

func wait_loop():
	await get_tree().create_timer(3.0).timeout
	activate()
	
func _on_move_complete():
	print("complete!")
	wait_loop()

func _on_move_complete_stop():
	return

func activate():
	#emit_signal("tile_moving", self)
	
	# cycles the target positions by one so that
	# the next time it moves it goes to the next target
	goals.push_back(goal)
	goal = goals.pop_front()

	neighbors = goal._get_neighbors()
	
	gravity_path = goal.gravity_path

	# makes the player move with the tile
	if (gameManager.get_current_tile() == self):
		gameManager.lock_player(self, speed)
		
	moving = true
	print(goal.global_position)

# Only moves when moving is true, unlocking the player
# and setting moving to false when it reaches a destination
func _physics_process(delta : float):
	if (moving):
		global_position = global_position.move_toward(goal.global_position, delta * speed)
		print(goal.global_position)
		if (global_position == goal.global_position):
			moving = false
			gameManager.unlock_player()
			emit_signal("move_complete")
