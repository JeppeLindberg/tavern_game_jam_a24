extends Node2D

@onready var tiles:Node2D = get_node('/root/main/tiles')

@export var enemy_prefab: PackedScene

var _curr_secs:float

func _ready() -> void:
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	tiles.recalc_tiles()

func _process(_delta: float) -> void:
	_curr_secs = float(Time.get_ticks_msec()) / 1000.0;

func create_node(prefab, parent):
	var new_node = prefab.instantiate()
	parent.add_child(new_node)
	new_node.position = Vector2.ZERO;
	return new_node

func curr_secs():
	return _curr_secs;

var _result

func get_tilemap_children() -> Array:
	_result = []
	_get_tilemap_children_recursive(self)
	return _result

func _get_tilemap_children_recursive(node):
	for child in node.get_children():
		if child is TileMapLayer:
			_result.append(child)
				
		_get_tilemap_children_recursive(child)
