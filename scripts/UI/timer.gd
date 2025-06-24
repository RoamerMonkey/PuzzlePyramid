extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not (GlobalStats.location == "ho_1" or GlobalStats.location == "ho_2" or GlobalStats.location == "ho_3"):
		ResetTimer()
	if GlobalStats.timeleftsec > 9:
		$TimerLabel.text = str(GlobalStats.timeleftmin) + ":" + str(GlobalStats.timeleftsec)
	else:
		$TimerLabel.text = str(GlobalStats.timeleftmin) + ":0" + str(GlobalStats.timeleftsec)

func _on_timer_timeout() -> void:
	if GlobalStats.mode == true:
		if GlobalStats.timeleftsec == 0 and GlobalStats.timeleftmin > 0:
			GlobalStats.timeleftmin -= 1
			GlobalStats.timeleftsec = 60
		GlobalStats.timeleftsec -= 1
		if GlobalStats.timeleftsec > 9:
			$TimerLabel.text = str(GlobalStats.timeleftmin) + ":" + str(GlobalStats.timeleftsec)
		else:
			$TimerLabel.text = str(GlobalStats.timeleftmin) + ":0" + str(GlobalStats.timeleftsec)
		if GlobalStats.timeleftsec == 0 and GlobalStats.timeleftmin <= 0:
			GlobalStats.zindex += 1
			$"../Timegodown".play()
			GlobalStats.mode = false
			$"../Popup".visible = true
			$"../Popup/TimeOut".visible = true

func ResetTimer():
	GlobalStats.timeleftsec = 0
	GlobalStats.timeleftmin = GlobalStats.maxtime
