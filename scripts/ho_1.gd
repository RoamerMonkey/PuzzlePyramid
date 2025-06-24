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
	if len(GlobalStats.itemlist) == 0 and GlobalStats.location == "ho_1":
		initialitemlist = ["Aster", "Clock", "Diamond", "Eraser", "Eye", "Fire", "Flask",
						   "Heart", "House", "Key", "Magnifying Glass", "Mask", "Moon",
						   "Music Note", "Pi", "Pie", "Prototype", "Ship", "Signature",
						   "Skull", "Smile", "Star", "Strawberry", "Sword",
						   "Target", "Tear", "Tooth", "Trash", "Wheel", "Wings"]
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
			$Misclick.play()
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
			$Misclick.play()
	elif len(GlobalStats.itemlist) >= 1:
		if GlobalStats.itemlist[0] == itemname:
			randomplay()
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(0)
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
		GlobalStats.ho1 = true
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

func _on_aster_button_down() -> void:
	checkitem("Aster")
	$HUD/Infobox.text = "Hah, you found me!"
	checkdone()

func _on_clock_button_down() -> void:
	checkitem("Clock")
	checkdone()

func _on_diamond_button_down() -> void:
	checkitem("Diamond")
	checkdone()

func _on_eraser_button_down() -> void:
	checkitem("Eraser")
	checkdone()

func _on_eye_button_down() -> void:
	checkitem("Eye")
	checkdone()

func _on_fire_button_down() -> void:
	checkitem("Fire")
	checkdone()

func _on_flask_button_down() -> void:
	checkitem("Flask")
	checkdone()

func _on_heart_button_down() -> void:
	checkitem("Heart")
	checkdone()

func _on_house_button_down() -> void:
	checkitem("House")
	checkdone()

func _on_key_button_down() -> void:
	checkitem("Key")
	checkdone()

func _on_magnifying_glass_button_down() -> void:
	checkitem("Magnifying Glass")
	checkdone()

func _on_mask_button_down() -> void:
	checkitem("Mask")
	checkdone()

func _on_moon_button_down() -> void:
	checkitem("Moon")
	checkdone()

func _on_music_note_button_down() -> void:
	checkitem("Music Note")
	checkdone()

func _on_pi_button_down() -> void:
	checkitem("Pi")
	checkdone()

func _on_pie_button_down() -> void:
	checkitem("Pie")
	checkdone()

func _on_prototype_button_down() -> void:
	checkitem("Prototype")
	checkdone()

func _on_ship_button_down() -> void:
	checkitem("Ship")
	checkdone()

func _on_signature_button_down() -> void:
	checkitem("Signature")
	checkdone()

func _on_skull_button_down() -> void:
	checkitem("Skull")
	checkdone()

func _on_smile_button_down() -> void:
	checkitem("Smile")
	checkdone()

func _on_star_button_down() -> void:
	checkitem("Star")
	checkdone()

func _on_strawberry_button_down() -> void:
	checkitem("Strawberry")
	checkdone()

func _on_sword_button_down() -> void:
	checkitem("Sword")
	checkdone()

func _on_target_button_down() -> void:
	checkitem("Target")
	checkdone()

func _on_tear_button_down() -> void:
	checkitem("Tear")
	checkdone()

func _on_tooth_button_down() -> void:
	checkitem("Tooth")
	checkdone()

func _on_trash_button_down() -> void:
	checkitem("Trash")
	checkdone()

func _on_wheel_button_down() -> void:
	checkitem("Wheel")
	checkdone()

func _on_wings_button_down() -> void:
	checkitem("Wings")
	checkdone()
