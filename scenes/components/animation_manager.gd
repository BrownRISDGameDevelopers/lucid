extends Node3D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var player: LucidPlayer = $".."
var spin_direction = -1
var to_spin = false
var flipping = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var current_blend: Vector2 = animation_tree.get("parameters/blend_position")
	
	var target_blend = Vector2(0, 0)
	
	if (player.target_tile != null and !player.deny_new_path):
		target_blend = Vector2(-1, 0)
	elif (player.deny_new_path and flipping):
		target_blend = Vector2(0, 1)
	else:
		target_blend = Vector2(1, 0)

	
	if (player.deny_new_path):
		if (flipping):
			var flip_speed = player.actual_speed
			player._update_speed()
			var distance = player.actual_speed / player.speedMultiplier
			player.actual_speed = flip_speed
			flip_rotate(PI * delta * flip_speed / (distance - 2))
		pass
	if (!player.deny_new_path and flipping):
		flipping = false
		player.visible = true
		if (player.is_flipped):
			player.rotation.x = PI
			spin_direction = 1
			player.rotation.y += PI
		else:
			player.rotation.x = 0
		player.rotation.z = 0
		
	var new_blend: Vector2 = current_blend.lerp(target_blend, delta * 5.0)
	animation_tree.set("parameters/blend_position", new_blend)

func do_flip() -> void:
	#animation_tree.set("parameters/blend_position",Vector2(0, 1))
	#suppress physics proccess while this is happening
	flipping = true

func flip_rotate(rot_speed: float) -> void:
	# Yes, we do have to do this weird lazy evaluation of the
	# x axis rotation.  Godot has some automatic process
	# that messes with the rotation of objects between
	# method calls that makes it hard to keep x outside the
	# usual -PI/2 to PI/2 range
	if (to_spin):
		player.rotation.x -= PI/2
		to_spin = false
		player.visible = true
	player.rotation.x += spin_direction * rot_speed
	#print(player.rotation.x)
	if (abs(player.rotation.x - spin_direction * PI / 2) < rot_speed):
		if (spin_direction < 0):
			# The player is reset to standing for one frame
			# so it looks better to hide them for that frame
			player.visible = false
			player.rotation.x = 0
			player.rotation.z = -PI
			player.rotation.y += PI
			spin_direction *= -1
			to_spin = true
			# Make sure we don't land invisible
			flip_rotate(rot_speed)
		else:
			spin_direction *= -1
			player.rotation.x = PI/2
			player.rotation.y -= PI
			player.rotation.z = 0
	pass
