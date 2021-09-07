extends Node2D

# used for the random walls
var rng = RandomNumberGenerator.new()

# used for checks and map-creation
const TILESIZE : int = 16
const MAP_WIDTH : int = 40
const MAP_HEIGHT : int = 23
const PYLONS_X = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
const PYLONS_Y = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
const WALLS_X = [2, 36]
const WALLS_Y = [2, 20]
const FREE_TILE = 0
const WALL_TILE = 1
const DIAGONALS = [Vector2(-1, -1), Vector2(1, -1), Vector2(-1, 1), Vector2(1, 1)]

# mapping vars
var MAP_ARRAY = []

# saving vars for comparison and placement
var LAST_MOUSE_VECTOR : Vector2 = Vector2.ZERO
var last_printed_vector : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# convert pixel_pos to grid_pos for tilemap
func mouse_pos_to_grid(pos):
	# convert global_position to grid position
	pos = Vector2(int(pos.x / TILESIZE), int(pos.y / TILESIZE))
	
	# update grid_pos
	LAST_MOUSE_VECTOR = pos


# used to check the map while creating
func print_vector(vector):
	if last_printed_vector != vector:
		print(vector)
		last_printed_vector = vector 


# if true, a wall can be set
func wall_randomizer():
	var dice = rng.randi_range(1, 100)
	
	if dice >= 65:
		return true
	else:
		return false


# used to test map creation
func print_map_array():
	print("Size of Array: " + String(MAP_ARRAY.size()))
	for array in Global.MAP_ARRAY:
		print(array)


# returns diagonals of a vector
# used to remove bad placed walls in map generation
func return_diagonal_vectors(vector):
	var diagonal_array = []
	
	for dia in DIAGONALS:
		diagonal_array.append(vector + dia)
	return diagonal_array
