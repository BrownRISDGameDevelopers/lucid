extends Node
class_name TileArray2D # This line makes the class available to other scripts

# A linked list representation of a 2D array of Tiles
# Not generalized because Godot doesn't have type parameters (e.g. the <T> in ArrayList<T> in Java)

@export var row: Array[Tile]
@export var next: TileArray2D

# Constructor method for a row, takes in an array that it holds
static func new_array2D(arr: Array[Tile]):
	var new_array = TileArray2D.new()
	new_array.row = arr
	if arr != [null]:
		new_array.next = new_array2D([null])
	return new_array
	
# Adds a new array to the 2D array as a new row below all the current ones
# Traverses to the bottom of the current 2D Array to add the row
func append(arr: Array[Tile]):
	if next && next.peek() != [null]:
		next.append(arr)
	else:
		next = new_array2D(arr)

# Returns the top row of the table
func peek():
	return row

# Returns the top row of the table and removes it
func pop():
	var hold_row = row
	if next && next.peek() != [null]:
		row = next.pop()
	else:
		row = [null]
	return hold_row
