extends Control
class_name UserInterface

static var ref: UserInterface

func _init() -> void:
	if !ref: ref = self
	else: queue_free()

#Same as get_node("MainView")
@onready var main_view: TabContainer = %MainView

func change_view(i: int) -> Error:
	if i < 0 or i >= main_view.get_tab_count(): return Error.FAILED
	main_view.current_tab = i
	return Error.OK
