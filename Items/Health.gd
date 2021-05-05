extends Node2D

func drop():
	$AnimationPlayer.play("drop")

func start():
	$AnimationPlayer.play("idle")
	
func _ready() -> void:
	$AnimationPlayer.play("idle")

func _on_Hurtbox_body_entered(_body: Node) -> void:
	if _body.name == "Player":
		if PlayerStats.health < PlayerStats.max_health:
			PlayerStats.health += 1
		elif PlayerStats.health == PlayerStats.max_health:
			PlayerStats.max_health += 1
			PlayerStats.health += 1
		queue_free()
