extends Spatial

var health = 15


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func hit(damage : int) -> void:
	# if already dead, do nothing
	if (health <= 0):
		return
	
	health -= damage
	if health <= 0:
		$AnimationPlayer.play("StandingReactDeathBackward")
	else:
		$AnimationPlayer.play("GettingHit")
		$AnimationPlayer.queue("Idle")
