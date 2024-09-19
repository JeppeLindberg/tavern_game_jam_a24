extends Node2D

@onready var main:Node2D = get_node('/root/main')

func _unhandled_input(event):
	if event is InputEventMouse:
		global_position = event.position

	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_LEFT) and (event.pressed):
			var nodes = main.get_nodes_at(event.position, 'tower')
			if not nodes.is_empty():
				nodes[0].reparent(self)
				nodes[0].position = Vector2.ZERO
				
		if (event.button_index == MOUSE_BUTTON_LEFT) and (not event.pressed):
			for child in get_children():
				child.drop()
			
			