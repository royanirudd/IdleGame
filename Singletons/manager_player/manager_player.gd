extends Node
class_name ManagerPlayer


static var ref: ManagerPlayer


#Upon initialization checks if there is already a reference, if not make itself ref, if there is delete itself.
func _init() -> void:
	if !ref: ref = self
	else: queue_free()


#Signals to be emitted
signal leveled_up(skill: Skills)

enum Skills {
	WOODCUTTING
}

@onready var inventory: Inventory = Game.ref._data.inventory

@onready var data_skill: DataSkill = Game.ref._data.data_skills



func add_item(item_name: String, quantity:int = 1) -> Error:
	if quantity > inventory.max_item:
		return Error.FAILED
	if item_name in inventory.inventory and inventory.inventory[item_name] + quantity <= inventory.max_item:
		inventory.inventory[item_name] += quantity
		return Error.OK
	else:
		return Error.FAILED


func remove_item(item_name: String, quantity: int = 1) -> Error:
	if item_name in inventory.inventory:
		inventory.inventory[item_name] -= quantity
		return Error.OK
	else:
		return Error.FAILED

func get_inventory() -> Dictionary:
	return inventory.inventory

func get_level(skill: Skills) -> int:
	var key: String = get_key(skill)
	if key == "error": return -1
	return data_skill.levels[key]["level"]



func add_experience(skill: Skills, experience: int) -> Error:
	var key: String = get_key(skill)
	if key == "error": return Error.FAILED
	
	if data_skill.levels[key]["level"] >= data_skill.max_lvl: return Error.FAILED
	
	data_skill.levels[key]["experience_till_nextlvl"] -= experience
	if data_skill.levels[key]["experience_till_nextlvl"] <= 0: _lvl_up(skill, key)
	return Error.OK

func get_key(skill: Skills) -> String:
	match skill:
		Skills.WOODCUTTING:
			return "WOODCUTTING"
	return "error"

func _lvl_up(skill: Skills, key: String) -> void:
	
	data_skill.levels[key]["level"] += 1
	#If max lvl, just return so we dont break out of bounds
	if data_skill.levels[key]["level"] >= data_skill.max_lvl: return
	
	data_skill.levels[key]["experience_till_nextlvl"] += data_skill.level_requirements[data_skill.levels[key]["level"]]
	#emit level up
	leveled_up.emit(skill)
	
	if data_skill.levels[key]["experience_till_nextlvl"] <= 0: _lvl_up(skill, key)
	print("Level up! to:",data_skill.levels[key]["level"])
func get_bonus(skill: Skills) -> float:
	return (get_level(skill)/100.0)
	#get 1% bonus per level
