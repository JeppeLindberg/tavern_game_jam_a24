extends Path2D

@onready var main:Node2D = get_node('/root/main')

@export var time_between_spawns: float

var next_spawn: float

func get_next_spawn() -> float:
	if next_spawn < main.curr_secs():
		next_spawn = main.curr_secs()
	else:
		next_spawn += time_between_spawns

	return(next_spawn)

