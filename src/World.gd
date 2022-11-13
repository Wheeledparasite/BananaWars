extends Spatial


func _ready() -> void:
	Global._root_node = self

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$BananaPlayer.set_process_input(true)
	$BananaPlayer.set_process(true)

func _input(_event) -> void:
	if Input.is_action_just_pressed("Quit"):
		self.get_tree().quit()
	elif Input.is_action_just_released("ToggleFullScreen"):
		OS.window_fullscreen = not OS.window_fullscreen


func _on_PortalArea_body_entered(body):
	if body == $BananaPlayer:
		print("Detected player")
		#$SfxPlayer.set_stream("res://sounds/teleport.wav")
		$SfxPlayer.play()
		yield(get_tree().create_timer(1), "timeout")
		get_tree().change_scene("res://scenes/2D_MiniGame.tscn")
		
