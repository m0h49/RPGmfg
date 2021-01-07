extends Node
class_name LoadSave

const FILE_NAME = "user://savegame.save"

func get_data():
	var save_dict = {
		#"filename" : get_filename(),
		#"parent" : get_parent().get_path(),
		"life" : PlayerStats.life,
		"max_health" : PlayerStats.max_health,
		"health" : PlayerStats.health,
		"xp": PlayerStats.xp,
		"level" : PlayerStats.level
	}
	return save_dict
	
# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
func save_game():
	var save_game = File.new()
	save_game.open(FILE_NAME, File.WRITE)
	var player_data = get_data()
	print(player_data)
		
	# Store the save dictionary as a new line in the save file.
	save_game.store_string(to_json(player_data))
	save_game.close()

# Кастыль на кастыле
func load_game():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var player_data = parse_json(file.get_as_text())
		file.close()
		if typeof(player_data) == TYPE_DICTIONARY:
			PlayerStats.life = player_data.life
			PlayerStats.max_health = player_data.max_health
			PlayerStats.health = player_data.health
			PlayerStats.xp = player_data.xp
			PlayerStats.level = player_data.level
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")

func load_game_default():
	PlayerStats.life = 100
	PlayerStats.max_health = 4
	PlayerStats.health = 4
	PlayerStats.xp = 0
	PlayerStats.level = 1
