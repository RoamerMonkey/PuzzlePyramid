extends Control

var sidelist : PackedStringArray = ["Front", "Right", "Back", "Left"]
var currentside : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Timer/Timer.paused = true
	$HUD/Timer/TimerLabel.visible = true
	$HUD/HelpButton.disabled = true
	$HUD/HelpButton/HintButton.visible = true
	$HUD/DisabledButton.visible = true
	$HUD/InfoTop.text = "Pick a side!"
	$HUD/Infobox.text = "You can do it!"
	if GlobalStats.location == "mg_1" or GlobalStats.location == "ho_1":
		currentside = 0
	elif GlobalStats.location == "mg_2" or GlobalStats.location == "ho_2":
		currentside = 1
	elif GlobalStats.location == "mg_3" or GlobalStats.location == "ho_3":
		currentside = 3
	GlobalStats.location = "pyramid_hub"
	Bgm.get_stream_playback().switch_to_clip_by_name("Main")
	var tween = create_tween().set_loops()
	tween.tween_property($Pyramid, "position", Vector2(911, 425), 2)
	tween.tween_property($Pyramid, "position", Vector2(911, 405), 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentside == -1:
		currentside = 3
	elif currentside == 4:
		currentside = 0
	if currentside == 0 && GlobalStats.ho1 == false:
		$Pyramid.frame = 3
		$PlayButton.visible = true
		$Completed.visible = false
	elif currentside == 0 && GlobalStats.ho1 == true:
		$Pyramid.frame = 0
		$PlayButton.visible = false
		$Completed.visible = true
	elif currentside == 1 && GlobalStats.ho2 == false:
		$Pyramid.frame = 4
		$PlayButton.visible = true
		$Completed.visible = false
	elif currentside == 1 && GlobalStats.ho2 == true:
		$Pyramid.frame = 1
		$PlayButton.visible = false
		$Completed.visible = true
	elif currentside == 2:
		$Pyramid.frame = 6
	elif currentside == 3 && GlobalStats.ho3 == false:
		$Pyramid.frame = 5
		$PlayButton.visible = true
		$Completed.visible = false
	elif currentside == 3 && GlobalStats.ho3 == true:
		$Pyramid.frame = 2
		$PlayButton.visible = false
		$Completed.visible = true

func _on_left_arrow_button_down() -> void:
	currentside -= 1
	$PlayButton.visible = false
	$Completed.visible = false
	$Buttonclick.play()

func _on_right_arrow_button_down() -> void:
	currentside += 1
	$PlayButton.visible = false
	$Completed.visible = false
	$Buttonclick.play()

func _on_left_arrow_mouse_entered() -> void:
	$Buttonhover.play()

func _on_right_arrow_mouse_entered() -> void:
	$Buttonhover.play()

func _on_play_button_button_down() -> void:
	$HUD/Popup/Transition.play()
	if currentside == 0:
		GlobalStats.location = "mg_1"
	elif currentside == 1:
		GlobalStats.location = "mg_2"
	elif currentside == 3:
		GlobalStats.location = "mg_3"
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scripts/" + GlobalStats.location + ".tscn")

func _on_play_button_mouse_entered() -> void:
	$Buttonhover.play()
