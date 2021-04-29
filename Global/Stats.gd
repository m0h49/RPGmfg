extends Node

export(int) var max_life = 1 setget set_max_life
var life = max_life setget set_life
export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health
export(int) var max_xp = 100 setget set_max_xp
var xp = max_xp setget set_xp
export(int) var level = 1 setget set_level
var count_level_up = 1

signal no_life
signal no_health
signal life_changed(value)
signal max_life_changed(value)
signal health_changed(value)
signal max_health_changed(value)
signal xp_changed(value)
signal max_xp_changed(value)
signal level_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)
	
func set_max_life(value):
	max_life = value
	self.life = min(life, max_life)
	emit_signal("max_life_changed", max_life)
	
func set_max_xp(value):
	max_xp = value
	self.xp = min(xp, max_xp)
	emit_signal("max_xp_changed", max_xp)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
		
func set_life(value):
	life = value
	emit_signal("life_changed", life)
	if health <= 0 and life <= 0:
		emit_signal("no_life")

func set_xp(value):
	xp = value
	emit_signal("xp_changed", xp)
	
func set_level(value):
	level = value
	emit_signal("level_changed", level)
	# Мой кастыль который добавляет health/maz_halth после каждого пятого уровня
	count_level_up += 1
	if count_level_up == 5 :
		if max_health > health:
			health += 1
			emit_signal("health_changed", health)
		elif max_health <= health:
			max_health += 1
			health += 1
			emit_signal("max_health_changed", health)
			emit_signal("health_changed", max_health)
		count_level_up = 0
	if level == 1 and count_level_up > 1:
		count_level_up = 1

func _ready():
	self.life = max_life
	self.health = max_health
	self.xp = 0
