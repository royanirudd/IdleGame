extends Node

class_name ManagerWood


static var ref: ManagerWood


#Upon initialization checks if there is already a reference, if not make itself ref, if there is delete itself.
func _init():
	if !ref: ref = self
	else: queue_free()


#Signals to be emitted
signal wood_updated   #anytime wood is updated
signal wood_created(amt: int) #anytime wood is created
signal wood_spent(amt: int) #anytime wood is spent


@onready var data: DataWood = Game.ref._data.data_wood



func get_wood() -> int:
	return data.wood

func create_wood(amt: int) -> void:
	if amt <=0: return
	data.wood += amt
	wood_created.emit(amt)
	wood_updated.emit()

func can_spend_wood(amt: int) -> bool:
	if amt < 0: return false
	if amt>data.wood: return false
	return true

#Returns error for game to deal with, read error enum godot documentation
func spend_wood(amt: int) -> Error:
	if amt <0: return Error.FAILED
	if amt>data.wood: return Error.FAILED
	data.wood -= amt
	wood_spent.emit(amt)
	wood_updated.emit()
	return Error.OK
