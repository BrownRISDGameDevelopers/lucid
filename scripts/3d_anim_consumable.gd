extends Node3D

@onready var anim: AnimatedSprite3D = $AnimatedSprite3D

func _ready() -> void:
	print("Playing animation...")
	anim.connect("animation_finished", Callable(self, "_on_finished"))
	#anim.scale = Vector3(30,30,30)
	anim.play()

func _on_finished() -> void:
	call_deferred("queue_free")
