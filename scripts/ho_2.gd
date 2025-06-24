extends Control

var initialitemlist : PackedStringArray

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Timer/Timer.paused = false
	$HUD/Timer/Timer.start()
	$HUD/HelpButton.disabled = true
	$HUD/DisabledButton.visible = true
	$HUD/HelpButton/HintButton.visible = true
	$HUD/HelpButton/SkipButton.visible = false
	$HUD/HelpButton/HintTimer.start()
	$HUD/Items.visible = true
	$HUD/HelpButton/HintButton.value = 0
	$HUD/HelpButton/SkipButton.value = 0
	get_node("HUD/Popup/Info/InfoAsk").visible = true
	get_node("HUD/Popup/Info/Puzzle1").visible = false
	get_node("HUD/Popup/Info/Puzzle2").visible = false
	get_node("HUD/Popup/Info/Puzzle3").visible = false
	Bgm.get_stream_playback().switch_to_clip_by_name("HO")
	if len(GlobalStats.itemlist) == 0 and GlobalStats.location == "ho_2":
		initialitemlist = ["Bug", "Tulip", "Pinecone", "Light Bulb", "Clock", "Radio", "Lock", "Lava Lamp",
						   "Robot", "Battery", "Globe", "Queen", "Microphone", "Duck", "Cactus",
						   "Sticker", "Hourglass", "Orb", "Camera", "Quill", "Thirteen", "Bottle",
						   "Candlestick", "Microscope", "Mirror", "Lantern", "Binoculars",
						   "Crack", "Light Switch", "Hookah"]
		initialize_hos()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HUD/InfoTop.text = "Find " + str(len(GlobalStats.itemlist)) + " items!"
	if len(GlobalStats.itemlist) >= 1:
		$HUD/Items/Item1.text = GlobalStats.itemlist[0]
	else:
		$HUD/Items/Item1.text = ""
	if len(GlobalStats.itemlist) >= 2:
		$HUD/Items/Item2.text = GlobalStats.itemlist[1]
	else:
		$HUD/Items/Item2.text = ""
	if len(GlobalStats.itemlist) >= 3:
		$HUD/Items/Item3.text = GlobalStats.itemlist[2]
	else:
		$HUD/Items/Item3.text = ""

func initialize_hos():
	for i in len(initialitemlist):
		get_node(initialitemlist[i]).visible = true
	for i in range(GlobalStats.itemnum):
		var randomindex = randi_range(0, len(initialitemlist) - 1)
		GlobalStats.itemlist.append(initialitemlist[randomindex])
		initialitemlist.remove_at(randomindex)

func checkitem(itemname : String):
	if len(GlobalStats.itemlist) >= 3:
		if GlobalStats.itemlist[2] == itemname:
			randomplay()
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(2)
		elif GlobalStats.itemlist[1] == itemname:
			randomplay()
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(1)
		elif GlobalStats.itemlist[0] == itemname:
			randomplay()
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(0)
		else:
			funlight(itemname)
	elif len(GlobalStats.itemlist) >= 2:
		if GlobalStats.itemlist[1] == itemname:
			randomplay()
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(1)
		elif GlobalStats.itemlist[0] == itemname:
			randomplay()
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(0)
		else:
			funlight(itemname)
	elif len(GlobalStats.itemlist) >= 1:
		if GlobalStats.itemlist[0] == itemname:
			randomplay()
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(0)
		else:
			funlight(itemname)

func funlight(itemname : String):
	if itemname == "Light Switch":
		$HUD/Infobox.text = "Phew, it didn't explode that time."
		$"Light Switch".disabled = true
		$"Light Bulb".disabled = true
		$Slidedrop.play()
		await get_tree().create_timer(1).timeout
		$"Light Switch".disabled = false
		$"Light Bulb".disabled = false
		$"Light Switch".button_pressed = false
	else:
		$Misclick.play()

func randomplay():
	match randi_range(0, 2):
		0:
			$Itemget1.play()
			$HUD/Infobox.text = "Nice find."
		1:
			$Itemget2.play()
			$HUD/Infobox.text = "Good work."
		2:
			$Itemget3.play()
			$HUD/Infobox.text = "Great!"

