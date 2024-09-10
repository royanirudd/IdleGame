extends Node
class_name Game

#Singleton pattern
static var ref: Game

func _init():
	if !ref: ref = self
	else: queue_free()

#contains save and load
var _data: Data 
#we should initialize it in enter_tree not ready
#all other singletons need to use it

@onready var _save_timer: Timer = %SaveTimer

func _enter_tree() -> void:
	_data = Data.new()
	SaveSystem.load_data()

func _ready() -> void:
	_save_timer.timeout.connect(_on_save_timer_timeout)

func _on_save_timer_timeout() -> void:
	#save every timeout
	SaveSystem.save_data()

#Save when game is closed
func _exit_tree() -> void:
	SaveSystem.save_data()
