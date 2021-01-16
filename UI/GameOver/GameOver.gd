extends Control

func _input(event):
	if $MarginContainer/CenterContainer/Button.pressed:
		get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
		queue_free()
