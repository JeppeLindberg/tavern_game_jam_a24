extends Node2D

var _state:String

@onready var prepare_screen:Control = get_node('/root/main/ui/prepare_screen')
@onready var upgrade_screen:Control = get_node('/root/main/ui/upgrade_screen')


func _ready() -> void:
	_state = 'prepare'
	prepare_screen.enable()
	upgrade_screen.disable()

	




