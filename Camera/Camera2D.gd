extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var bottommRight = $Limits/BottomRight

func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottommRight.position.y
	limit_right = bottommRight.position.x
