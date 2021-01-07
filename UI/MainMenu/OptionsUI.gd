extends Control

func _input(event):
	if $MarginContainer/VBoxContainer/HBoxContainer/Button.pressed:
		get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
