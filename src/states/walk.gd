extends BaseState
var direction = Vector3.ZERO


func input(event: InputEvent) -> int:
	var vy = player.velocity.y
	var input_direction : Vector3 = (player._input_vector.x * player.transform.basis.x) + (player._input_vector.z * player.transform.basis.z)
	var is_moving : bool = input_direction != Vector3.ZERO
	direction = Vector3.ZERO
	player.velocity = Vector3()
	if Input.is_action_pressed("move_forward"):
		player.velocity += -player.transform.basis.z * player.speed
	if Input.is_action_pressed("move_back"):
		player.velocity += player.transform.basis.z * player.speed
	if Input.is_action_pressed("move_right"):
		player.velocity += player.transform.basis.x * player.speed
	if Input.is_action_pressed("move_left"):
		player.velocity += -player.transform.basis.x * player.speed
	if Input.is_action_pressed("run"):
		player.velocity *= 1.5
	player.velocity.y = vy
	
	player.jump = false
	if Input.is_action_just_pressed("jump"):
		player.jump = true
		return State.Jump
	if Input.is_action_pressed("Quit"): #esc
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	return State.Null

func physics_process(delta: float) -> int:
	player.velocity += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector3.UP)
	print(player.velocity)
	if player.jump and player.is_on_floor():
		player.velocity.y = player.jump_speed
		
	return State.Null
