extends Node2D

func _ready():
	self.global_position = Vector2(-10, -10)


func _process(delta):
	# keep sprite on mouse grid vector
	self.global_position = Vector2((Global.LAST_MOUSE_VECTOR.x * Global.TILESIZE), (Global.LAST_MOUSE_VECTOR.y * Global.TILESIZE))

