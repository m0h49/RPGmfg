extends MarginContainer

func _input(event):
	if $VBoxContainer/HBoxContainer/Button.pressed:
		get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
