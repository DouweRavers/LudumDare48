extends StaticBody

var burned : bool = false

func is_class(name):
	return name == "Tent"

func get_class():
	return "Tent"

func burn():
	if not burned:
		burned = true
		$AnimationPlayer.play("startBurning")
		$CollisionShape.disabled = true
