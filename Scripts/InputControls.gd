
class_name InputControls

extends Node

const RIGHT = "right"
const LEFT = "left"
const JUMP = "jump"

## default controls
var controls = {
	RIGHT: [KEY_RIGHT, KEY_D],
	LEFT: [KEY_LEFT, KEY_A],
	JUMP: [KEY_UP, KEY_W, KEY_SPACE]
}


# if not exist, add to Input map autmatic
func _ready() -> void:
	add_inputs()


# NOT WORKING
func add_inputs() -> void:
	var ev : InputEvent
	for action in controls:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for key in controls[action]:
			ev = InputEventKey.new()
			InputMap.action_add_event(action, ev)
