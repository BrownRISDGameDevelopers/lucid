extends Node

@export var topWaterfall : Waterfall
@export var bottomWaterfall : Waterfall

# The purpose of this script is to tell the bottom waterfall when the top
# waterfall finishes.
# We need one of these for each top and bottom waterfall we have.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	topWaterfall.activation_finish.connect(func(): bottomWaterfall.start_waterfall())
	topWaterfall.shutoff_finish.connect(func(): bottomWaterfall.stop_waterfall())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("stop_waterfall_debug"):
		if !topWaterfall.flowing:
			print("Start the waterfall")
			topWaterfall.start_waterfall()
		else:
			print("end the waterfall")
			topWaterfall.stop_waterfall()
