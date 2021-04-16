extends Control

var xp = 0 setget set_xp
var max_xp = 100 setget set_max_xp
var level = 1 setget set_level

onready var xpUIFull = $XPUIFull
onready var xpUIEmpty = $XPUIEmpty
onready var levelUI = $LevelUI/Label

func set_xp(value):
	xp = clamp(value, 0, max_xp)
	if xpUIFull != null:
		xpUIFull.rect_size.x = xp
	if xp == 100:
		PlayerStats.level += 1
		PlayerStats.xp = 0
		
func set_max_xp(value):
	max_xp = max(value, 1)
	self.xp = min(xp, max_xp)
	if xpUIEmpty != null:
		xpUIEmpty.rect_size.x = max_xp
		
func set_level(value):
	level = value
	levelUI.text = str(PlayerStats.level)
		
func _ready():
	self.max_xp = PlayerStats.max_xp
	self.xp = PlayerStats.xp
	self.level = PlayerStats.level
	# warning-ignore:return_value_discarded
	PlayerStats.connect("level_changed", self, "set_level")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("xp_changed", self, "set_xp")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("max_xp_changed", self, "set_max_xp")
