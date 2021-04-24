extends Control

onready var max_val = Singleton.loader.get_stage_count()

func _process(_delta):
	if Singleton.loader != null:
		$ProgressBar.value = 100 * Singleton.loader.get_stage() / max_val
