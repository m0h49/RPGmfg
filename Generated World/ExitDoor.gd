extends Area2D
var data_player = LoadSave.new()
signal leaving_level

func _on_ExitDoor_body_entered(_body):
	data_player.save_game()
	emit_signal("leaving_level")
