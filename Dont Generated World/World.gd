extends Node2D

const Player = preload("res://Player/Player.tscn")
const CameraRemoute = preload("res://Camera/Remote.tscn")

var data_player = LoadSave.new()
		
func _ready():
	var _err = $ExitDoor1.connect("leaving_level", self, "next_level")
	_err = $ExitDoor2.connect("leaving_level", self, "next_level")
	
	var player = Player.instance()
	get_node("/root/World/YSort").add_child(player) # add_child(player)
	player.position = Global.position_spawn # Vector2(-224, 16)
	
	
	var cameraRemoute = CameraRemoute.instance()
	get_node("/root/World/YSort/Player").add_child(cameraRemoute)

func next_level():
	var _err = get_tree().change_scene("res://Generated World/World.tscn")
