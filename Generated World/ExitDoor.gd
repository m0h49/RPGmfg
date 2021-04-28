<<<<<<< HEAD
extends Area2D

export var point_spawn = Vector2.ZERO

var data_player = LoadSave.new()
signal leaving_level

func _on_ExitDoor_body_entered(_body):
	data_player.save_game()
	Global.position_spawn = point_spawn
	emit_signal("leaving_level")
=======
extends Area2D

export var point_spawn = Vector2.ZERO

var data_player = LoadSave.new()
signal leaving_level

func _on_ExitDoor_body_entered(_body):
	data_player.save_game()
	Global.position_spawn = point_spawn
	emit_signal("leaving_level")
>>>>>>> 26e79be9d32a1b1459404f8f7bdec9fbae2a3e7d
