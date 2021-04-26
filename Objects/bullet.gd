extends RigidBody

func _on_Timer_timeout():
	queue_free()

func _on_Area_body_entered(body):
	if body.is_class("Enemy") || body.is_class("Soldier"):
		body.die()
		queue_free()
	elif body.is_class("Player"):
		body.hit()
	elif body.is_class("Tent"):
		body.burn()
