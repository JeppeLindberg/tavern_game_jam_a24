extends Node2D

@onready var main:Node = get_node('/root/main')
@onready var prepare_screen:Control = get_node('/root/main/ui/prepare_screen')
@onready var upgrade_screen:Control = get_node('/root/main/ui/upgrade_screen')
@onready var upgrades:Node2D = get_node('/root/main/game/upgrades')
@onready var path:Node2D = get_node('/root/main/game/path')
@onready var selection:Control = get_node('/root/main/ui/upgrade_screen/h_container/selection')
@onready var recycler:Node2D = get_node('/root/main/game/recycler')

var state:String

var _enemies_remaining:int

@export var enemy_prefab: PackedScene

func _ready() -> void:
	go_to_prepare()

func go_to_prepare():
	for child in path.get_children():
		child.queue_free()
	for child in selection.get_children():
		child.queue_free()
	state = 'prepare'
	prepare_screen.enable()
	upgrade_screen.disable()

	recycler.check_scrap()

func go_to_simulate():
	state = 'simulate'
	prepare_screen.disable()
	upgrade_screen.disable()

	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)
	main.create_node(enemy_prefab, main)

func go_to_upgrade():
	state = 'upgrade'
	prepare_screen.disable()
	upgrade_screen.enable()

	upgrades.generate_upgrades()

func enemy_spawned():
	_enemies_remaining += 1

func enemy_killed():
	_enemies_remaining -= 1

	if (state == 'simulate') and (_enemies_remaining == 0):
		go_to_prepare()






