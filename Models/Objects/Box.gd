extends RigidBody

signal apply_force(angle, force)

var _element : int = Global.Element.Steel

func _on_apply_force(angle : Vector3, force : float) -> void:
	self.apply_central_impulse(force * angle)
