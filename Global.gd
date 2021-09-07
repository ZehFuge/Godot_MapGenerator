extends Node2D

# used for the random walls
var rng = RandomNumberGenerator.new()

# used for checks and map-creation
const TILESIZE : int = 16
const MAP_WIDTH : int = 39
const MAP_HEIGHT : int = 22
const PYLONS_X = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38]
const PYLONS_Y = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
const WALLS_X = [2, 36]
const WALLS_Y = [2, 20]

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
	
	if dice >= 70:
		return true
	else:
		return false
