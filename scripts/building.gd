extends StaticBody2D

@onready var main:Node = get_node('/root/main')
@onready var bottom: TileMapLayer = get_node('/root/main/game/bottom')
@onready var active: Node2D = get_node('/root/main/game/active')
@onready var inventory: Node2D = get_node('/root/main/game/inventory')
@onready var tiles: Node2D = get_node('/root/main/game/tiles')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group('building')

	var avg_pos = Vector2.ZERO;
	var no_of_shapes = 0
	for child in get_children():
		no_of_shapes += 1
		avg_pos += child.position

	for child in get_children():
		child.position -= avg_pos / no_of_shapes

func rotate_building():
	rotation_degrees += 90
	for child in get_children():
		if child.is_in_group('tower'):
			child.rotation_degrees -= 90;

func drop():
	var nodes = main.get_children_with_method(self, 'set_powered')
	if _try_move_to_active():
		for node in nodes:
			node.set_powered(true)
	else:
		_move_to_inventory()
		for node in nodes:
			node.set_powered(false)

var target_child_local_pos = Vector2.ZERO
var tile_global_pos = Vector2.ZERO

func _try_move_to_active():
	target_child_local_pos = Vector2.ZERO
	tile_global_pos = Vector2.ZERO

	if _try_place(Vector2.ZERO, 'powered_tile'):
		reparent(active)
		global_position = tile_global_pos - target_child_local_pos

		return true;
	return false;

func _move_to_inventory():
	target_child_local_pos = Vector2.ZERO
	tile_global_pos = Vector2.ZERO

	var possible_offsets = [Vector2.ZERO]
	for child in tiles.get_children():
		possible_offsets.append(child.global_position - global_position)

	possible_offsets.sort_custom(_length_ascending)

	for possible_offset in possible_offsets:
		if _try_place(possible_offset, 'inventory_tile'):
			reparent(inventory)
			global_position = tile_global_pos - target_child_local_pos

			return true;
	return false;

func _try_place(offset, group):
	for child in get_children():
		if child is CollisionShape2D:
			var placeable_tiles = main.get_nodes_at(child.global_position + offset, group)
			if placeable_tiles.is_empty():
				return false;
				
			target_child_local_pos = (child.global_position - global_position) + offset
			tile_global_pos = placeable_tiles[0].global_position + offset
		
	return true

func _length_ascending(a, b):
	return a.length() < b.length()
			
			
