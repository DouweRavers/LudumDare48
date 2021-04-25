extends Control

func _on_Button_pressed():
	Singleton.load_scene("StoryBasic")


func _on_HowToPlay_pressed():
	OS.shell_open("https://docs.google.com/presentation/d/e/2PACX-1vRybf11XvACytUgWoeB9J8dXaxMe3Rlh4pTXg7xiAoGkA4Ba8-DlKr1a-ddlL7Dgtxk55LSYVmW-IOw/pub?start=false&loop=false&delayms=5000")
