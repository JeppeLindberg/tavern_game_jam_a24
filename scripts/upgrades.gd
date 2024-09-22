extends Node2D

@onready var main:Node = get_node('/root/main')
@onready var ui_selection:Control = get_node('/root/main/ui/upgrade_screen/h_container/selection')

@export var upgrade_selection_prefab:PackedScene
@export var buildings:Array = []


func generate_beginning_buildings():
	var node = main.create_node(buildings[0], main)
	node.drop()

func generate_upgrades():
	var possible_upgrades = buildings.duplicate()
	possible_upgrades.shuffle()

	for i in range(2):
		var selection = main.create_node(upgrade_selection_prefab, ui_selection)
		var node = main.create_node(possible_upgrades[i], self)

		var text = selection.get_node('margin/h_container/center/text')
		text.text = '[center][b]'+ node.building_name +'[/b]\n[center]'+node.building_desc
		selection.building_prefab = possible_upgrades[i]
		node.queue_free()
		
	
