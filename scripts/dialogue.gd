extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalStats.firsttime == true:
		Dialogic.start("Intro")
		await Dialogic.timeline_ended
		GlobalStats.firsttime = false
		GlobalStats.location = "pyramid_hub"
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scripts/pyramid_hub.tscn")
	else:
		Dialogic.start("Outro")
		await Dialogic.timeline_ended
		GlobalStats.location = "dialogue"
		GlobalStats.itemnum = 12
		GlobalStats.maxtime = 12
		GlobalStats.timeleftmin = 12
		GlobalStats.timeleftsec = 0
		GlobalStats.mode = true
		GlobalStats.hint = 60
		GlobalStats.skip = 60
		GlobalStats.mg1 = false
		GlobalStats.mg2 = false
		GlobalStats.mg3 = false
		GlobalStats.ho1 = false
		GlobalStats.ho2 = false
		GlobalStats.ho3 = false
		GlobalStats.itemlist = []
		GlobalStats.firsttime = true
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scripts/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
