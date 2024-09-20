extends Area2D

var shootable = 0

var powered = false

@onready var main:Node2D = get_node('/root/main')
@onready var effects:Node2D = get_node('/root/main/effects')
@onready var collider:CollisionShape2D = get_node('collider')

@export var shots_per_sec = 0.1
@export var explosion_prefab: PackedScene


func _ready() -> void:
	add_to_group('tower')


func _process(_delta: float) -> void:
	if powered:
		shootable += main.delta_secs()

		if shootable >= 0:
			if _try_shoot():
				shootable -= (1 / shots_per_sec);
			else:
				shootable = 0

func set_powered(new_powered):
	powered = new_powered
	
	shootable = -(1 / shots_per_sec)
	
func _try_shoot():
	var enemies_close = main.get_nodes_in_shape(collider, '', main.enemy_layer)
	if enemies_close.is_empty():
		return false
	
	enemies_close.sort_custom(_adjecency_asceding)

	var collision = main.get_first_collision_in_ray(global_position, enemies_close[0].global_position, main.enemy_layer)
	if collision == null:
		return false
	
	var explosion = main.create_node(explosion_prefab, effects)
	explosion.global_position = collision['position']
	explosion.trigger()
	return true;

func _adjecency_asceding(a, b):
	return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position)


	
