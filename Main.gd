extends Node2D

func _process(delta):
	# keep grid_pos of mouse updated
	Global.mouse_pos_to_grid(get_global_mouse_position())
