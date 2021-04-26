extends KinematicBody

export var walk_speed = 14
export var turn_speed = 2
export var fall_acceleration = 75
export var soldiers_path : NodePath

onready var soldiers = get_node(soldiers_path)
onready var level = $".."

var health : int = 100

func get_class():
	return "Player"

func is_class(name):
	return name == "Player"

func _process(_delta):
	if Input.is_action_just_pressed("command_fire"):
		$Sword/AnimationPlayer.play("swing")
		$BelgVisual/Animations.play("Aim")
		for body in $SwordRange.get_overlapping_bodies():
			if body.is_class("Enemy"):
				body.die()
			if body.is_class("Tent"):
				body.burn()
		yield($BelgVisual/Animations, "animation_finished")
		$BelgVisual/Animations.play("Idle")

func _physics_process(delta):
	var velocity = Vector3.ZERO
	var forward = 0
	var turn = 0
	var animation = "Walk"
	if Input.is_action_pressed("move_right"):
		turn -= 1
	elif Input.is_action_pressed("move_left"):
		turn += 1
	elif Input.is_action_pressed("move_back"):
		forward += 1
	elif Input.is_action_pressed("move_forward"):
		forward -= 1
	elif $BelgVisual/Animations.current_animation != "Idle":
		animation = "Idle"
	if $BelgVisual/Animations.current_animation != animation:
		$BelgVisual/Animations.play(animation)
	velocity += forward * walk_speed * transform.basis.z.normalized()
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	rotate_y(turn * turn_speed * delta)

func assign_rank(soldier):
	for pos in $Positions.get_children():
		if pos.visible:
			soldier.target = pos
			pos.visible = false
			return true
	return false

func hit():
	health -= 20
	if health < 0 && $gameover.is_stopped():
		$gameover.start()
		$UI.show_message("Your dead!")

func _on_gameover_timeout():
	Singleton.load_scene("StoryBasic")
