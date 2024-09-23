extends Area2D

@onready var main:Node = get_node('/root/main')
@onready var collider:CollisionShape2D = get_node('collider')
@onready var sprite:Sprite2D = get_node('sprite')

var _spawn_time: float

@export var animation_frames_per_second: float = 0.1
@export var frames:Array = []

func trigger():
	var enemies = main.get_nodes_in_shape(collider, '', main.enemy_layer)
	for enemy in enemies:
		if enemy.has_method('take_damage'):
			enemy.take_damage(5);

	_spawn_time = main.curr_secs()

func _process(_delta: float) -> void:
	if _spawn_time > 0:
		var frame = int((main.curr_secs() - _spawn_time) * animation_frames_per_second)
		if frame >= len(frames):
			queue_free()
		else:
			sprite.texture = frames[frame]

