extends Control
var buttonpressed = false
var checkpoint = false
var done = false
var mazegrid = [0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10,
				   11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
				   21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
				   31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
				   41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
				   51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
				   61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
				   71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
				   81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
				   91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101]
var currentposition = 0

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentposition == 19 and not checkpoint:
		checkpoint = true
		$Maze/Checkpoint2.disabled = true
		$Lightcheckpoint.play()
	elif currentposition == 33 and not checkpoint:
		checkpoint = true
		$Maze/Checkpoint1.disabled = true
		$Lightcheckpoint.play()
	elif currentposition == 85 and not checkpoint:
		checkpoint = true
		$Maze/Checkpoint3.disabled = true
		$Lightcheckpoint.play()
	elif currentposition == 2 and not checkpoint:
		checkpoint = true
		$Maze/Checkpoint4.disabled = true
		$Lightcheckpoint.play()
	elif currentposition == 26 and not checkpoint:
		checkpoint = true
		$Maze/Checkpoint5.disabled = true
		$Lightcheckpoint.play()
	elif currentposition == 55 and not checkpoint:
		checkpoint = true
		$Maze/Checkpoint6.disabled = true
		$Lightcheckpoint.play()
	elif currentposition == 62 and not checkpoint:
		checkpoint = true
		$Maze/Checkpoint7.disabled = true
		$Lightcheckpoint.play()
	elif currentposition == 68 and not checkpoint:
		checkpoint = true
		$Maze/Checkpoint8.disabled = true
		$Lightcheckpoint.play()
	elif currentposition != 2 and currentposition != 19 and currentposition != 26 and currentposition != 33 and currentposition != 55 and currentposition != 62 and currentposition != 68 and currentposition != 85:
		$Maze/Checkpoint1.disabled = false
		$Maze/Checkpoint2.disabled = false
		$Maze/Checkpoint3.disabled = false
		$Maze/Checkpoint4.disabled = false
		$Maze/Checkpoint5.disabled = false
		$Maze/Checkpoint6.disabled = false
		$Maze/Checkpoint7.disabled = false
		$Maze/Checkpoint8.disabled = false
		checkpoint = false
	if currentposition == 101 and not done:
		done = true
		Bgm.get_stream_playback().switch_to_clip_by_name("Silence")
		$Maze/MarbleMove.disabled = true
		$LeftArrow.disabled = true
		$BottomArrow.disabled = true
		$RightArrow.disabled = true
		$TopArrow.disabled = true
		$HUD/Timer/Timer.paused = true
		$HUD/MenuButton.disabled = true
		$HUD/HelpButton.disabled = true
		$HUD/HelpButton/SkipTimer.paused = true
		$HUD/InfoButton.disabled = true
		GlobalStats.mg1 = true
		GlobalStats.location = "ho_1"
		await get_tree().create_timer(1.0).timeout 
		$Mgdone.play()
		await get_tree().create_timer(3.5).timeout
		$HUD/Popup/Transition.play()
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scripts/ho_1.tscn")

func _on_left_arrow_pressed() -> void:
	if buttonpressed == false:
		$Buttonrelease.play()
		buttonpressed = true
		checkmove("left")
		$BottomArrow.disabled = true
		$RightArrow.disabled = true
		$TopArrow.disabled = true
		await get_tree().create_timer(0.5).timeout
		buttonpressed = false
		$BottomArrow.disabled = false
		$RightArrow.disabled = false
		$TopArrow.disabled = false
		$LeftArrow.button_pressed = false

func _on_bottom_arrow_pressed() -> void:
	if buttonpressed == false:
		$Buttonrelease.play()
		buttonpressed = true
		checkmove("bottom")
		$LeftArrow.disabled = true
		$RightArrow.disabled = true
		$TopArrow.disabled = true
		await get_tree().create_timer(0.5).timeout
		buttonpressed = false
		$LeftArrow.disabled = false
		$RightArrow.disabled = false
		$TopArrow.disabled = false
		$BottomArrow.button_pressed = false

func _on_right_arrow_pressed() -> void:
	if buttonpressed == false:
		$Buttonrelease.play()
		buttonpressed = true
		checkmove("right")
		$LeftArrow.disabled = true
		$BottomArrow.disabled = true
		$TopArrow.disabled = true
		await get_tree().create_timer(0.5).timeout
		buttonpressed = false
		$LeftArrow.disabled = false
		$BottomArrow.disabled = false
		$TopArrow.disabled = false
		$RightArrow.button_pressed = false

