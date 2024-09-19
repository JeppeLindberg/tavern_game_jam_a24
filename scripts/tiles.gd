extends Node2D

@onready var main:Node2D = get_node('/root/main')

@export var powered_node: PackedScene


func recalc_tiles():
	var tilemaps = main.get_tilemap_children()

	for tilemap in tilemaps:
		for cell in tilemap.get_used_cells():
			var tile_data:TileData = tilemap.get_cell_tile_data(cell)
			var tile_type = tile_data.get_custom_data('type')
			if tile_type == 'powered':
				var new_node = main.create_node(powered_node, self)
				new_node.global_position = tilemap.to_global(tilemap.map_to_local(cell))


