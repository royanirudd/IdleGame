extends Button



const AMT_WOOD_TO_TRADE: int = 10


func _ready():
	pressed.connect(_on_pressed)
	text = "Trade %d Wood for %f Gold" % [AMT_WOOD_TO_TRADE, (AMT_WOOD_TO_TRADE * ManagerGold.GOLD_PER_WOOD)]

func _on_pressed() -> void:
	ManagerGold.ref.trade_wood_for_gold(AMT_WOOD_TO_TRADE)
