class_name BaseState
extends Node

# Don't get confused, this is not the same as on the switch example
# This enum is used so that each child state can reference each other for its return value
enum State {
	Null,
	Idle,
	Walk,
	Jump
}

export (String) var animation_name

var player: Player

func enter() -> void:
	if !animation_name.empty():
		player.animations.play(animation_name)
	else:
		player.animations.stop()

func exit() -> void:
	pass

# Enums are internally stored as ints, so that is the expected return type
func input(_event: InputEvent) -> int:
	return State.Null

func process(_delta: float) -> int:
	return State.Null

func physics_process(_delta: float) -> int:
	return State.Null
