extends Control

export (int, 1, 20) var columns = 8 # кол-во столбцов инвентаря
export (int, 1, 20) var rows = 4 # кол-во строчек инвентаря

const slot_scene = preload("res://UI/MenuInventory/SlotContainer.tscn") # Подгружаем при компиляции сцену слота

onready var inv = $PanelContainer/GridContainer # Хранилище слотов
onready var titem = $TempItemUI # Временный итем, нужен для отображения перетаскивания

onready var rng = RandomNumberGenerator.new() # Инициализация объекта класса рандомайзера

onready var item_dragging = null # Здесь хранится итем при перетаскивании
onready var prev_slot = null # Слот которого мы перетаскиваем итем

onready var clearButton = $PanelContainer/HBoxContainer/Clear
onready var addButton = $PanelContainer/HBoxContainer/Add

func _ready() -> void:
	titem.visible = false # Скрываем временный итем
	rng.randomize() # Запускаем рандомайзер
	
	clearButton.connect("pressed", self, "clear_inventory")
	addButton.connect("pressed", self, "add_item")
	
	inv.columns = columns # Ограничиваем кол-во слолбцов отображения
	for _i in range(columns * rows - 1): # Цикл создания слотов
		var slot = slot_scene.instance() # Создаем объект слота
		
		slot.name = "Slot_%d" % _i # Задаем ему имя, в целом не обязательное действия, но для отладки удобно
		slot.get_node("Num").text = str(_i) # Как раз тот самый номер слота, если удаляете из сцены слота
											# тесктовое поле, то эту строчку тоже нужно удалить
		
		inv.add_child(slot) # Добавление слота в хранилище

func clear_inventory() -> void: # Функция очистки хранилища
	for child in inv.get_children(): # Пробегаем по чилдам инвентаря
		child.update_data() # Делаем апдейт без параметров

func has_empty_slot() -> bool: # Mетод проверки наличия хотя бы одной пустой ячейки
	for child in  inv.get_children(): # Пробегаем по чилдам инвентаря
		if child.empty():
			return true
	return false 
	
func get_empty_slot(): # Метод получения случайного пустой ячейки
	var slot = null
	if has_empty_slot():
		# Обязательно нужно проверить, что у нас есть пустые ячейки
		# Иначе при польном инвентаре будут бесконечный цикл при полном инвентаре и игра зависнет
		while slot == null: # Ищем случайную пустую ячейку, пока не найдем
			var temp_slot = inv.get_child(rng.randi_range(0, columns * rows))
			if temp_slot.empty():
				slot = temp_slot
				break
	return slot
	
func add_item() -> void: # Слот добавления случайного предмета, который подключен к кнопке
	var slot = get_empty_slot()
	if slot:
		var data = {"type": "", "count": 0}
		data.type = "item_type_" + str(rng.randi_range(1, 8))
		data.count = rng.randi_range(1, 999)
		slot.update_data(data)
		
func find_slot(pos:Vector2, need_data = false): # Метод пойска слота по координатам
	# Второй параметр - необязательный, он говорит функции искать в позиции слот с итемом или нет
	for c in inv.get_children(): # Пробегаем по чилдам инвентаря
		if (need_data and not c.empty()) or (not need_data):
			if Rect2(c.rect_position, c.rect_size).has_point(pos): # Создаем прямоугольник из координат слота и его размеров, чтобы
																	# легко одним методом проверить находится ли точка в этом прямоугольнике
				return c
	return null
	
func _process(_delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position() # Получаем позицию мышки
	if Input.get_mouse_button_mask() == BUTTON_LEFT: # Проверяем нажата ли левая кнопка мыши
		if not item_dragging: # Если мы уже не тащим элемент
			var slot = find_slot(mouse_pos, true) # Ищем под курсором слот с итемом
			if slot:  # Если слот не найден
				item_dragging = slot.item_data # Сохраняем в хранилище данный итема
				titem.set_data(item_dragging) # Во временный итем пихаем данный
				titem.visible = true # Показываем временный итем
				titem.rect_position = slot.rect_position # Перемещаем временный итем в координаты слота
				prev_slot = slot # Сохраняем слот из которого будем тащить итем
				slot.update_data() # Очищаем слот из которого тащим
			else: # Если мы уже тащим итем, то перемещаем временный итем под курсор, со смещением от половины размера (чтобы центр итем был под курсором)
				titem.rect_position = lerp(titem.rect_position, mouse_pos - titem.rect_size/2, 0.3)
	else: # Если кнопка отпущена
		if item_dragging: # Если у нас в хранилище есть итем
			var slot = find_slot(mouse_pos, false) # Ищет слот под курсором
			
			if slot: # Если он есть, то пытаемся закинуть в слот данный
				if not slot.update_data(item_dragging): # Если не получилось, то возвращаем итем обратно
					prev_slot.update_data(item_dragging)
				prev_slot = null # Очищаем ссылку на старом
				item_dragging = null # Сбрасываем хранилище итем
				titem.visible = false # Скрываем временный итем
				
