extends StaticBody2D

@onready var main:Node2D = get_node('/root/main')
@onready var bottom: TileMapLayer = get_node('/root/main/bottom')
@onready var active: Node2D = get_node('/root/main/active')
@onready var inventory: Node2D = get_node('/root/main/inventory')
@onready var tiles: Node2D = get_node('/root/main/tiles')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group('tower')

	var avg_pos = Vector2.ZERO;
	var no_of_shapes = 0
	for child in get_children():
		no_of_shapes += 1
		avg_pos += child.position

	for child in get_children():
		child.position -= avg_pos / no_of_shapes


func drop():
	if not _try_move_to_active():
		_move_to_inventory()

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

	possible_offsets.sort_custom(_distance_ascending)

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
				
			target_child_local_pos = child.position + offset
			tile_global_pos = placeable_tiles[0].global_position + offset
		
	return true


func _distance_ascending(a, b):
	return a.length() < b.length()
			
			
