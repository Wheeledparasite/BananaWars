extends KinematicBody2D

const WALK_FORCE : int = 1000
const WALK_MAX_SPEED : int = 85
const STOP_FORCE : int = 1300
const JUMP_SPEED : int = 100

var velocity = Vector2()

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if velocity.length() > 0.5:
		$AnimatedSprite.playing = true
	else:
		$AnimatedSprite.playing = false

func _input(event):
	# Detect event based on Input Map value
	if event.is_action_pressed("move_forward"):
		print("Up was pressed")

func _physics_process(delta):
	var left = Input.get_action_strength("move_right")
	var right = Input.get_action_strength("move_left")

	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * (left - right)
	
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
		
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta
	
	var stopOnSlope = get_floor_velocity().x != 0 or get_floor_velocity().y != 0
	
	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity,Vector2.DOWN , Vector2.UP, !stopOnSlope )

	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		position.y -= 1 # Ensures you dont collide with vertical platforms
		velocity.y = -JUMP_SPEED
		print ("jump")
