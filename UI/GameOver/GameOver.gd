extends Control

func _input(_event: InputEvent) -> void:
	if $MarginContainer/CenterContainer/VBoxContainer/Button.pressed:
		var _err = get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
		queue_free()
		
		
