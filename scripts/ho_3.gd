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
	if len(GlobalStats.itemlist) == 0 and GlobalStats.location == "ho_3":
		initialitemlist = ["Crutch", "Toothbrush", "Skull", "Arrow", "Calculator", "Plushie", "Cat",
						   "Rat", "Ruler", "Tie", "Chair", "Controller", "Leaf", "Pump", "Plunger",
						   "Saw", "Bowl", "Potion", "Tablet", "Glasses", "Mace", "Sock", "Bell",
						   "Magnet", "Umbrella", "Puppet", "Frisbee", "Angry", "Hat", "Gem"]
		initialize_hos()
	var tween = create_tween().set_loops()
	tween.tween_property($Gem, "position", Vector2(861, 479), 2)
	tween.tween_property($Gem, "position", Vector2(861, 467), 2)

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
			randomplay(itemname)
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(2)
		elif GlobalStats.itemlist[1] == itemname:
			randomplay(itemname)
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(1)
		elif GlobalStats.itemlist[0] == itemname:
			randomplay(itemname)
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(0)
		else:
			$Misclick.play()
	elif len(GlobalStats.itemlist) >= 2:
		if GlobalStats.itemlist[1] == itemname:
			randomplay(itemname)
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(1)
		elif GlobalStats.itemlist[0] == itemname:
			randomplay(itemname)
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(0)
		else:
			$Misclick.play()
	elif len(GlobalStats.itemlist) >= 1:
		if GlobalStats.itemlist[0] == itemname:
			randomplay(itemname)
			itemdisappear(itemname)
			GlobalStats.itemlist.remove_at(0)
		else:
			$Misclick.play()

func randomplay(itemname : String):
	if itemname == "Gem":
		Bgm.get_stream_playback().switch_to_clip_by_name("Silence")
		$Gemget.play()
		$HUD/Infobox.text = "..."
		await get_tree().create_timer(1.0).timeout
		Bgm.get_stream_playback().switch_to_clip_by_name("HO")
	elif itemname == "Pump":
		$Itemget1.play()
		$HUD/Infobox.text = "Tricky one, right?"
	else:
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
		GlobalStats.ho3 = true
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

func _on_crutch_button_down() -> void:
	checkitem("Crutch")
	checkdone()

func _on_toothbrush_button_down() -> void:
	checkitem("Toothbrush")
	checkdone()

func _on_skull_button_down() -> void:
	checkitem("Skull")
	checkdone()

func _on_arrow_button_down() -> void:
	checkitem("Arrow")
	checkdone()

func _on_calculator_button_down() -> void:
	checkitem("Calculator")
	checkdone()

func _on_plushie_button_down() -> void:
	checkitem("Plushie")
	checkdone()

func _on_cat_button_down() -> void:
	checkitem("Cat")
	checkdone()

func _on_rat_button_down() -> void:
	checkitem("Rat")
	checkdone()

func _on_ruler_button_down() -> void:
	checkitem("Ruler")
	checkdone()

func _on_tie_button_down() -> void:
	checkitem("Tie")
	checkdone()

func _on_chair_button_down() -> void:
	checkitem("Chair")
	checkdone()

func _on_controller_button_down() -> void:
	checkitem("Controller")
	checkdone()

func _on_leaf_button_down() -> void:
	checkitem("Leaf")
	checkdone()

func _on_pump_button_down() -> void:
	checkitem("Pump")
	checkdone()

func _on_plunger_button_down() -> void:
	checkitem("Plunger")
	checkdone()

func _on_saw_button_down() -> void:
	checkitem("Saw")
	checkdone()

func _on_bowl_button_down() -> void:
	checkitem("Bowl")
	checkdone()

func _on_potion_button_down() -> void:
	checkitem("Potion")
	checkdone()

func _on_tablet_button_down() -> void:
	checkitem("Tablet")
	checkdone()

func _on_glasses_button_down() -> void:
	checkitem("Glasses")
	checkdone()

func _on_mace_button_down() -> void:
	checkitem("Mace")
	checkdone()

func _on_sock_button_down() -> void:
	checkitem("Sock")
	checkdone()

func _on_bell_button_down() -> void:
	checkitem("Bell")
	checkdone()

func _on_magnet_button_down() -> void:
	checkitem("Magnet")
	checkdone()

func _on_umbrella_button_down() -> void:
	checkitem("Umbrella")
	checkdone()

func _on_puppet_button_down() -> void:
	checkitem("Puppet")
	checkdone()

func _on_frisbee_button_down() -> void:
	checkitem("Frisbee")
	checkdone()

func _on_angry_button_down() -> void:
	checkitem("Angry")
	checkdone()

func _on_hat_button_down() -> void:
	checkitem("Hat")
	checkdone()

func _on_gem_button_down() -> void:
	checkitem("Gem")
	checkdone()
