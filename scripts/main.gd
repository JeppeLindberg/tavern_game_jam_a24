extends Node

@onready var game:Node2D = get_node('/root/main/game')
@onready var tiles:Node2D = get_node('/root/main/game/tiles')

@export var enemy_prefab: PackedScene
@export_flags_2d_physics var basic_layer
@export_flags_2d_physics var enemy_layer

var _curr_secs:float
var _delta_secs:float

func _ready() -> void:
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	create_node(enemy_prefab, self)
	tiles.recalc_tiles()

func _process(_delta: float) -> void:
	var time_elapsed = float(Time.get_ticks_msec()) / 1000.0;
	_delta_secs = time_elapsed - _curr_secs
	_curr_secs = time_elapsed

func create_node(prefab, parent):
	var new_node = prefab.instantiate()
	parent.add_child(new_node)
	new_node.position = Vector2.ZERO;
	return new_node

func curr_secs():
	return _curr_secs;
	
func delta_secs():
	return _delta_secs;

var _result

func get_children_with_method(node, method) -> Array:
	_result = []
	_get_children_with_method_recursive(node, method)
	return _result

func _get_children_with_method_recursive(node, method):
	for child in node.get_children():
		if child.has_method(method):
			_result.append(child)
				
		_get_children_with_method_recursive(child, method)

func get_all_children(node) -> Array:
	_result = []
	_get_all_children_recursive(node)
	return _result

func _get_all_children_recursive(node):
	for child in node.get_children():
		_result.append(child)
				
		_get_all_children_recursive(child)
	
func get_nodes_at(pos, group = '', collision_mask = 0):
	var point:PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	point.position = pos;
	point.collide_with_areas = true
	if collision_mask != 0:
		point.collision_mask = collision_mask
	else:
		point.collision_mask = basic_layer
	var collisions = game.get_world_2d().direct_space_state.intersect_point(point);
	if collisions == null:
		return([])
	
	var nodes = []
	for collision in collisions:
		var node = collision['collider'];
		if (group == '') or node.is_in_group(group):
			nodes.append(node)
	return nodes

func get_nodes_in_shape(collider, group = '', collision_mask = 0, motion = Vector2.ZERO):
	var shape = PhysicsShapeQueryParameters2D.new()
	shape.shape = collider.shape;
	shape.transform = collider.global_transform
	shape.collide_with_areas = true
	if collision_mask != 0:
		shape.collision_mask = collision_mask
	else:
		shape.collision_mask = basic_layer
	if motion != Vector2.ZERO:
		shape.motion = motion
	var collisions = game.get_world_2d().direct_space_state.intersect_shape(shape);
	if collisions == null:
		return([])
	
	var nodes = []
	for collision in collisions:
		var node = collision['collider'];
		if (group == '') or node.is_in_group(group):
			nodes.append(node)
	return nodes

func get_first_collision_in_ray(from, to, collision_mask = 0):
	var ray = PhysicsRayQueryParameters2D.new()
	ray.from = from;
	ray.to = to
	ray.collide_with_areas = true
	if collision_mask != 0:
		ray.collision_mask = collision_mask
	else:
		ray.collision_mask = basic_layer
	var collision = game.get_world_2d().direct_space_state.intersect_ray(ray);
	
	return collision;
	