func itemdisappear(itemname : String):
	get_node(itemname).set_pivot_offset(get_node(itemname).size/2)
	var tween = create_tween()
	tween.tween_property(get_node(itemname), "scale", Vector2(1.5,1.5), 0.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(get_node(itemname), "modulate:a", 0, 0.5)
	await get_tree().create_timer(1).timeout
	get_node(itemname).visible = false

func checkdone():
	if len(GlobalStats.itemlist) == 0:
		Bgm.get_stream_playback().switch_to_clip_by_name("Silence")
		$HUD/Timer/Timer.paused = true
		$HUD/MenuButton.disabled = true
		$HUD/HelpButton.disabled = true
		$HUD/HelpButton/HintTimer.paused = true
		GlobalStats.ho2 = true
		await get_tree().create_timer(1.0).timeout
		$Hodone.play()
		await get_tree().create_timer(3.5).timeout
		$HUD/Popup/Transition.play()
		GlobalStats.timeleftmin = GlobalStats.maxtime
		GlobalStats.timeleftsec = 0
		Transition.transition()
		await Transition.on_transition_finished
		if GlobalStats.ho1 == true and GlobalStats.ho2 == true and GlobalStats.ho3 == true:
			Bgm.get_stream_playback().switch_to_clip_by_name("Main")
			get_tree().change_scene_to_file("res://scripts/dialogue.tscn")
		else:
			get_tree().change_scene_to_file("res://scripts/pyramid_hub.tscn")

func _on_bg_button_down() -> void:
	$Misclick.play()

func _on_bug_button_down() -> void:
	checkitem("Bug")
	checkdone()

func _on_tulip_button_down() -> void:
	checkitem("Tulip")
	checkdone()

func _on_pinecone_button_down() -> void:
	checkitem("Pinecone")
	checkdone()

func _on_lightbulb_button_down() -> void:
	checkitem("Light Bulb")
	checkdone()

func _on_clock_button_down() -> void:
	checkitem("Clock")
	checkdone()

func _on_radio_button_down() -> void:
	checkitem("Radio")
	checkdone()

func _on_lock_button_down() -> void:
	checkitem("Lock")
	checkdone()

func _on_lava_lamp_button_down() -> void:
	checkitem("Lava Lamp")
	checkdone()

func _on_robot_button_down() -> void:
	checkitem("Robot")
	checkdone()

func _on_battery_button_down() -> void:
	checkitem("Battery")
	checkdone()

func _on_globe_button_down() -> void:
	checkitem("Globe")
	checkdone()

func _on_queen_button_down() -> void:
	checkitem("Queen")
	checkdone()

func _on_microphone_button_down() -> void:
	checkitem("Microphone")
	checkdone()

func _on_duck_button_down() -> void:
	checkitem("Duck")
	checkdone()

func _on_cactus_button_down() -> void:
	checkitem("Cactus")
	checkdone()

func _on_sticker_button_down() -> void:
	checkitem("Sticker")
	checkdone()

func _on_hourglass_button_down() -> void:
	checkitem("Hourglass")
	checkdone()

func _on_orb_button_down() -> void:
	checkitem("Orb")
	checkdone()

func _on_camera_button_down() -> void:
	checkitem("Camera")
	checkdone()

func _on_quill_button_down() -> void:
	checkitem("Quill")
	checkdone()

func _on_thirteen_button_down() -> void:
	checkitem("Thirteen")
	checkdone()

func _on_bottle_button_down() -> void:
	checkitem("Bottle")
	checkdone()

func _on_candlestick_button_down() -> void:
	checkitem("Candlestick")
	checkdone()

func _on_microscope_button_down() -> void:
	checkitem("Microscope")
	checkdone()

func _on_mirror_button_down() -> void:
	checkitem("Mirror")
	checkdone()

func _on_lantern_button_down() -> void:
	checkitem("Lantern")
	checkdone()

func _on_binoculars_button_down() -> void:
	checkitem("Binoculars")
	checkdone()

func _on_crack_button_down() -> void:
	checkitem("Crack")
	checkdone()

func _on_lightswitch_button_down() -> void:
	checkitem("Light Switch")
	checkdone()

func _on_hookah_button_down() -> void:
	checkitem("Hookah")
	checkdone()
