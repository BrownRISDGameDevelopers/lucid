extends Node3D

@onready var anim: AnimatedSprite3D = $AnimatedSprite3D

func _ready() -> void:
	print("Jumpanim: Ready")
	anim.connect("animation_finished", Callable(self, "_on_finished"))
	anim.play()

func _on_finished() -> void:
	print("Animation finished")
	call_deferred("queue_free")
