extends Node2D

@onready var main:Node = get_node('/root/main')

func _unhandled_input(event):
	if event is InputEventMouse:
		global_position = event.position

	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_LEFT) and (event.pressed):
			var nodes = main.get_nodes_at(event.position, 'building')
			if not nodes.is_empty():
				nodes[0].reparent(self)
				nodes[0].position = Vector2.ZERO
				var powered_nodes = main.get_children_with_method(nodes[0], 'set_powered')
				for node in powered_nodes:
					node.set_powered(false)

				
		if (event.button_index == MOUSE_BUTTON_LEFT) and (not event.pressed):
			for child in get_children():
				child.drop()
	
	if event is InputEventKey:
		if Input.is_action_just_pressed('rotate'):
			var nodes = main.get_children_with_method(self, 'rotate_building')
			for node in nodes:
				node.rotate_building()

