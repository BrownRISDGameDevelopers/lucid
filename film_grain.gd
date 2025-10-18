extends TextureRect

@onready var rng = RandomNumberGenerator.new()


@export var seconds_between_film_swaps = 0

var seconds_since_last_swap = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	seconds_since_last_swap += delta
	if seconds_between_film_swaps < seconds_since_last_swap:
		texture.noise.seed = rng.randi()
		seconds_since_last_swap = 0
