extends Spatial

export var verticalSensitivity : float = 0.002
export var horizontalSensitivity : float = 0.002
export var maxPitchDeg : float = 50
export var minPitchDeg : float = -75

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y * verticalSensitivity
		rotation.x = clamp(rotation.x, deg2rad(minPitchDeg), deg2rad(maxPitchDeg))
