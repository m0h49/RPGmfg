extends Node2D

const GrassEffect = preload("res://Effects/GrassEffectGreen.tscn")
const Health = preload("res://Items/Health.tscn")

var rnd = RandomNumberGenerator.new()

func create_grass_effect():
	
	var grassEffect = GrassEffect.instance()
	#var world = get_tree().current_scene
	get_parent().add_child(grassEffect) #world.add_child(grassEffect)  
	grassEffect.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()


func _on_Hurtbox_area_exited(_area: Area2D) -> void:
	rnd.randomize()
	var i = rnd.randi_range(0, 5)
	print(i) # debug
	if not i:
		var healtDrop = Health.instance()
		#var world = get_tree().current_scene
		get_parent().add_child(healtDrop) #world.add_child(healtDrop) 
		healtDrop.global_position = global_position + Vector2(8, 8)
