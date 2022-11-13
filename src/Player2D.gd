extends KinematicBody2D

const WALK_FORCE : int = 1000
const WALK_MAX_SPEED : int = 95
const STOP_FORCE : int = 1300
const JUMP_SPEED : int = 150

var velocity : Vector2 = Vector2()

onready var _can_move : bool = true
onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _process(_delta) -> void:
	if velocity.length() > 0.5 and _can_move:
		$AnimatedSprite.playing = true
	else:
		$AnimatedSprite.playing = false

func _physics_process(delta) -> void:
	var left = Input.get_action_strength("move_right")
	var right = Input.get_action_strength("move_left")

	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * (left - right)
	
	if (walk < 0):
		$AnimatedSprite.flip_h = true
	elif (walk > 0):
		$AnimatedSprite.flip_h = false
	
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
	if _can_move:
		velocity = move_and_slide_with_snap(velocity,Vector2.DOWN , Vector2.UP, !stopOnSlope )

	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed("jump") and _can_move:
		position.y -= 1 # Ensures you dont collide with vertical platforms
		velocity.y = -JUMP_SPEED
		print ("jump")

func set_can_move(val : bool) -> void:
	_can_move = val
