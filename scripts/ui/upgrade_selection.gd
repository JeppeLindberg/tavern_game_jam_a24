extends PanelContainer

@onready var main:Node = get_node('/root/main')
@onready var state_machine:Node2D = get_node('/root/main/state_machine')
@onready var recycler:Node2D = get_node('/root/main/game/recycler')

var building_prefab:PackedScene


func _on_button_button_up() -> void:
    var building = main.create_node(building_prefab, main)
    building.global_position = Vector2.ZERO
    building.drop()
    recycler.reduce_scrap(100.0)
    state_machine.go_to_prepare()
