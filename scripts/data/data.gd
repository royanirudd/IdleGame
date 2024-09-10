extends Resource
class_name Data


#This will contain data save and load

#Current data objects
@export var data_wood: DataWood = DataWood.new()

@export var data_gold: DataGold = DataGold.new()

@export var inventory: Inventory = Inventory.new()

var data_skills: DataSkill = DataSkill.new()

#@export var settings

