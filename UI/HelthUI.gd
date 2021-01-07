extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts
var life = 100 setget set_life
var max_life = 100 setget set_max_life

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty
onready var lifeUIFull = $LifeUIFull
onready var lifeUIEmpty = $LifeUIEmpty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15
		
func set_life(value):
	life = clamp(value, 0, max_life)
	if lifeUIFull != null:
		lifeUIFull.rect_size.x = life
		
func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * 15
		
func set_max_life(value):
	max_life = max(value, 1)
	self.life = min(life, max_life)
	if lifeUIEmpty != null:
		lifeUIEmpty.rect_size.x = max_life
		
func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	self.max_life = PlayerStats.max_life
	self.life = PlayerStats.life
	# warning-ignore:return_value_discarded
	PlayerStats.connect("life_changed", self, "set_life")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("max_life_changed", self, "set_max_life")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed", self, "set_hearts")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")
