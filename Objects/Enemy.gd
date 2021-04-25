extends KinematicBody

var shooting : bool = false
var target : NodePath
var yielding : bool = false
onready var ani = $DutchVisual/Animations

func get_class():
	return "Enemy"

func is_class(name):
	return name == "Enemy"

func _ready():
	$TurnTick.wait_time = rand_range(0.5, 3)

func _process(delta):
	if target.is_empty() || get_node_or_null(target) == null:
		for body in $SenseArea.get_overlapping_bodies():
			if body.is_class("Soldier") || body.is_class("Player"):
				target = body.get_path()
				print(target)
	if get_node_or_null(target) != null:
		if not shooting:
			shooting = true
			$Gun.aim(get_node(target).get_class())
			ani.play("Aim")
			$AimingTimer.wait_time = rand_range(4.0, 8.0)
			$AimingTimer.start()

func die():
	ani.play("Die")


func _on_AimingTimer_timeout():
	$Gun.shoot()
	ani.play("Shoot")
	$AimingTimer.stop()
	target = NodePath()
	shooting = false

func _on_TurnTick_timeout():
	if get_node_or_null(target) != null:
		look_at(get_node(target).global_transform.origin, Vector3.UP)
		rotation.x = 0
		rotation.z = 0


func _on_Reset_timeout():
	target = NodePath()


func _on_Animations_animation_finished(anim_name):
	if anim_name == "Die":
		queue_free()
