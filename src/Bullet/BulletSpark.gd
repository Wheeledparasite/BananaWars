extends MeshInstance
#class_name BulletSpark



func _on_die_timeout() -> void:
	self.queue_free()


func _on_TimerDie_timeout():
	self.queue_free()
