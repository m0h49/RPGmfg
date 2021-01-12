extends Node2D

const Bat = preload("res://Enemies/Bat.tscn")

var data_player = LoadSave.new()


func _input(event):
	# Временная кастыль, потом сделать нормальную меню
	if event.is_action_pressed("ui_cancel"):
		data_player.save_game()
		get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
		queue_free()
		
		
func _ready():
	$ExitDoor.connect("leaving_level", self, "reload_level")


func reload_level():
	get_tree().change_scene("res://Generated World/World.tscn")
