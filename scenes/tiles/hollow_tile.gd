@tool
extends Tile

class_name HollowTile

# Tile to land on when falling through hollow tile.
@export var hollow_path: Tile

# Calls parent class ready()
func _ready() -> void:
	super._ready()
