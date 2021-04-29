extends Node2D

const Player = preload("res://Player/Player.tscn")
const CameraRemoute = preload("res://Camera/Remote.tscn")
		
func _ready():
	var _err = $ExitDoor1.connect("leaving_level", self, "next_level")
	_err = $ExitDoor2.connect("leaving_level", self, "next_level")
	_err = $ExitDoor3.connect("leaving_level", self, "next_level_water")
	
	var player = Player.instance()
	get_node("/root/World/YSort").add_child(player) # add_child(player)
	player.position = Global.position_spawn # Vector2(-224, 16)
	
	
	var cameraRemoute = CameraRemoute.instance()
	get_node("/root/World/YSort/Player").add_child(cameraRemoute)

func next_level():
	var _err = get_tree().change_scene("res://World Generated/World.tscn")
func next_level_water():
	var _err = get_tree().change_scene("res://World Exp/World.tscn")


func _on_OpenEntranc1_area_exited(_area: Area2D) -> void:
	$YSort/DirtCliffTileMap.set_cellv(Vector2(6, 15), -1)
	$YSort/DirtCliffTileMap.set_cellv(Vector2(7, 15), -1)
	$YSort/DirtCliffTileMap.set_cellv(Vector2(6, 16), -1)
	$YSort/DirtCliffTileMap.set_cellv(Vector2(7, 16), -1)
	$YSort/DirtCliffTileMap.update_bitmask_region(Vector2(6, 15), Vector2(7, 16))

func _on_OpenEntranc2_area_exited(_area: Area2D) -> void:
	$YSort/DirtCliffTileMap.set_cellv(Vector2(12, -3), -1)
	$YSort/DirtCliffTileMap.set_cellv(Vector2(12, -2), -1)
	$YSort/DirtCliffTileMap.update_bitmask_region(Vector2(12, -3), Vector2(12, -2))
	
