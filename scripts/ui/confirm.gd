extends Button

@onready var state_machine:Node2D = get_node('/root/main/state_machine')

func _on_button_up() -> void:
	state_machine.go_to_simulate()
