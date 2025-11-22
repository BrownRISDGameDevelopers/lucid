@tool
extends MeshInstance3D

func _ready():
	if Engine.is_editor_hint():
		# Code to make it visible in editor
		show() 
#	else:
		# Code to hide it in game
		#hide() 
