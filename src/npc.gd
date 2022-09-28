extends KinematicBody

var health = 15

enum state {IDLE, WALK, HIT, DEATH}
var cur_state = state.WALK
export var speed = 5
export var rot_speed = 0.85
var velocity = Vector3.ZERO
var player : KinematicBody
var target

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Main/BananaPlayer")
	$AnimationPlayer.play("Walking")


func hit(damage : int) -> void:
	# if already dead, do nothing
	if (health <= 0):
		return
	
	health -= damage
	if health <= 0:
		$AnimationPlayer.play("StandingReactDeathBackward")
		cur_state = state.DEATH
	else:
		cur_state = state.HIT
		yield(get_tree().create_timer(1.4), "timeout")
		cur_state = state.IDLE
		
func _process(_delta):
	pass

func _hit_complete():
	cur_state = state.IDLE

func _physics_process(delta):
	if (cur_state != state.DEATH):
		var dist = transform.origin.distance_to(player.transform.origin)
		velocity = -transform.basis.z * speed
		if (cur_state == state.WALK):
			$AnimationPlayer.play("Walking")
			look_at(player.transform.origin, Vector3.UP)
			velocity = move_and_slide(velocity, Vector3.UP)
			if (dist < 10):
				cur_state = state.IDLE
		elif (cur_state == state.HIT):
			$AnimationPlayer.play("GettingHit")
		elif (cur_state == state.IDLE):
			look_at(player.transform.origin, Vector3.UP)
			$AnimationPlayer.play("Idle")
			if (dist > 10):
				cur_state = state.WALK
