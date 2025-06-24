extends Button

var helptype : String
var once : bool #Done to avoid spamming SFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	once = false
	$".".disabled = true
	$HintButton.value = 0
	$SkipButton.value = 0
	$HintButton.max_value = GlobalStats.hint
	$SkipButton.max_value = GlobalStats.skip
	if GlobalStats.location == "mg_1" or GlobalStats.location == "mg_2" or GlobalStats.location == "mg_3":
		helptype = "Skip"
	else:
		helptype = "Hint"

func _process(delta: float) -> void:
	if $SkipButton.value == $SkipButton.max_value and helptype == "Skip":
		self.disabled = false
		$"../DisabledButton".visible = false
		if (GlobalStats.location == "mg_1" or GlobalStats.location == "mg_2" or GlobalStats.location == "mg_3") and once == false:
			$"../Hintrecharge".play()
			once = true
	elif $HintButton.value == $HintButton.max_value and helptype == "Hint":
		self.disabled = false
		$"../DisabledButton".visible = false
		if (GlobalStats.location == "ho_1" or GlobalStats.location == "ho_2" or GlobalStats.location == "ho_3") and once == false:
			$"../Hintrecharge".play()
			once = true

func _on_button_down() -> void:
	if helptype == "Skip":
		GlobalStats.zindex += 1
		$"../Popup".visible = true
		$"../Popup/Skip".visible = true
	elif helptype == "Hint" and not GlobalStats.location == "pyramid_hub":
		var hintitem = "/root/" + GlobalStats.location + "/" + GlobalStats.itemlist[0]
		if len(GlobalStats.itemlist) == 2:
			hintitem = "/root/" + GlobalStats.location + "/" + GlobalStats.itemlist[randi_range(0, 1)]
		elif len(GlobalStats.itemlist) >= 3:
			hintitem = "/root/" + GlobalStats.location + "/" + GlobalStats.itemlist[randi_range(0, 2)]
		get_node(hintitem).set_pivot_offset(get_node(hintitem).size/2)
		var tween = create_tween()
		tween.tween_property(get_node(hintitem), "scale", Vector2(3,3), 0.5)
		tween.tween_property(get_node(hintitem), "scale", Vector2(1,1), 0.5)
		$HintButton.value = 0
		self.disabled = true
		$"../DisabledButton".visible = true
	if GlobalStats.location == "pyramid_hub":
		$"../Hintloading".play()
	else:
		$"../Buttonhintskip".play()

func _on_hint_timer_timeout() -> void:
	$HintButton.value += 1
	if $HintButton.value == $HintButton.max_value:
		self.disabled = false
		$"../DisabledButton".visible = false
		$"../Hintrecharge".play()

func _on_skip_timer_timeout() -> void:
	$SkipButton.value += 1
