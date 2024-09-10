extends Node

class_name ManagerGold

#Singleton pattern
static var ref: ManagerGold


#Upon initialization checks if there is already a reference, if not make itself ref, if there is delete itself.
func _init():
	if !ref: ref = self
	else: queue_free()


const GOLD_PER_WOOD: float = 0.1


#Signals to be emitted
signal gold_updated   #anytime gold is updated
signal gold_traded(amt: int) #anytime gold is created
signal gold_spent(amt: int) #anytime gold is spent

@onready var data: DataGold = Game.ref._data.data_gold

func get_gold() -> float:
	return data.gold

func trade_wood_for_gold(amt: int) -> void:
	if amt <=0: return
	if !ManagerWood.ref.can_spend_wood(amt): return 
	ManagerWood.ref.spend_wood(amt)
	data.gold+= float(amt*GOLD_PER_WOOD)
	gold_traded.emit(amt)
	gold_updated.emit()

func can_spend_gold(amt: int) -> bool:
	if amt < 0: return false
	if amt>data.gold: return false
	return true

#Returns error for game to deal with, read error enum godot documentation
func spend_gold(amt: int) -> Error:
	if amt <0: return Error.FAILED
	if amt>data.gold: return Error.FAILED
	data.gold -= amt
	gold_spent.emit(amt)
	gold_updated.emit()
	return Error.OK

