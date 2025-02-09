extends Node2D

const Player = preload("res://Player/Player.tscn")
const CameraRemoute = preload("res://Camera/Remote.tscn")

func _ready() -> void:
	var _err = $ExitDoor1.connect("leaving_level", self, "next_level")
	
	var player = Player.instance()
	get_node("/root/World/YSort").add_child(player) # add_child(player)
	player.position = Global.position_spawn # Vector2(-224, 16)
	#player.position = Vector2(150, 50)
	
	# testing
	$YSort/DirtCliffTileMap.set_cellv(Vector2(7, 7), 0)
	$YSort/DirtCliffTileMap.update_bitmask_region(Vector2(7,7), Vector2(7,7))
	
	var cameraRemoute = CameraRemoute.instance()
	get_node("/root/World/YSort/Player").add_child(cameraRemoute)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lbm_click"):
		print(PlayerStats.max_health, ", ", PlayerStats.health)
		
func next_level():
	var _err = get_tree().change_scene("res://World Dont Generated/World.tscn")
