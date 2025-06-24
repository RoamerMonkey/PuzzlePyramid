extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer/Timer.paused = false
	$HelpButton.disabled = false
	$HelpButton/HintButton.visible = false
	$HelpButton/SkipButton.visible = false
	$Items.visible = false
	$InfoButton.visible = false
	if GlobalStats.mode == false:
		$Timer/Timer.paused = true
		$Timer/TimerLabel.text = "XX:XX"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_menu_button_pressed() -> void:
	if $Popup.visible == false:
		GlobalStats.zindex += 1
		$Popup.visible = true
		$Popup/Pause.visible = true
		$Buttonclick.play()
		$Timer/Timer.paused = true
		$HelpButton/HintTimer.paused = true
		$HelpButton/SkipTimer.paused = true
	elif $Popup.visible == true and $Popup/TimeOut.visible == false:
		$Popup.visible = false
		$Popup/Pause.visible = false
		$Popup/Info.visible = false
		$Popup/Skip.visible = false
		$Buttonclick.play()
		$Timer/Timer.paused = false
		$HelpButton/HintTimer.paused = false
		$HelpButton/SkipTimer.paused = false

func _on_menu_button_mouse_entered() -> void:
	$Buttonhover.play()

func _on_info_button_button_down() -> void:
	GlobalStats.zindex += 1
	$Popup.visible = true
	$Popup/Info.visible = true
	$Buttonclick.play()
	$Timer/Timer.paused = true
	$HelpButton/SkipTimer.paused = true

func _on_help_button_mouse_entered() -> void:
	$Buttonhover.play()

func _on_info_button_mouse_entered() -> void:
	$Buttonhover.play()

func _on_disabled_button_button_down() -> void:
	$Hintloading.play()
