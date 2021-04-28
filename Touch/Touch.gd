extends Control

#var touch_hiden = false
#onready var touch_controller = get_node(".")

#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("ui_cancel") and not touch_hiden:
#		touch_hiden = true
#		touch_controller.visible = false
