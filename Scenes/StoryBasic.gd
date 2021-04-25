extends Panel
var unlockmat = load("res://materials/UnlockedMaterial.tres")

func _ready():
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
		#if time over play a final animation here

func _on_Leuven_pressed():
	Singleton.load_scene("BattleOfLeuven")

func _on_Diest_pressed():
	Singleton.load_scene("BattleOfDiest")

func _on_Turnhout_pressed():
	Singleton.gamedata.cities["Turnhout"] = true
	Singleton.load_scene("StoryBasic")


func _on_Button_pressed():
	$AnimationPlayer.advance(40-$AnimationPlayer.current_animation_position)

