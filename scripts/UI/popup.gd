extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalStats.mode == true:
		$Info/InfoAsk/Title.text = "Do you want the puzzle instructions? You will lose a quarter of your time!"
		$Skip/Title.text = "Are you sure you want to skip the puzzle? Your time will be halved!"

func _process(delta: float) -> void:
	self.z_index = GlobalStats.zindex

# CREDITS
func _on_right_arrow_button_down() -> void:
	get_node("Credits/Page1").visible = false
	get_node("Credits/Page2").visible = true
	$Buttonclick.play()

func _on_left_arrow_button_down() -> void:
	get_node("Credits/Page1").visible = true
	get_node("Credits/Page2").visible = false
	$Buttonclick.play()

func _on_credits_x_button_down() -> void:
	get_node(".").visible = false
	get_node("Credits").visible = false
	$Buttonclick.play()

#EXIT
func _on_exit_yes_button_down() -> void:
	get_tree().quit()
	$Buttonclick.play()

func _on_exit_no_button_down() -> void:
	if $Pause.visible == false:
		get_node(".").visible = false
	get_node("Exit").visible = false
	$Buttonclick.play()

#INFO
func _on_info_yes_button_down() -> void:
	get_node("Info/InfoAsk").visible = false
	get_node("Info/InfoXButton").visible = true
	if GlobalStats.location == "mg_1":
		get_node("Info/Puzzle1").visible = true
	elif GlobalStats.location == "mg_2":
		get_node("Info/Puzzle2").visible = true
	elif GlobalStats.location == "mg_3":
		get_node("Info/Puzzle3").visible = true
	GlobalStats.timeleftmin *= 0.75
	GlobalStats.timeleftsec *= 0.75
	$Buttonclick.play()

func _on_info_no_button_down() -> void:
	get_node(".").visible = false
	get_node("Info").visible = false
	$Buttonclick.play()
	$"../Timer/Timer".paused = false
	$"../HelpButton/SkipTimer".paused = false

func _on_info_x_button_button_down() -> void:
	get_node(".").visible = false
	get_node("Info").visible = false
	$Buttonclick.play()
	$"../Timer/Timer".paused = false
	$"../HelpButton/SkipTimer".paused = false

#SKIP
func _on_skip_yes_button_down() -> void:
	get_node(".").visible = false
	get_node("Skip").visible = false
	if GlobalStats.location == "mg_1":
		GlobalStats.mg1 = true
		GlobalStats.location = "ho_1"
	elif GlobalStats.location == "mg_2":
		GlobalStats.mg2 = true
		GlobalStats.location = "ho_2"
	elif GlobalStats.location == "mg_3":
		GlobalStats.mg3 = true
		GlobalStats.location = "ho_3"
	GlobalStats.timeleftmin /= 2
	GlobalStats.timeleftsec /= 2
	$Transition.play()
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scripts/" + GlobalStats.location + ".tscn")

func _on_skip_no_button_down() -> void:
	get_node(".").visible = false
	get_node("Skip").visible = false
	$Buttonclick.play()
	$"../Timer/Timer".paused = false
	$"../HelpButton/SkipTimer".paused = false

#TIMEOUT
func _on_time_yup_button_down() -> void:
	get_node(".").visible = false
	get_node("TimeOut").visible = false
	if GlobalStats.location == "mg_1" or GlobalStats.location == "ho_1":
		GlobalStats.mg1 = false
		GlobalStats.ho1 = false
	elif GlobalStats.location == "mg_2" or GlobalStats.location == "ho_2":
		GlobalStats.mg2 = false
		GlobalStats.ho2 = false
	elif GlobalStats.location == "mg_3" or GlobalStats.location == "ho_3":
		GlobalStats.mg3 = false
		GlobalStats.ho3 = false
	GlobalStats.itemlist = []
	GlobalStats.timeleftmin = GlobalStats.maxtime
	GlobalStats.timeleftsec = 0
	GlobalStats.mode = true
	$Buttonclick.play()
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scripts/pyramid_hub.tscn")

#OPTIONS
func _on_window_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(960,720))
		GlobalStats.window = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		DisplayServer.window_set_size(Vector2i(1440,1080))
		GlobalStats.window = false
	$Buttonclick.play()

func _on_cursor_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		GlobalStats.cursor = true
	else:
		GlobalStats.cursor = false
	$Buttonclick.play()

func _on_options_x_button_down() -> void:
	if $Pause.visible == false:
		get_node(".").visible = false
	get_node("Options").visible = false
	$Buttonclick.play()
	
#DIFFICULTY
func _on_difficulty_x_button_down() -> void:
	if $Pause.visible == false:
		get_node(".").visible = false
	get_node("Difficulty").visible = false
	$Buttonclick.play()

func _on_time_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		get_node("Difficulty/TimerTitle/TimeScale").set_editable(false)
		$Difficulty/TimerTitle.text = "Timer (XX min : XX s) For Each Round:"
		GlobalStats.mode = false
	else:
		get_node("Difficulty/TimerTitle/TimeScale").set_editable(true)
		$Difficulty/TimerTitle.text = "Timer (" + str(GlobalStats.maxtime) + " min : 00 s) For Each Round:"
		GlobalStats.mode = true
	$Buttonclick.play()

