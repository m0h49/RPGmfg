extends Control

var mute = false
var data_player = LoadSave.new()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		show()
		get_node("../Touch").hide()
		$MarginContainer/Menu.popup()
		get_tree().paused = true
		

func _on_Resume_pressed():
	$MarginContainer/Menu.hide()
	get_node("../Touch").show()
	hide()
	get_tree().paused = false

func _on_SaveGame_pressed():
	data_player.save_game()

func _on_LoadGame_pressed():
	data_player.load_game()

func _on_Options_pressed():
	$MarginContainer/Menu.hide()
	$MarginContainer/Options.popup()

func _on_Return_pressed():
	var _err = get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
	get_tree().paused = false


# Menu/Options

func _on_FPS_pressed():
	pass # Replace with function body.

func _on_Mute_pressed():
	if not mute:
		AudioServer.set_bus_mute(0, true)
		mute = true
	elif mute:
		AudioServer.set_bus_mute(0, false)
		mute = false

func _on_Volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

func _on_Cancel_pressed():
	$MarginContainer/Options.hide()
	$MarginContainer/Menu.popup()

