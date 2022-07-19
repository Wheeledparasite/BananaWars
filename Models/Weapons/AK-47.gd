extends RigidBody

signal apply_force(angle, force)

var _element : int = Global.Element.Aluminum
onready var _audiostream : AudioStreamPlayer = $AudioStreamPlayer

func _on_apply_force(angle : Vector3, force : float) -> void:
	self.apply_central_impulse(force * angle)

func fire(target_pos : Vector3) -> void:
	var bullet_type = Global.BulletType._762
	var start_pos = $BulletStartPosition.global_transform.origin
	Global.create_bullet(Global._root_node, start_pos, target_pos, bullet_type)
	_audiostream.play()

