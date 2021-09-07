extends TileMap

# creates the map
func _ready():
	Global.MAP_ARRAY = set_map_array()
	set_borders()
	set_pylons()
	set_walls()
	remove_diagonals()


func set_map_array():
	var appender = []
	for column in Global.MAP_WIDTH:
		appender.append([])
		for row in Global.MAP_HEIGHT:
			appender[column].append(0)
	return appender


# sets the border for the tilemap
func set_borders():
	var tileholder = get_used_cells()
	
	for tile in tileholder:
		if (tile.x == 0 and tile.y == 0) \
		or (tile.x != 0 and tile.y == 0) \
		or (tile.x == 0 and tile.y != 0) \
		or (tile.x == Global.MAP_WIDTH - 1) \
		or (tile.y == Global.MAP_HEIGHT - 1):
			Global.MAP_ARRAY[tile.x][tile.y] = Global.WALL_TILE
			set_cell(tile.x, tile.y, 1)


# sets bomberman-like pylons
func set_pylons():
	var tileholder = get_used_cells()
	
	for tile in tileholder:
		if tile.x in Global.PYLONS_X \
		and tile.y in Global.PYLONS_Y:
			Global.MAP_ARRAY[tile.x][tile.y] = Global.WALL_TILE
			set_cell(tile.x, tile.y, 1)


# fill area between pylons randomly
func set_walls():
	var tileholder = get_used_cells()
	
	for tile in tileholder:
		if (tile.x > Global.WALLS_X[0] and tile.x < Global.WALLS_X[1]) \
		and (tile.y > Global.WALLS_Y[0] and tile.y < Global.WALLS_Y[1]):
			var allowed = Global.wall_randomizer()
			
			if allowed:
				set_cell(tile.x, tile.y, 1)
				Global.MAP_ARRAY[tile.x][tile.y] = Global.WALL_TILE


# checks the diagonals for walls near the pylons and removes them
func remove_diagonals():
	for column in Global.PYLONS_X:
		for row in Global.PYLONS_Y:
			var diagonal_array = Global.return_diagonal_vectors(Vector2(column, row))
			
			for grid_pos in diagonal_array:
				if Global.MAP_ARRAY[grid_pos.x][grid_pos.y] == Global.WALL_TILE:
					set_cell(grid_pos.x, grid_pos.y, 0)
					Global.MAP_ARRAY[grid_pos.x][grid_pos.y] = Global.FREE_TILE


func _process(delta):
	input_handler()


# handle user input
func input_handler():
	if Input.is_action_pressed("place_tile"):
		place_tile()
	if Input.is_action_pressed("remove_tile"):
		remove_tile()


# set tile by mouse
func place_tile():
	set_cell(Global.LAST_MOUSE_VECTOR.x, Global.LAST_MOUSE_VECTOR.y, 1)
	Global.print_vector(Global.LAST_MOUSE_VECTOR)


# remove tile by mouse
func remove_tile():
	set_cell(Global.LAST_MOUSE_VECTOR.x, Global.LAST_MOUSE_VECTOR.y, 0)
	Global.print_vector(Global.LAST_MOUSE_VECTOR)
