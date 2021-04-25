extends KinematicBody

export var speed = 10
onready var nav : Navigation
onready var target : Position3D


var path = []
var path_node = 0
var is_aiming : bool = false

func get_class():
	return "Soldier"

func is_class(name):
	return name == "Soldier"

func _process(delta):
	if Input.is_action_just_pressed("command_take_aim"):
		is_aiming = !is_aiming
		if is_aiming:
			$Gun.aim("Enemy")
			$BelgVisual/Animations.play("Aim")
		else:
			$Gun.cancel_aim()
			$BelgVisual/Animations.play("Idle")
	if Input.is_action_just_pressed("command_fire") && is_aiming:
		$Gun.shoot()
		$BelgVisual/Animations.play("Shoot")


func _physics_process(delta):
	if is_aiming || $BelgVisual/Animations.current_animation == "Die":
		return
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 0.5:
			path_node += 1
		else:
			look_at(global_transform.origin + direction, Vector3.UP)
			move_and_slide(direction.normalized() * speed, Vector3.UP)
	else:
		global_transform.basis = target.global_transform.basis
		$BelgVisual/Animations.play("Idle")

func _on_Timer_timeout():
	if not $BelgVisual/Animations.current_animation == "Die":
		move_to(target.global_transform.origin)

func move_to(pos):
	if not is_aiming:
		$BelgVisual/Animations.play("Walk")
		path = nav.get_simple_path(global_transform.origin, pos)
		path_node = 0

func die():
	target.visible = true
	$Gun.visible = false
	$BelgVisual/Animations.play("Die")
	set_process(false)



func _on_Animations_animation_finished(anim_name):
	if anim_name == "Shoot":
		is_aiming = false
	if anim_name == "Die":
		queue_free()
