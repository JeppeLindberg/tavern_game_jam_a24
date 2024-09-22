extends Node2D

@onready var meter:Node2D = get_node('backplate/meter_clip/meter')
@onready var state_machine:Node2D = get_node('/root/main/state_machine')

var _scrap = 0.0

func add_scrap(scrap):
	_scrap += scrap

	meter.position = lerp(Vector2(-96, 0), Vector2.ZERO, clamp(_scrap/100.0, 0.0, 1.0))

	check_scrap()

func reduce_scrap(scrap):
	_scrap -= scrap

	meter.position = lerp(Vector2(-96, 0), Vector2.ZERO, clamp(_scrap/100.0, 0.0, 1.0))

func check_scrap():
	if (_scrap >= 100.0) and (state_machine.state == 'prepare'):
		state_machine.go_to_upgrade()




