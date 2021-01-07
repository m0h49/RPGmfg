extends Control

onready var buttonContinue = $MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/Continue
onready var buttonNewGame = $MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/NewGame
onready var buttonOptions = $MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/Options

var selected_menu = 0
var data_load = LoadSave.new()

func _ready():
	change_color()

func _input(_event):
	if buttonContinue.pressed:
		buttonContinue.modulate = Color.yellow
		get_tree().change_scene("res://Generated World/World.tscn")
		data_load.load_game()
	if buttonNewGame.pressed:
		buttonNewGame.modulate = Color.yellow
		get_tree().change_scene("res://Generated World/World.tscn")
		data_load.load_game_default()
	if buttonOptions.pressed:
		buttonOptions.modulate = Color.yellow
		get_tree().change_scene("res://UI/MainMenu/OptionsUI.tscn")
		
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 4;
		change_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu = selected_menu - 1
		else:
			selected_menu = 3
		change_color()
	
	elif Input.is_action_just_pressed("ui_select"):
		match selected_menu:
			0:
				# Continue
				get_tree().change_scene("res://Generated World/World.tscn")
				data_load.load_game()
				pass
			1: 
				# NewGame
				get_tree().change_scene("res://Generated World/World.tscn")
				data_load.load_game_default()
			2: 
				#Options
				get_tree().change_scene("res://UI/MainMenu/OptionsUI.tscn")
				pass
			3:
				#Version
				get_tree().change_scene("res://UI/MainMenu/Version.tscn")
				pass

func change_color():
	$MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/Continue.modulate = Color.white
	$MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/NewGame.modulate = Color.white
	$MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/Options.modulate = Color.white
	$MarginContainer/HBoxContainer/VBoxContainer/Version.modulate = Color.white
	
	match selected_menu:
		0:
			$MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/Continue.modulate = Color.yellow
		1:
			$MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/NewGame.modulate = Color.yellow
		2:
			$MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/Options.modulate = Color.yellow
		3:
			$MarginContainer/HBoxContainer/VBoxContainer/Version.modulate = Color.yellow
