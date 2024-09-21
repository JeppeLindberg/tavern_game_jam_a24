extends Node2D

@onready var main:Node = get_node('/root/main')
@onready var prepare_screen:Control = get_node('/root/main/ui/prepare_screen')
@onready var upgrade_screen:Control = get_node('/root/main/ui/upgrade_screen')
@onready var upgrades:Node2D = get_node('/root/main/game/upgrades')
@onready var selection:Control = get_node('/root/main/ui/upgrade_screen/h_container/selection')

var _state:String

@export var enemy_prefab: PackedScene

func _ready() -> void:
	go_to_prepare()

func go_to_prepare():
	for child in selection.get_children():
		child.queue_free()
	_state = 'prepare'
	prepare_screen.enable()
	upgrade_screen.disable()

func go_to_simulate():
	_state = 'simulate'
	prepare_screen.disable()
	upgrade_screen.disable()

	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)

func go_to_upgrade():
	_state = 'upgrade'
	prepare_screen.disable()
	upgrade_screen.enable()

	upgrades.generate_upgrades()







