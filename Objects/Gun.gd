extends Spatial

onready var bullet_resource : Resource = load("res://Objects/bullet.tscn")

func aim(target_type):
	$AnimationPlayer.play("Aiming")
	$AimVolume.visible = true
	rotation.x = 0
	rotation.y = 0
	for body in $ScanningZone.get_overlapping_bodies():
		if body.is_class(target_type):
			look_at(body.global_transform.origin + Vector3.UP*2, Vector3.UP)
	$AnimationPlayer.play("AimGun")

func cancel_aim():
	$AimVolume.visible = false

func shoot():
	$AnimationPlayer.stop()
	$AimVolume.visible = false
	var max_offset = atan($AimVolume.radius/$AimVolume.height)
	rotate_x(rand_range(-max_offset, max_offset))
	rotate_y(rand_range(-max_offset, max_offset))
	$AnimationPlayer.play("Shoot")
	var bullet : RigidBody = bullet_resource.instance()
	get_tree().root.add_child(bullet)
	bullet.global_transform = $Gunpoint.global_transform
	var shoot_dir = global_transform.origin.direction_to($Gunpoint.global_transform.origin).normalized() * 1000
	bullet.add_central_force(shoot_dir)
