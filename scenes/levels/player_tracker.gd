extends SpotLight3D


@export var player : LucidPlayer

func _physics_process(delta: float):
	look_at(player.global_position)
