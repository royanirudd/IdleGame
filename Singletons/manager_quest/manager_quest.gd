extends Node
class_name ManagerQuest


#Singleton pattern

static var ref: ManagerQuest 

func _init():
	if !ref: ref = self
	else: queue_free()

#Should be constants later
@export var AMT_TO_GAMBLE: int  = 100
@export var QUEST_TIMER: float = 10.0


const WEIGHT1 = 0.05 #PET CHANCE 5%
const WEIGHT2 = 0.09 #ARMOR CHANCE 9%
const WEIGHT3 = 0.65 #SWORD CHANCE 65%
#If these dont add up to 1, the remaining percent is just a bad luck roll


#SIGNALS
signal quest_complete(reward: String)
signal quest_started


func wager_quest() -> void:
	if !ManagerGold.ref.can_spend_gold(100): return 
	ManagerGold.ref.spend_gold(AMT_TO_GAMBLE)
	create_quest_timer()
	quest_started.emit()

func create_quest_timer() -> void:
	await get_tree().create_timer(QUEST_TIMER).timeout
	choose_rand_reward()


func choose_rand_reward() -> void:
	var rng = RandomNumberGenerator.new()
	var rand = rng.randf_range(0,1.0)
	print(rand)
	if rand <= WEIGHT1:
		quest_complete.emit("one")
	elif rand > WEIGHT1 && rand <= (WEIGHT1+WEIGHT2):
		quest_complete.emit("two")
	elif rand > (WEIGHT1 + WEIGHT2) && rand <= WEIGHT3:
		quest_complete.emit("three")
	else:
		quest_complete.emit("Nothing")
	
