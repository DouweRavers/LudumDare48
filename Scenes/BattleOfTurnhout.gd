extends Spatial

var total_prisoners = 32
var total_prisoners_freed = 0
var total_enemies = 0
var total_tents = 0
var total_living_enemies = 0
var total_burned_tents = 0
var ticker : int = 420

func _ready():
	$Player/UI.show_message("Objective\nBurn all the tents!!")
	total_enemies = 0
	for battalion in $Enemies.get_children():
		total_enemies += battalion.get_child_count()
	for tent_division in $Turnhout/NavigationMeshInstance/Camp/Tents.get_children():
		total_tents += tent_division.get_child_count()
	_on_Timer_timeout()

func _on_Timer_timeout():
	total_living_enemies = 0
	total_burned_tents = 0
	for battalion in $Enemies.get_children():
		total_living_enemies += battalion.get_child_count()
	for tent_division in $Turnhout/NavigationMeshInstance/Camp/Tents.get_children():
		for tent in tent_division.get_children():
			if tent.burned:
				total_burned_tents += 1
	if total_burned_tents == total_tents:
		$Player/UI.show_message("Wow! All of them? dahmmm..")
		$wintimer.start()

func _on_TimeGameTimer_timeout():
	ticker -= 1
	$TimeGameMode/timerDisplay.text = str(ticker/60) + " : " + str(ticker%60)
	$TimeGameMode/Score.text = str(total_burned_tents) + " / " + str(total_tents)
	if ticker == 0:
		$Player/UI.show_message("Wow! " + str(total_burned_tents) + " Tents.")
		$wintimer.start()


func _on_wintimer_timeout():
	Singleton.gamedata.cities["Turnhout"] = true
	Singleton.load_scene("StoryBasic")
