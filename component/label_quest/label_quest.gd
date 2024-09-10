extends Label

const IN_PROGRESS_TEXT: String = "Currently Questing"
const QUEST_REWARD_INFO: String = "You got %s!!" 

@onready var cycle: int = 0 

func _ready():
	ManagerQuest.ref.quest_started.connect(_on_quest_start)
	ManagerQuest.ref.quest_complete.connect(_on_quest_complete)
	_update_text()

func _update_text(reward: String = "") -> void:
	match cycle%3:
		0:
			text = "Not Questing"
		1:
			text = IN_PROGRESS_TEXT
		2:
			text = QUEST_REWARD_INFO %reward


func _on_quest_start() -> void:
	cycle+=1
	_update_text()

func _on_quest_complete(reward: String) -> void:
	cycle+=1
	_update_text(reward)
	print(reward)
	_reset_label()

func _reset_label() -> void:
	if cycle%3 == 2:
		await get_tree().create_timer(5).timeout
		cycle+=1
		_update_text()

