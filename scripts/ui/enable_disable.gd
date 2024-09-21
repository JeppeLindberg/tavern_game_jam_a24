extends Control

@onready var main:Node = get_node('/root/main')

var mouse_control = {}


func disable():
	if main == null:
		main = get_node('/root/main')
	for child in main.get_all_children(self):
		if (not child.is_queued_for_deletion()) and (child is Control):
			mouse_control[child] = child.mouse_filter
	visible = false

func enable():
	if main == null:
		main = get_node('/root/main')
	if mouse_control != {}:
		for child in mouse_control.keys():
			if (child != null) and (not child.is_queued_for_deletion()):
				child.mouse_filter = mouse_control[child]
	visible = true


