extends Area2D

@onready var main:Node2D = get_node('/root/main')
@onready var collider:CollisionShape2D = get_node('collider')

var velocity:Vector2

var _destroy_time: float
var _charged_time: float

func charge_time(charged_time):
	_charged_time = charged_time
	_destroy_time = main.curr_secs() + 10.0

func _process(_delta: float) -> void:
	var movement_delta = velocity * (main.delta_secs() + _charged_time)
	_charged_time = 0.0

	var enemies = main.get_nodes_in_shape(collider, '', main.enemy_layer, movement_delta)
	enemies.sort_custom(_distance_ascending)
	for enemy in enemies:
		if enemy.has_method('take_damage'):
			enemy.take_damage(5);
			queue_free();
			return
	
	global_position += movement_delta

	if _destroy_time > 0:
		if main.curr_secs() > _destroy_time:
			queue_free()

func _distance_ascending(a, b):
	return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position);
