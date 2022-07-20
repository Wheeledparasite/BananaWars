extends BaseState

func input(event: InputEvent) -> int:
	player.jump = false
	if Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_back") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		return State.Walk
	elif Input.is_action_just_pressed("jump"):
		player.jump = true
		return State.Jump
	return State.Null

func physics_process(delta: float) -> int:
	player.velocity += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector3.UP)
	return State.Null
