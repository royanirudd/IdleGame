extends Node
class_name SaveSystem


#Static class not singleton, with static save load methods

#.res is less readible but loadable
const SAVE_PATH: String = "user://save.tres"
const SHOULD_SAVE: bool = true
const SHOULD_LOAD: bool = true


static func save_data() -> void:
	if !SHOULD_SAVE: return
	ResourceSaver.save(Game.ref._data, SAVE_PATH)
	#Saves data into disc


static func load_data() -> void:
	if !SHOULD_LOAD: return 
	if !ResourceLoader.exists(SAVE_PATH): return
	#checks if save file exists or not
	Game.ref._data = load(SAVE_PATH)
