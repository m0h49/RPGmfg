extends PanelContainer

onready var item = $ItemUI
#onready var item = $PanelContainer
#onready var icon = $PanelContainer/TextureRect
#onready var count = $PanelContainer/Label

var item_data = null

func _ready() -> void:
	var _err = update_data({"type": "item_type_1", "count": 0})

func empty():
	return item_data == null

func update_data(data = null) -> bool:
	item.visible = data != null
	item_data = data
	if data:
		item.set_data(item_data)
		#icon.texture = load("res://UI/MenuInventory/TEST_del/%s.png" % item_data.type) #Динамическая загрузка иконки
		#count.text = str(item_data.count)

	return true
