extends Node2D

var data_player = LoadSave.new()

const Player = preload("res://Player/Player.tscn")
#const Exit = preload("res://Levels/ExitDoor.tscn")
#---------------------------------------------------
const CameraRemoute = preload("res://Camera/Remote.tscn")
const Bat = preload("res://Enemies/Bat.tscn")
const Bush = preload("res://World/Bush.tscn")
const Grass = preload("res://World/Grass.tscn")
const Wood = preload("res://World/Tree.tscn")

var taken_walks = []
var big_borders = Rect2(1, 1, 38, 21)
#var small_borders = Rect2(1, 1, 40, 23)

onready var dirtCliffTileMap = $YSort/DirtCliffTileMap
#onready var dirtPathTileMap = $DirtPathTileMap

func _ready():
	randomize()
	generate_level()
	
	
func generate_level():
	var walker = Walker.new(Vector2(1, 11), big_borders) # var walker = Walker.new(Vector2(1, 11), borders)
	var map = walker.walk(800)
	
	var player = Player.instance()
	get_node("/root/World/YSort").add_child(player) # add_child(player)
	player.position = Global.position_spawn #Vector2(-8, 350) # player.position = map.front() * 32
	
	#-----------------------------------------------------------
	var cameraRemoute = CameraRemoute.instance()
	get_node("/root/World/YSort/Player").add_child(cameraRemoute)
	
	#var exit = Exit.instance()
	#add_child(exit)
	#exit.position = walker.get_end_room().position * 32
	#exit.connect("leaving_level", self, "reload_level")
	var _err = $ExitDoor1.connect("leaving_level", self, "back_level")
	_err = $ExitDoor2.connect("leaving_level", self, "back_level")
	
	add_item(Bat, map, "/root/World/YSort")
	add_item(Bush, map, "/root/World/YSort/Bushes")
	add_item(Grass, map, "/root/World/YSort/Grass")
	add_item(Wood, map, "/root/World/YSort/Trees")
	
	walker.queue_free()
	# Location add
	for location in map:
		dirtCliffTileMap.set_cellv(location, -1)
	dirtCliffTileMap.update_bitmask_region(big_borders.position, big_borders.end)
		
func reload_level():
	var _err = get_tree().reload_current_scene()
	
func back_level():
	var _err = get_tree().change_scene("res://Dont Generated World/World.tscn")
	
	
func add_item(Obj, map, add_tree):
	var count = map.size()
	for obj_position in map:
		if count % (randi() % 500 + 1) == 0 and taken_walks.find(obj_position) == -1:
			
			
			if (obj_position.x * 32) < 100:
				if (obj_position.y * 32) > 400 and (obj_position.y * 32) < 250:
					obj_istance(Obj, obj_position, add_tree)
			elif(obj_position.x * 32) > 100:
				obj_istance(Obj, obj_position, add_tree)
			
			taken_walks.append(obj_position)
		count -= 1
		
func obj_istance(Obj, obj_position, add_tree):
	var obj = Obj.instance()
	
	obj.position = obj_position * 32
	obj.position.x = obj.position.x + 16
	obj.position.y = obj.position.y + 16
	
	get_node(add_tree).add_child(obj)
	

func _input(event):
	# Временная кастыль, потом сделать нормальную меню
	if event.is_action_pressed("ui_cancel"):
		data_player.save_game()
		var _err = get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
		queue_free()
		
	if event.is_action_pressed("ui_page_down"):
		reload_level()
		
func _physics_process(_delta):
	if PlayerStats.health <= 0:
		if PlayerStats.life <= 0:
			var _err = get_tree().change_scene("res://UI/GameOver/GameOver.tscn")
			queue_free()
