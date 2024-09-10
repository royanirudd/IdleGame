extends Button
#Decoupled button



const WOOD_TO_CREATE: int = 10
@export var custom_wood_create: int 



func _ready():
	pressed.connect(_on_pressed)
	if custom_wood_create:
		text = "Create %s Wood" %custom_wood_create
	else:
		text = "Create %s Wood" %WOOD_TO_CREATE

func _on_pressed() -> void:
	if custom_wood_create:
		ManagerWood.ref.create_wood(custom_wood_create)
	else:
		ManagerWood.ref.create_wood(WOOD_TO_CREATE)
