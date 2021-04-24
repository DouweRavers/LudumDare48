extends KinematicBody

var shooting : bool = false
var target : KinematicBody = null
var yielding : bool = false
onready var ani = $DutchVisual/Animations

func get_class():
	return "Enemy"

func is_class(name):
	return name == "Enemy"

func _ready():
	$TurnTick.wait_time = rand_range(0.5, 3)


func _process(delta):
	if target == null:
		for body in $SenseArea.get_overlapping_bodies():
			if body.is_class("Soldier") || body.is_class("Player"):
				target = body
	if target != null:
		if not shooting:
			shooting = true
			$Gun.aim(target.get_class())
			ani.play("Aim")
			$AimingTimer.wait_time = rand_range(4.0, 8.0)
			$AimingTimer.start()
		if not $SenseArea.overlaps_body(target):
			target = null
			

func die():
	ani.play("Die")
	yield(ani, "animation_finished")
	queue_free()

func _on_AimingTimer_timeout():
	$Gun.shoot()
	ani.play("Shoot")
	$AimingTimer.stop()
	shooting = false

func _on_TurnTick_timeout():
	if target != null:
		look_at(target.global_transform.origin, Vector3.UP)
		rotation.x = 0
		rotation.z = 0
