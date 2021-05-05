extends PanelContainer

onready var icon = $TextureRect
onready var count = $Label

const path_to_items_icons = "res://UI/MenuInventory/TEST_del/%s.png"

func set_data(item_data):
	icon.texture = load(path_to_items_icons % item_data.type) #Динамическая загрузка иконки
	count.text = str(item_data.count)
