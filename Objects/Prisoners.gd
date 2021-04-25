extends Spatial

export var soldiers_path : NodePath
export var player_path : NodePath
export var navigation_path : NodePath
onready var soldiers = get_node(soldiers_path)
onready var player = get_node(player_path)
onready var soldier_resource = load("res://Objects/Soldier.tscn")
onready var level = $".."

func _ready():
	$AnimationPlayer.play("reset")

func _on_Area_body_entered(body):
	if body.is_class("Player"):
		$AnimationPlayer.play("FromDutchToBelgian")


func _on_Area_body_exited(body):
	if body.is_class("Player"):
		$AnimationPlayer.play("reset")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FromDutchToBelgian":
		var new_soldiers = []
		level.total_prisoners_freed += 4
		for i in range(4):
			var soldier = soldier_resource.instance()
			soldiers.add_child(soldier)
			soldier.global_transform.origin = global_transform.origin + Vector3.FORWARD * (-3 + i*2)
			soldier.nav = get_node(navigation_path)
			if not player.assign_rank(soldier):
				soldier.queue_free()
				break
			new_soldiers.append(soldier)

		queue_free()


