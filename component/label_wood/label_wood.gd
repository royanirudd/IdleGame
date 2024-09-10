extends Label

func _ready():
	ManagerWood.ref.wood_updated.connect(_on_wood_updated)
	_update_text()
	


#updates label with wood value
func _update_text() -> void:
	text = "Wood: %s" %ManagerWood.ref.get_wood()


func _on_wood_updated() -> void:
	_update_text()
