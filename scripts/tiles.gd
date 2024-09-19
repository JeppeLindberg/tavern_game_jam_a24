extends Node2D

@onready var main:Node2D = get_node('/root/main')
@onready var bottom: TileMapLayer = get_node('/root/main/bottom')

@export var powered_node: PackedScene
@export var inventory_node: PackedScene


func recalc_tiles():
	for cell in bottom.get_used_cells():
		var tile_data:TileData = bottom.get_cell_tile_data(cell)
		var tile_type = tile_data.get_custom_data('type')
		if tile_type == 'powered':
			var new_node = main.create_node(powered_node, self)
			new_node.global_position = bottom.to_global(bottom.map_to_local(cell))
		if tile_type == 'inventory':
			var new_node = main.create_node(inventory_node, self)
			new_node.global_position = bottom.to_global(bottom.map_to_local(cell))


