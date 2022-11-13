extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	# Detect event based on Input Map value
	if event.is_action_pressed("move_forward"):
		print("Attempt to open door")
		var bodies = $Door1.get_overlapping_bodies()
		for body in bodies:
			if body == $BananaPlayer2D:
				# 3D portal
				print("3d Portal")
				$BananaPlayer2D.set_can_move(false) # stop player from moving while door is opening
				$Door1/AnimatedSprite.play("open")
				$AudioStreamPlayer.play()
				yield(get_tree().create_timer(1.5), "timeout")
				$BananaPlayer2D/AnimatedSprite.visible = false
				$Door1/AnimatedSprite.play("close")
				yield(get_tree().create_timer(1), "timeout")
				get_tree().change_scene("res://scenes/Main.tscn")
		bodies = $Door2.get_overlapping_bodies()
		for body in bodies:
			if body == $BananaPlayer2D:
				# 2D portal
				print("2d Portal")
				$BananaPlayer2D.set_can_move(false) # stop player from moving while door is opening
				$Door2/AnimatedSprite.play("open")
				$AudioStreamPlayer.play()
				yield(get_tree().create_timer(1.5), "timeout")
				$BananaPlayer2D/AnimatedSprite.visible = false
				$Door2/AnimatedSprite.play("close")
				yield(get_tree().create_timer(1), "timeout")
				get_tree().change_scene("res://scenes/2DTanx/2DTanx.tscn")
