extends Area2D

@onready var main:Node = get_node('/root/main')
@onready var collider:CollisionShape2D = get_node('collider')

var _destroy_time: float

func trigger():
	var enemies = main.get_nodes_in_shape(collider, '', main.enemy_layer)
	for enemy in enemies:
		if enemy.has_method('take_damage'):
			enemy.take_damage(5);

	_destroy_time = main.curr_secs() + 0.1

func _process(_delta: float) -> void:
	if _destroy_time > 0:
		if main.curr_secs() > _destroy_time:
			queue_free()

