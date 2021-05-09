extends Node

var position_spawn =  Vector2(-224, 16)
var fps_output = false

func _ready() -> void:
	Console.add_command('set_max_health', PlayerStats, 'max_health')\
		.set_description('Set health')\
		.add_argument('health', Console.IntRangeType.new(0, 10, 0.5))\
		.register()
		
	Console.add_command('set_health', PlayerStats, 'health')\
		.set_description('Set health')\
		.add_argument('health', Console.IntRangeType.new(0, 10, 0.5))\
		.register()
