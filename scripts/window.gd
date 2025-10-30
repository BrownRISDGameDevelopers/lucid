extends Node

func _ready():
	$SubViewportContainer.connect("size_changed", Callable(self, "_update_subviewport_size"))
	_update_subviewport_size()


func _update_subviewport_size():
	var size = $SubViewportContainer.get_size()
	print(size)
	$SubViewportContainer.size = size
