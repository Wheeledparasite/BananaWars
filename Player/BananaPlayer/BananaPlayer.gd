class_name Player
extends KinematicBody

var gravity = Vector3.DOWN * 27  # strength of gravity
var speed = 5  # movement speed
var jump_speed = 14  # jump strength
var spin = 0.03  # rotation speed

var velocity = Vector3.ZERO
var jump = false

#Camera
export var verticalSensitivity : float = 0.002
export var horizontalSensitivity : float = 0.002
var _latest_mouse_pos := Vector2.ZERO
var _input_vector := Vector3.ZERO
var _velocity := Vector3.ZERO
var _snap_vector := Vector3.ZERO
var _looking_at = null
var _camera_x := 0.0
var _camera_x_new := 0.0
var _camera_y := 0.0

onready var camera := $Arms/Camera
onready var target_ray := $Arms/Camera/RayMount/LookAtRayCast
onready var animations = $AnimationPlayer
onready var states = $state_manager
#shooting script
var target := Vector3.INF
var ray_length := 3000

func _ready():
	set_as_toplevel(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	states.init(self)

#func get_input():
#	var vy = velocity.y
#	var input_direction : Vector3 = (_input_vector.x * transform.basis.x) + (_input_vector.z * transform.basis.z)
#	var is_moving : bool = input_direction != Vector3.ZERO
#	velocity = Vector3()
#	if Input.is_action_pressed("move_forward"):
#		velocity += -transform.basis.z * speed
#	if Input.is_action_pressed("move_back"):
#		velocity += transform.basis.z * speed
#	if Input.is_action_pressed("move_right"):
#		velocity += transform.basis.x * speed
#	if Input.is_action_pressed("move_left"):
#		velocity += -transform.basis.x * speed
#	velocity.y = vy
#	jump = false
#	if Input.is_action_just_pressed("jump"):
#		jump = true
#	if Input.is_action_pressed("Quit"): #esc
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _process(delta : float) -> void:
	_latest_mouse_pos = get_viewport().get_mouse_position()
	#var from = camera.project_ray_origin(_latest_mouse_pos)
	#var to = from + camera.project_ray_normal(_latest_mouse_pos) * ray_length
	var from = target_ray.to_global(Vector3(0,0,0))
	var to = target_ray.to_global(target_ray.cast_to)
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(to, from)
	target = result.position if result else to
	#print(target)
	#print(camera)
	target_ray.force_raycast_update()
	var thing = target_ray.get_collider()
	if thing:
		if thing != _looking_at:
			_looking_at = thing
			print("Looking at %s(%s)" % [thing.name, thing.get_class()])
	elif _looking_at:
		_looking_at = null
		print("Looking at null")
	
	#if target != Vector3.INF:
		#var arm :=$Arms/ItemMount
		#arm.target_ray(target, Vector3.UP)
	
	#print(target)
	
	var is_shooting := false
	if Input.is_action_just_pressed("mouse1"): #left click
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		is_shooting = true
	if is_shooting:
		for weapon in $Arms/ItemMount.get_children():
			weapon.fire(target)

func _unhandled_input(event):
	states.input(event)
	# orbit the cam around the banana horizontally
	if event is InputEventMouseMotion:
		if event.relative.x > 0:
			rotate_y(-lerp(0, horizontalSensitivity*10, event.relative.x/10))
		elif event.relative.x < 0:
			rotate_y(-lerp(0, horizontalSensitivity*10, event.relative.x/10))

func _physics_process(delta):
	states.physics_process(delta)
#	velocity += gravity * delta
#	get_input()
#	velocity = move_and_slide(velocity, Vector3.UP)
#	if (velocity.length() > 0.1):
#		$AnimationPlayer.play("move")
#	else:
#		$AnimationPlayer.stop()
#	if jump and is_on_floor():
#		velocity.y = jump_speed
