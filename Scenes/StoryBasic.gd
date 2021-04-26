extends Panel
var unlockmat = load("res://materials/UnlockedMaterial.tres")

func _ready():
	$AnimationPlayer.play("Default")
	if not Singleton.gamedata.had_intro:
		$AnimationPlayer.play("StoryStart")
		Singleton.gamedata.had_intro = true
	if Singleton.gamedata.cities["Leuven"]:
		$UI/Diest.disabled = false
		$Background/Leuven.material_override = unlockmat
	if Singleton.gamedata.cities["Diest"]:
		$UI/Turnhout.disabled = false
		$Background/Diest.material_override = unlockmat
	if Singleton.gamedata.cities["Turnhout"]:
		$Background/Turnhout.material_override = unlockmat
		if not Singleton.gamedata.had_ending:
			$AnimationPlayer.play("Finished")
			Singleton.gamedata.had_ending = true

func _on_Leuven_pressed():
	Singleton.load_scene("BattleOfLeuven")

func _on_Diest_pressed():
	Singleton.load_scene("BattleOfDiest")

func _on_Turnhout_pressed():
	Singleton.load_scene("BattleOfTurnhout")

func _on_Button_pressed():
	$AnimationPlayer.advance(40-$AnimationPlayer.current_animation_position)

func _on_Play_pressed():
	Singleton.load_scene("StartMenu")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Finished":
		Singleton.load_scene("StartMenu")