func _on_top_arrow_pressed() -> void:
	if buttonpressed == false:
		$Buttonrelease.play()
		buttonpressed = true
		checkmove("top")
		$LeftArrow.disabled = true
		$BottomArrow.disabled = true
		$RightArrow.disabled = true
		await get_tree().create_timer(0.5).timeout
		buttonpressed = false
		$LeftArrow.disabled = false
		$BottomArrow.disabled = false
		$RightArrow.disabled = false
		$TopArrow.button_pressed = false

func checkmove(input : String):
	if currentposition == 0:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 1
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 1:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 0
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 2
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 2:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 1
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 12
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 3
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 3:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 2
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 4
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 4:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 3
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 5
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 5:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 4
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 15
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 6:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 16
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 7
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 7:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 6
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 17
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 8
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 8:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 7
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 9
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 9:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 8
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 10
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 10:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 9
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 20
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 11:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 12
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 12:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 11
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 22
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 2
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 13:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 23
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 14
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 14:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 13
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 15
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 15:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 14
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 25
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 5
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 16:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 26
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 6
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 17:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 27
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 7
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 18:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 28
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 19
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 19:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 18
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 29
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 20
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 20:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 19
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 10
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 21:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 22
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 22:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 21
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 12
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 23:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 33
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 13
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 24:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 34
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 25:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 15
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 26:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 16
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 27:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 37
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 17
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 28:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 38
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 18
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 29:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 39
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 19
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 30:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 40
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 31:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 41
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 32
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 32:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 31
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 42
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 33:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 43
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 34
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 23
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 34:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 33
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 35
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 24
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 35:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 34
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 36
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 36:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 35
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 37
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 37:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 36
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 27
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 38:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 48
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 28
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 39:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 49
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 29
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 40:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 50
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 30
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 41:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 51
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 31
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 42:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 52
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 32
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 43:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 53
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 33
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 44:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 45
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 45:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 44
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 46
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 46:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 45
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 56
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 47
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 47:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 46
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 48
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 48:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 47
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 58
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 38
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 49:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 59
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 50
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 39
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 50:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 49
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 40
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 51:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 61
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 41
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 52:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 53
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 42
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 53:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 52
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 54
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 43
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 54:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 53
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 55
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 55:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 54
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 65
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 56
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 56:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 55
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 66
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 57
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 46
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 57:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 56
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 58:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 48
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 59:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 69
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 60
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 49
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 60:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 59
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 61:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 71
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 62
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 51
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 62:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 61
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 72
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 63
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 63:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 62
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 73
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 64:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 74
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 65
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 65:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 64
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 55
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 66:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 76
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 67
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 56
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 67:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 66
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 77
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 68:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 78
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 69
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 69:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 68
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 59
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 70:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 80
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 71:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 81
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 61
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 72:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 82
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 62
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 73:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 83
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 63
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 74:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 75
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 64
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 75:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 74
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 85
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 76:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 66
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 77:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 87
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 67
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 78:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 88
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 68
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 79:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 89
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 80:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 90
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 70
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 81:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 71
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 82:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 92
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 72
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 83:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 93
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 84
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 73
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 84:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 83
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 85
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 85:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 84
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 95
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 86
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 75
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 86:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 85
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 96
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 87:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 88
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 77
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 88:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 87
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 98
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 78
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 89:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 99
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 90
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 79
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 90:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 89
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y + 70), 0.5)
			currentposition = 100
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 80
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 91:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 92
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 92:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 91
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 93
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 82
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 93:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 92
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 94
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 83
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 94:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 93
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 95
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 95:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 94
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 85
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 96:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 86
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 97:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 98
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/WallIndicatorTop.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorTop.frame = 0
	elif currentposition == 98:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 97
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 99
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 88
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 99:
		if input == "left":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x - 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 98
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/WallIndicatorRight.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorRight.frame = 0
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 89
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
	elif currentposition == 100:
		if input == "left":
			$Indicator/WallIndicatorLeft.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorLeft.frame = 0
		elif input == "bottom":
			$Indicator/WallIndicatorBottom.frame = 1
			$Lightcollide.play()
			await get_tree().create_timer(0.5).timeout
			$Indicator/WallIndicatorBottom.frame = 0
		elif input == "right":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x + 70, $Maze/MarbleMove.position.y), 0.5)
			currentposition = 101
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
		elif input == "top":
			$Indicator/MarbleEx.frame = 3
			var tween = create_tween()
			tween.tween_property($Maze/MarbleMove, "position", Vector2($Maze/MarbleMove.position.x, $Maze/MarbleMove.position.y - 70), 0.5)
			currentposition = 90
			await get_tree().create_timer(0.5).timeout
			$Indicator/MarbleEx.frame = 2
