extends Node3D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var player: LucidPlayer = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var current_blend: Vector2 = animation_tree.get("parameters/blend_position")
	var target_blend: Vector2 = Vector2(-1, 0) if player.target_tile != null and !player.deny_new_path else Vector2(1, 0)
	var new_blend: Vector2 = current_blend.lerp(target_blend, delta * 5.0)
	animation_tree.set("parameters/blend_position", new_blend)

func do_flip() -> void:
	animation_tree.set("parameters/blend_position",Vector2(0, 1))
#	suppress physics proccess while this is happening
	pass
