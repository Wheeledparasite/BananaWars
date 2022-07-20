extends RigidBody

signal apply_force(angle, force)

var _can_shoot : bool = true
var _element : int = Global.Element.Aluminum
onready var _audiostream : AudioStreamPlayer = $AudioStreamPlayer

func _on_apply_force(angle : Vector3, force : float) -> void:
	self.apply_central_impulse(force * angle)

func fire(target_pos : Vector3) -> void:
	var bullet_type = Global.BulletType._762
	var start_pos = $BulletStartPosition.global_transform.origin
	if (_can_shoot):
		Global.create_bullet(Global._root_node, start_pos, target_pos, bullet_type)
		$Particles.emitting = true
		_audiostream.pitch_scale = rand_range(0.45, 0.55)
		_audiostream.play()
		$ShotTimer.start()
		_can_shoot = false

func _on_ShotTimer_timeout():
	_can_shoot = true
