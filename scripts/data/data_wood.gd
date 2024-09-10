class_name DataWood
extends Resource



#Current ammount of wood
@export var wood: int

@export var generator_on: bool



func _init():
	wood = 0
	generator_on = false
