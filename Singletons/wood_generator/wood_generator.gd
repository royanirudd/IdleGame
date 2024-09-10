extends Node
class_name WoodGenerator

static var ref: WoodGenerator

func _init() -> void:
	if !ref: ref = self
	else: queue_free()

#signal
signal generated_wood
signal generator_started
signal generator_stopped

@export var WOOD_TICK_MAX: int = 10
@export var WOOD_TICK_MIN: int = 25
@export var _generated_wood_per_tick: Vector2i = Vector2i(WOOD_TICK_MIN, WOOD_TICK_MAX)
@export var _tick_duration: float = 2.5

var EXP_PER_TICK: int = 3

#'$' uses get_node to get Timer, == to get_node("Timer")
@onready var _timer: Timer = $Timer

@onready var data: DataWood = Game.ref._data.data_wood

func _ready() -> void:
	_timer.wait_time = _tick_duration
	#connect timer timeout signal
	_timer.timeout.connect(_on_timer_timeout)
	#check save for if user left generator on
	if data.generator_on: start()


func start() -> void:
	_timer.start()
	data.generator_on = true
	generator_started.emit()

func stop() -> void:
	_timer.stop()
	data.generator_on = false
	generator_stopped.emit()


func is_active() -> bool:
	return data.generator_on

#Checks if active and flips
func toggle() -> void:
	if is_active(): stop()
	else: start()

func _generate_wood() -> void:
	#Roll random number between 2
	var after_bonus = _calculate_lvl_bonus()
	var roll: int = randi_range(after_bonus.x, after_bonus.y)
	ManagerWood.ref.create_wood(roll)
	ManagerPlayer.ref.add_experience(ManagerPlayer.Skills.WOODCUTTING, 3)
	
	
	generated_wood.emit()

func _calculate_lvl_bonus() -> Vector2i:
	return _generated_wood_per_tick * (1+ManagerPlayer.ref.get_bonus(ManagerPlayer.Skills.WOODCUTTING))


func _on_timer_timeout() -> void:
	_generate_wood()
