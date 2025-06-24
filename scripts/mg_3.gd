extends Control

var num1 : int = 0
var num2 : int = 0
var num3 : int = 0
var num4 : int = 0
var num5 : int = 0
var sum : int
var goal1 : int = 4
var goal2 : int = 3
var goal3 : int = 6
var goal4 : int = 1
var goal5 : int = 2
var pad1occupied : bool = false
var pad2occupied : bool = false
var pad3occupied : bool = false
var pad4occupied : bool = false
var pad5occupied : bool = false
var challenge1 : bool = false
var challenge2 : bool = false
var challenge3 : bool = false
var challenge4 : bool = false
var challenge5 : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Timer/Timer.paused = false
	$HUD/Timer/Timer.start()
	$HUD/HelpButton.disabled = true
	$HUD/DisabledButton.visible = true
	$HUD/HelpButton/SkipButton.visible = true
	$HUD/HelpButton/SkipTimer.start()
	$HUD/InfoTop.text = "Solve the puzzle!"
	$HUD/InfoButton.visible = true
	$HUD/InfoButton.disabled = false
	Bgm.get_stream_playback().switch_to_clip_by_name("MG")
	GlobalStats.zindex = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sum = num1 + num2 + num3 + num4 + num5
	if pad1occupied == true and pad2occupied == true and pad3occupied == true and pad4occupied == true and pad5occupied == true:
		$Block.visible = true
		$PlusSign.frame = 1
		if $Lightup.playing == false:
			$Lightup.play()
		await get_tree().create_timer(1.0).timeout 
		if challenge1 == false:
			if sum == goal1:
				$Lightcorrect.play()
				$EqualSign.frame = 1
				$RoundLight1.frame = 1
				$DiamondGoal/DiamondLabel.text = str(goal2)
				challenge1 = true
			else:
				if not $EqualSign.frame == 1 and $Lightwrong.playing == false:
					$Lightwrong.play()
					$EqualSign.frame = 2
		elif challenge2 == false:
			if sum == goal2:
				$Lightcorrect.play()
				$EqualSign.frame = 1
				$RoundLight2.frame = 1
				$DiamondGoal/DiamondLabel.text = str(goal3)
				challenge2 = true
			else:
				if not $EqualSign.frame == 1 and $Lightwrong.playing == false:
					$Lightwrong.play()
					$EqualSign.frame = 2
		elif challenge3 == false:
			if sum == goal3:
				$Lightcorrect.play()
				$EqualSign.frame = 1
				$RoundLight3.frame = 1
				$DiamondGoal/DiamondLabel.text = str(goal4)
				challenge3 = true
			else:
				if not $Lightwrong.playing == false:
					$Lightwrong.play()
					$EqualSign.frame = 2
		elif challenge4 == false:
			if sum == goal4:
				$Lightcorrect.play()
				$EqualSign.frame = 1
				$RoundLight4.frame = 1
				$DiamondGoal/DiamondLabel.text = str(goal5)
				challenge4 = true
			else:
				if not $EqualSign.frame == 1 and $Lightwrong.playing == false:
					$Lightwrong.play()
					$EqualSign.frame = 2
		elif challenge5 == false:
			if sum == goal5:
				$Lightcorrect.play()
				$EqualSign.frame = 1
				$RoundLight5.frame = 1
				$DiamondGoal/DiamondLabel.text = ""
				challenge5 = true
			else:
				if not $EqualSign.frame == 1 and $Lightwrong.playing == false:
					$Lightwrong.play()
					$EqualSign.frame = 2
		$Circle1.position = Vector2(166,433)
		$Circle2.position = Vector2(87,527)
		$Circle3.position = Vector2(248,527)
		$Circle4.position = Vector2(107,648)
		$Circle5.position = Vector2(219,648)
		$Circle1.body_ref = $"../CircleHolder"
		$Circle2.body_ref = $"../CircleHolder"
		$Circle3.body_ref = $"../CircleHolder"
		$Circle4.body_ref = $"../CircleHolder"
		$Circle5.body_ref = $"../CircleHolder"
		num1 = 0
		num2 = 0
		num3 = 0
		num4 = 0
		num5 = 0
		pad1occupied = false
		pad2occupied = false
		pad3occupied = false
		pad4occupied = false
		pad5occupied = false
		$Circle1/Circle1Sprite.frame = 0
		$Circle2/Circle2Sprite.frame = 0
		$Circle3/Circle3Sprite.frame = 2
		$Circle4/Circle4Sprite.frame = 2
		$Circle5/Circle5Sprite.frame = 2
		$Circle3/Circle3Label.text = "2"
		$Circle4/Circle4Label.text = "-1"
		$Circle5/Circle5Label.text = "1"
		$Block.visible = false
		$PlusSign.frame = 0
		await get_tree().create_timer(1.0).timeout
		$EqualSign.frame = 0

func _on_equal_sign_frame_changed() -> void:
	if challenge5 == true:
		Bgm.get_stream_playback().switch_to_clip_by_name("Silence")
		$HUD/Timer/Timer.paused = true
		$HUD/MenuButton.disabled = true
		$HUD/HelpButton.disabled = true
		$HUD/HelpButton/SkipTimer.paused = true
		$HUD/InfoButton.disabled = true
		GlobalStats.mg3 = true
		GlobalStats.location = "ho_3"
		await get_tree().create_timer(1.0).timeout 
		$Mgdone.play()
		await get_tree().create_timer(3.5).timeout
		$HUD/Popup/Transition.play()
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scripts/ho_3.tscn")
