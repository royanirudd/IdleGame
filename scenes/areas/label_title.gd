extends Label


func _ready():
	ManagerPlayer.ref.leveled_up.connect(_on_skill_leveled_up)
	_update_text()

func _update_text() -> void:
	text = "Woodcutting lvl: %d" %ManagerPlayer.ref.get_level(ManagerPlayer.Skills.WOODCUTTING)
	


func _on_skill_leveled_up(skill: ManagerPlayer.Skills) -> void:
	if skill == ManagerPlayer.Skills.WOODCUTTING: _update_text()
	


