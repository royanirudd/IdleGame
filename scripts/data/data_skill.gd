extends Resource
class_name DataSkill


var level_requirements: Array[int] = [1, 7, 20, 44, 81, 135, 208, 304, 425, 575, 756, 972, 1225, 1519, 1856, 2240, 2673, 3159, 3700, 4300, 4961, 5687, 6480, 7344, 8281]
var max_lvl: int = len(level_requirements)

var levels: Dictionary 

func _init():
	levels = {
	"WOODCUTTING":{"level": 1, "experience_till_nextlvl": 7}
}
