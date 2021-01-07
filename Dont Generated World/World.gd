extends Node2D

var data_player = LoadSave.new()

func _input(event):
	# Временная кастыль, потом сделать нормальную меню
	if event.is_action_pressed("ui_cancel"):
		data_player.save_game()
		get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
		queue_free()
