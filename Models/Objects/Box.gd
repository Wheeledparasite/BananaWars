extends RigidBody

signal apply_force(angle, force)

var _element : int = Global.Element.Steel

func _on_apply_force(angle : Vector3, force : Vector3) -> void:
	#self.apply_torque_impulse(force * angle)
	self.apply_impulse(angle, force)
	self.apply_central_impulse(force)
