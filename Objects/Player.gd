extends KinematicBody

export var walk_speed = 14
export var turn_speed = 2
export var fall_acceleration = 75

func get_class():
	return "Player"

func is_class(name):
	return name == "Player"

func _physics_process(delta):
	var velocity = Vector3.ZERO
	var forward = 0
	var turn = 0
	
	if Input.is_action_pressed("move_right"):
		turn -= 1
	if Input.is_action_pressed("move_left"):
		turn += 1
	if Input.is_action_pressed("move_back"):
		forward += 1
	if Input.is_action_pressed("move_forward"):
		forward -= 1
	velocity += forward * walk_speed * transform.basis.z.normalized()
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	rotate_y(turn * turn_speed * delta)

func hit():
	print("auwch")
