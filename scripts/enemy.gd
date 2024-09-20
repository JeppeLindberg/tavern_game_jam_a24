extends Node2D


@onready var path:Path2D = get_node('/root/main/path')
@onready var main:Node2D = get_node('/root/main')
@onready var healthbar:Node2D = get_node('healthbar')

@export var speed: float = 10
@export var path_follow: PackedScene
@export var max_health: float = 10.0

var follow:PathFollow2D
var spawn_delay:float
var health:float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	follow = main.create_node(path_follow, path)
	follow.progress = 0;
	reparent(follow, false)
	spawn_delay = path.get_next_spawn() - main.curr_secs()
	health = max_health
	healthbar.set_pct(health/max_health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn_delay > 0:
		spawn_delay -= delta
		if spawn_delay < 0:
			delta += spawn_delay
		else:
			return

	if not follow == null:
		follow.progress += delta * speed;

func take_damage(damage):
	health-=damage
	healthbar.set_pct(health/max_health)
	if health <= 0:
		queue_free()
