extends Control

var effect_mute = false
var menuOptions = false
var data_load = LoadSave.new()


func _on_LoadGame_pressed():
<<<<<<< HEAD
	var _err = get_tree().change_scene("res://World Dont Generated/World.tscn")
=======
	var _err = get_tree().change_scene("res://Dont Generated World/World.tscn")
>>>>>>> 26e79be9d32a1b1459404f8f7bdec9fbae2a3e7d
	Global.position_spawn = Vector2(915, 224)
	data_load.load_game()

func _on_NewGame_pressed():
<<<<<<< HEAD
	var _err = get_tree().change_scene("res://World Dont Generated/World.tscn")
=======
	var _err = get_tree().change_scene("res://Dont Generated World/World.tscn")
>>>>>>> 26e79be9d32a1b1459404f8f7bdec9fbae2a3e7d
	Global.position_spawn = Vector2(-224, 16)
	data_load.load_game_default()

func _on_Version_pressed():
	var _err = get_tree().change_scene("res://UI/MainMenu/Version.tscn")

func _on_Quit_pressed():
	get_tree().quit()

