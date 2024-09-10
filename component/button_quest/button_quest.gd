extends Button
#Decoupled button


@onready var text_on_button: String = ("Spend %d Gold on a quest" %[ManagerQuest.ref.AMT_TO_GAMBLE])



func _ready():
	pressed.connect(_on_pressed)
	text = text_on_button

func _on_pressed() -> void:
	ManagerQuest.ref.wager_quest()
