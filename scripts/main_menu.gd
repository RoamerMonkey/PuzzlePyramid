extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bgm.play()
	Bgm.get_stream_playback().switch_to_clip_by_name("Main")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_credits_button_button_down() -> void:
	get_node("Popup").visible = true
	get_node("Popup/Credits").visible = true
	$SFXButton.play()

func _on_exit_button_button_down() -> void:
	get_node("Popup").visible = true
	get_node("Popup/Exit").visible = true
	$SFXButton.play()

func _on_options_button_button_down() -> void:
	get_node("Popup").visible = true
	get_node("Popup/Options").visible = true
	get_node("Popup/Options/Windowed/WindowButton").button_pressed = GlobalStats.window
	get_node("Popup/Options/CustomCursor/CursorButton").button_pressed = GlobalStats.cursor
	$SFXButton.play()

func _on_progress_button_button_down() -> void:
	get_node("Popup").visible = true
	get_node("Popup/Progress").visible = true
	$SFXButton.play()

func _on_play_button_button_down() -> void:
	$SFXButton.play()
	if GlobalStats.firsttime == true:
		get_node("Popup").visible = true
		get_node("Popup/Difficulty").visible = true
		$"Popup/Difficulty/ItemTitle".text = "Number of Hidden Objects To Find (" + str(GlobalStats.itemnum) + ") Per Round:"
		$"Popup/Difficulty/TimerTitle".text = "Timer (" + str(GlobalStats.maxtime) + " min : 00 s) For Each Round:"
		$"Popup/Difficulty/HintTitle".text = "Object Hint Charge Time: (" + str(GlobalStats.hint) + " s):"
		$"Popup/Difficulty/SkipTitle".text = "Puzzle Skip Charge Time: (" + str(GlobalStats.skip) + " s):"
		$"Popup/Difficulty/TimerTitle/TimeScale".set_editable(true)
	else:
		Transition.transition()
		await Transition.on_transition_finished
		if not GlobalStats.location == "pyramid_hub":
			get_tree().change_scene_to_file("res://scripts/" + GlobalStats.location + ".tscn")
		else:
			get_tree().change_scene_to_file("res://scripts/pyramid_hub.tscn")

func _on_play_button_mouse_entered() -> void:
	$SFXHover.play()

func _on_options_button_mouse_entered() -> void:
	$SFXHover.play()

func _on_credits_button_mouse_entered() -> void:
	$SFXHover.play()

func _on_progress_button_mouse_entered() -> void:
	$SFXHover.play()

func _on_exit_button_mouse_entered() -> void:
	$SFXHover.play()
