extends Label

func _ready():
	_update_text()
	ManagerGold.ref.gold_updated.connect(_on_gold_updated)


func _update_text() -> void:
	text = "Gold: %s" %ManagerGold.ref.get_gold()


func _on_gold_updated() -> void:
	_update_text()
