extends Node2D

@onready var green_child:Node2D = get_node('green/green_child')


func set_pct(health_pct):
	if (0.0 < health_pct) and (health_pct < 1.0):
		visible = true
	else:
		visible = false

	green_child.position = lerp(Vector2.LEFT * 27, Vector2.ZERO, health_pct)
	
