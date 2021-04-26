extends Spatial

var total_prisoners = 32
var total_prisoners_freed = 0
var total_enemies = 0
var total_living_enemies = 0

func _ready():
	$Player/UI.show_message("Objective\nFree all prisoners!")
	total_enemies = 0
	for battalion in $Enemies.get_children():
		total_enemies += battalion.get_child_count()
	_on_Timer_timeout()

func _on_Timer_timeout():
	total_living_enemies = 0
	for battalion in $Enemies.get_children():
		total_living_enemies += battalion.get_child_count()


func _on_FinishGame_body_entered(body):
	if body.is_class("Player"):
		if total_prisoners - total_prisoners_freed == 0:
			Singleton.gamedata.cities["Diest"] = true
			$Player.get_node("UI").show_message("Yeah! You did it!")
			$FinishGame/wonTimer.start()
		else:
			$Player.get_node("UI").show_message("Not everyone is saved yet...")

func _on_wonTimer_timeout():
	Singleton.load_scene("StoryBasic")
