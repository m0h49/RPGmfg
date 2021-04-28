extends Control

func _input(event):
	if $MarginContainer/CenterContainer/VBoxContainer/Button.pressed:
		get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
		queue_free()
		
		
