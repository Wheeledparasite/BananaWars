extends BaseState

func input(_event: InputEvent) -> int:
	if Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_back") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		return State.Walk
	return State.Null

func physics_process(delta: float) -> int:
	player.velocity += player.gravity * delta
	#get_input()
	player.velocity = player.move_and_slide(player.velocity, Vector3.UP)

	if player.jump and player.is_on_floor():
		player.velocity.y = player.jump_speed
		return State.Walk
	
	return State.Null
