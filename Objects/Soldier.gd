extends KinematicBody

export var speed = 10
export var navigation_node : NodePath
export var target_node : NodePath

onready var nav : Navigation = get_node(navigation_node)
onready var target : Position3D = get_node(target_node)


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
		else:
			$Gun.cancel_aim()
	if Input.is_action_just_pressed("command_fire") && is_aiming:
		$Gun.shoot()
		is_aiming = false

func _physics_process(delta):
	if is_aiming:
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

func _on_Timer_timeout():
	move_to(target.global_transform.origin)

func move_to(pos):
	path = nav.get_simple_path(global_transform.origin, pos)
	path_node = 0

func die():
	queue_free()
