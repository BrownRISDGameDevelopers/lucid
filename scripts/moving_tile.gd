#extends Tile
#
#class_name MovingTile
#
##@export var goals : Array[Tile] = []
#@export var goal : Tile
#@export var speedMultiplier = 0.1;
#var actual_speed;
#@onready var block_offset: Vector3
#
##Overrides the Tile implimentation
#func _ready():
	#super._ready()
	#goal.visible = false
	#if (is_foreground):
		#block_offset = Vector3(0,0.5,0)
	#else:
		#block_offset = Vector3(0,-0.5,0)
##Hi
##func next_target(target : Tile):
#
#func _update_speed():
	#if goal:
		#actual_speed = ((goal.get_my_active_edge_pos()) - self.get_my_active_edge_pos()).length() * speedMultiplier
	#
#
#func _physics_process(delta : float):
	#_update_speed()
	#global_position = global_position.move_toward(goal.get_my_active_edge_pos() + block_offset, delta * actual_speed)
