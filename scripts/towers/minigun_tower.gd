extends Node2D

var shootable = 0

var powered = false

@onready var main:Node2D = get_node('/root/main')
@onready var effects:Node2D = get_node('/root/main/effects')

@export var shots_per_sec = 0.1
@export var bullet_speed = 100.0
@export var bullet_prefab: PackedScene


func _ready() -> void:
	add_to_group('tower')


func _process(_delta: float) -> void:
	if powered:
		shootable += main.delta_secs()

		if shootable >= 0:
			var charged_time = (1 / shots_per_sec);
			if _try_shoot(charged_time):
				shootable -= charged_time;
			else:
				shootable = 0

func set_powered(new_powered):
	powered = new_powered	
	shootable = -(1 / shots_per_sec)

func _try_shoot(charged_time):	
	var bullet = main.create_node(bullet_prefab, effects)
	bullet.global_position = global_position
	bullet.velocity = global_transform.basis_xform(Vector2.RIGHT) * bullet_speed
	bullet.charge_time(charged_time)
	return true;

func _adjecency_asceding(a, b):
	return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position)


	
