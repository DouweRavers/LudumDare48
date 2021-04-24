extends KinematicBody
var shooting : bool = false
var target : KinematicBody = null
var yielding : bool = false
func get_class():
	return "Enemy"

func is_class(name):
	return name == "Enemy"

func _ready():
	pass # Replace with function body.

func _process(delta):
	if target == null:
		for body in $SenseArea.get_overlapping_bodies():
			if body.is_class("Soldier") || body.is_class("Player"):
				target = body
	if target != null && not shooting:
		shooting = true
		$Gun.aim(target.get_class())
		yielding = true
		for i in range( 20 + randi() % 20):
			yield(get_tree().create_timer(0.1), "timeout")
		yielding = false
		$Gun.shoot()
		shooting = false
		if target != null && not $SenseArea.overlaps_body(target):
			target = null

func die():
	if yielding:
		visible = false
		for i in range(5):
			yield(get_tree().create_timer(1), "timeout")
	queue_free()
	