func _on_item_scale_value_changed(value: float) -> void:
	GlobalStats.itemnum = int(value)
	$Difficulty/ItemTitle.text = "Number of Hidden Objects To Find (" + str(GlobalStats.itemnum) + ") Per Round:"

func _on_time_scale_value_changed(value: float) -> void:
	GlobalStats.maxtime = int(value)
	$Difficulty/TimerTitle.text = "Timer (" + str(GlobalStats.maxtime) + " min : 00 s) For Each Round:"

func _on_hint_scale_value_changed(value: float) -> void:
	GlobalStats.hint = int(value)
	$Difficulty/HintTitle.text = "Object Hint Charge Time: (" + str(GlobalStats.hint) + " s):"

func _on_skip_scale_value_changed(value: float) -> void:
	GlobalStats.skip = int(value)
	$Difficulty/SkipTitle.text = "Puzzle Skip Charge Time: (" + str(GlobalStats.skip) + " s):"

func _on_difficulty_play_button_down() -> void:
	$Buttonclick.play()
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scripts/dialogue.tscn")

#PROGRESS
func _on_player_x_button_down() -> void:
	get_node(".").visible = false
	get_node("Progress").visible = false
	$Progress/ConfirmLoad.visible = false
	$Progress/ConfirmReset.visible = false
	$Buttonclick.play()

func _on_reset_button_down() -> void:
	$Progress/Buttons.visible = false
	$Progress/PlayerSure.visible = true
	$Progress/ConfirmLoad.visible = false
	$Progress/ConfirmReset.visible = false
	$Buttonclick.play()

func _on_player_yes_button_down() -> void:
	$Progress/Buttons.visible = true
	$Progress/PlayerSure.visible = false
	$Progress/ConfirmReset.visible = true
	GlobalStats.location = "dialogue"
	GlobalStats.timeleftmin = 12
	GlobalStats.timeleftsec = 0
	GlobalStats.mg1 = false
	GlobalStats.mg2 = false
	GlobalStats.mg3 = false
	GlobalStats.ho1 = false
	GlobalStats.ho2 = false
	GlobalStats.ho3 = false
	GlobalStats.itemlist = []
	GlobalStats.bgm = 1.0
	$Options/BGMLabel/BGM.value = GlobalStats.bgm
	GlobalStats.sfx = 1.0
	$Options/SFXLabel/SFX.value = GlobalStats.sfx
	GlobalStats.window = false
	_on_window_button_toggled(GlobalStats.window)
	GlobalStats.cursor = true
	GlobalStats.itemnum = 12
	$Difficulty/ItemTitle/ItemScale.value = GlobalStats.itemnum
	GlobalStats.mode = true
	_on_time_button_toggled(not GlobalStats.mode)
	GlobalStats.maxtime = 12
	$Difficulty/TimerTitle/TimeScale.value = GlobalStats.maxtime
	GlobalStats.hint = 60
	$Difficulty/HintTitle/HintScale.value = GlobalStats.hint
	GlobalStats.skip = 60
	$Difficulty/SkipTitle/SkipScale.value = GlobalStats.skip
	GlobalStats.firsttime = true
	$Buttonclick.play()

func _on_player_no_button_down() -> void:
	$Progress/Buttons.visible = true
	$Progress/PlayerSure.visible = false
	$Buttonclick.play()

#PAUSE
func _on_pause_resume_button_down() -> void:
	get_node(".").visible = false
	get_node("Pause").visible = false
	$Buttonclick.play()
	$"../Timer/Timer".paused = false
	$"../HelpButton/HintTimer".paused = false
	$"../HelpButton/SkipTimer".paused = false

func _on_pause_option_button_down() -> void:
	$Options.visible = true
	$Buttonclick.play()
	$Pause/ConfirmSave.visible = false

func _on_pause_menu_button_down() -> void:
	get_node(".").visible = false
	get_node("Pause").visible = false
	$Buttonclick.play()
	$Pause/ConfirmSave.visible = false
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scripts/main_menu.tscn")

func _on_pause_exit_button_down() -> void:
	$Exit.visible = true
	$Buttonclick.play()
	$Pause/ConfirmSave.visible = false

#SLIDERSFX
func _on_bgm_drag_ended(value_changed: bool) -> void:
	$Slidedrop.play()

func _on_sfx_drag_ended(value_changed: bool) -> void:
	$Slidedrop.play()

func _on_item_scale_drag_ended(value_changed: bool) -> void:
	$Slidedrop.play()

func _on_time_scale_drag_ended(value_changed: bool) -> void:
	$Slidedrop.play()

func _on_hint_scale_drag_ended(value_changed: bool) -> void:
	$Slidedrop.play()

func _on_skip_scale_drag_ended(value_changed: bool) -> void:
	$Slidedrop.play()
