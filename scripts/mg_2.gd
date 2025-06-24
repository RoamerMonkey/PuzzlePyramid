extends Control

var RedCircle1Tile : bool = false
var BlueCircle1Tile : bool = false
var GreenCircle1Tile : bool = false
var PurpleCircle1Tile : bool = false
var PurpleCircle2Tile : bool = false
var GreenCircle2Tile : bool = false
var RedCircle2Tile : bool = false
var BlueCircle2Tile : bool = false
var BlueCircle3Tile : bool = false
var RedCircle3Tile : bool = false
var BlackCircleTile : bool = false
var GreenCircle3Tile : bool = false
var GreenCircle4Tile : bool = false
var PurpleCircle3Tile : bool = false
var BlueCircle4Tile : bool = false
var RedCircle4Tile : bool = false
var almostdone : bool = false
var done : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Timer/Timer.paused = false
	$HUD/Timer/Timer.start()
	$HUD/HelpButton.disabled = true
	$HUD/DisabledButton.visible = true
	$HUD/HelpButton/SkipButton.visible = true
	$HUD/HelpButton/SkipTimer.start()
	$HUD/InfoTop.text = "Solve the puzzle!"
	$HUD/InfoButton.disabled = false
	$HUD/InfoButton.visible = true
	Bgm.get_stream_playback().switch_to_clip_by_name("MG")
	setup_circles()
	GlobalStats.zindex = 0
	$CircleHolder.z_index = 0
	GlobalStats.zindex = 15

func setup_circles():
	var possibleindex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
	var someindex = possibleindex.pick_random()
	$BlueCircle1.z_index = someindex
	$BlueCircle1/BlueCircle1Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$BlueCircle2.z_index = someindex
	$BlueCircle2/BlueCircle2Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$BlueCircle3.z_index = someindex
	$BlueCircle3/BlueCircle3Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$BlueCircle4.z_index = someindex
	$BlueCircle4/BlueCircle4Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$GreenCircle1.z_index = someindex
	$GreenCircle1/GreenCircle1Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$GreenCircle2.z_index = someindex
	$GreenCircle2/GreenCircle2Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$GreenCircle3.z_index = someindex
	$GreenCircle3/GreenCircle3Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$GreenCircle4.z_index = someindex
	$GreenCircle4/GreenCircle4Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$PurpleCircle1.z_index = someindex
	$PurpleCircle1/PurpleCircle1Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$PurpleCircle2.z_index = someindex
	$PurpleCircle2/PurpleCircle2Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$PurpleCircle3.z_index = someindex
	possibleindex.erase(someindex)
	$PurpleCircle3/PurpleCircle3Area.z_index = someindex
	someindex = possibleindex.pick_random()
	$RedCircle1.z_index = someindex
	$RedCircle1/RedCircle1Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$RedCircle2.z_index = someindex
	$RedCircle2/RedCircle2Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$RedCircle3.z_index = someindex
	$RedCircle3/RedCircle3Area.z_index = someindex
	possibleindex.erase(someindex)
	someindex = possibleindex.pick_random()
	$RedCircle4.z_index = someindex
	$RedCircle4/RedCircle4Area.z_index = someindex
	#print($BlueCircle1.z_index)
	#print($BlueCircle2.z_index)
	#print($BlueCircle3.z_index)
	#print($BlueCircle4.z_index)
	#print($GreenCircle1.z_index)
	#print($GreenCircle2.z_index)
	#print($GreenCircle3.z_index)
	#print($GreenCircle4.z_index)
	#print($PurpleCircle1.z_index)
	#print($PurpleCircle2.z_index)
	#print($PurpleCircle3.z_index)
	#print($RedCircle1.z_index)
	#print($RedCircle2.z_index)
	#print($RedCircle3.z_index)
	#print($RedCircle4.z_index)

func adjusted_pos(x : int, y : int) -> Vector2:
	return Vector2(x + 652, y + 386)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#CHECK TEXT
	if $"RedCircle1".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "HOLOGRAM: A person who has lost their mortal body due to [REDACTED] and can only appear as their former body’s transparent image via their Consciousness Device. Indeed, Holograms cannot move at all unless they get someone else to move their Consciousness Device for them."
	elif $"BlueCircle1".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "GHOST: The translucent soul of a deceased being more often found in our Limitless Realm, arising for a multitude of reasons that have been a matter of controversy for millenia. Hard to take a picture of and even harder to find, but the proper equipment has proven to be sufficient."
	elif $"GreenCircle1".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "SNARK: I would’ve dismissed this being as a myth, but the sole evidence of leaving behind traversable mirror portals within our two realms is enough for me to believe some reports about its existence, even if no one has been able to get a full look nor even a picture of the Snark."
	elif $"PurpleCircle1".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "FAIRY: An often human-presenting being with the size of the average human finger. Appropriately has wings of a similar miniscule scale for better movement. Consequently easy to miss and practically invisible this way, but some of them often make themselves very known to everyone else."
	elif $"PurpleCircle2".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "SNAKE: An Earthly animal that traverses by slithering around. To put it in perspective, it would be like if my tail gained consciousness, detached itself, and started roaming around biting people. Some people think I do that last part anyways."
	elif $"GreenCircle2".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "DODO: My personal favorite non-human species from Earth (I adore their unique beaks!). I don’t really consider their “wings” to be actual wings due to their lack of actual ability to fly; they’re more like massive, fluffy skin tags to me. It’s a shame the humans hunted them down to extinction."
	elif $"RedCircle2".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "HUMAN: The dominant species of the planet they call Earth within the Limited Realm. Few of them have been able to traverse to our Limitless Realm using the right mirror portals and enough will-power."
	elif $"BlueCircle2".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "BAT: A nocturnal animal from the humans’ Limited Realm. Most of them fly, but relatively few of them can surprisingly walk with their limbs (basically legs). I admire their ability to sleep upside-down, especially when I’m the very few of my kind that lack that power."
	elif $"BlueCircle3".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "ELEMENTAL: Reasonably the equivalent of a very, very powerful god in our Limitless Realm. Back when they were still active, they reportedly appeared as glowing, floating gems that had unimaginable powers corresponding to some natural element."
	elif $"RedCircle3".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "LICH: A being who has technically managed to defy death itself by occupying their own corpse to continue “living”. Their determination and often magical abilities to do so make them a very dangerous and usually power hungry presence within our Limitless Realm."
	elif $"BlackCircle".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "DEMON: Amongst the upper echelon of our Limited Realm’s inhabitants just for their sheer strength and magical capabilities (including being able to naturally use a mirror portal), although our natural wing genes evolved out over time. And yes, I am a demon."
	elif $"GreenCircle3".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "DRAGON: A massive creature that has mastered many incredulous skills, including flight, combat, and shapeshifting. Fortunately, many of them have willingly served as highly honorable protectors within our Limitless Realm, with a historical few conquerors."
	elif $"GreenCircle4".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "MERMAID: A person that primarily exclusively inhabits underwater environments, especially given their lower bodies being exclusively tails. Odd that the humans call the mermaid’s male version “Merman” instead of “Merbutler”."
	elif $"PurpleCircle3".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "BANSHEE: A female spirit that acts on their sixth sense for impending, nearby death by yelling, likely out of physically sharing the deceased’s pain. They occasionally visit, but do not occupy this nation in the Limited Realm called “Ireland” for the beer."
	elif $"BlueCircle4".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "WITCH: Any person with sufficient skill in a series of magical spells, like using mirrors as items useful beyond reflection. In the Limited Realm, witches are conceived as either deformed villainesses with broomsticks or an attractive archetype. Both are very telling about humans."
	elif $"RedCircle4".position == $Infobox.position:
		$Infobox/InfoContainer/InfoLabel.text = "HARPY: Effectively any hybrid between a winged species and any other non-winged species. Many humans perceive harpies as half-woman and half-bird, but our combinations go beyond that, like half-male-orc and half-owl, half-demon and half-dragon, and many more."
	else:
		$Infobox/InfoContainer/InfoLabel.text = ""
	#CHECK POSITIONS
	if $"RedCircle1".position == adjusted_pos(78, 78):
		RedCircle1Tile = true
	else:
		RedCircle1Tile = false
	if $"BlueCircle1".position == adjusted_pos(234, 78):
		BlueCircle1Tile = true
	else:
		BlueCircle1Tile = false
	if $"GreenCircle1".position == adjusted_pos(390, 78):
		GreenCircle1Tile = true
	else:
		GreenCircle1Tile = false
	if $"PurpleCircle1".position == adjusted_pos(546, 78):
		PurpleCircle1Tile = true
	else:
		PurpleCircle1Tile = false
	if $"PurpleCircle2".position == adjusted_pos(78, 234):
		PurpleCircle2Tile = true
	else:
		PurpleCircle2Tile = false
	if $"GreenCircle2".position == adjusted_pos(234, 234):
		GreenCircle2Tile = true
	else:
		GreenCircle2Tile = false
	if $"RedCircle2".position == adjusted_pos(390, 234):
		RedCircle2Tile = true
	else:
		RedCircle2Tile = false
	if $"BlueCircle2".position == adjusted_pos(546, 234):
		BlueCircle2Tile = true
	else:
		BlueCircle2Tile = false
	if $"BlueCircle3".position == adjusted_pos(78, 390):
		BlueCircle3Tile = true
	else:
		BlueCircle3Tile = false
	if $"RedCircle3".position == adjusted_pos(234, 390):
		RedCircle3Tile = true
	else:
		RedCircle3Tile = false
	if $"BlackCircle".position == adjusted_pos(390, 390):
		BlackCircleTile = true
	else:
		BlackCircleTile = false
	if $"GreenCircle3".position == adjusted_pos(546, 390):
		GreenCircle3Tile = true
	else:
		GreenCircle3Tile = false
	if $"GreenCircle4".position == adjusted_pos(78, 546):
		GreenCircle4Tile = true
	else:
		GreenCircle4Tile = false
	if $"PurpleCircle3".position == adjusted_pos(234, 546):
		PurpleCircle3Tile = true
	else:
		PurpleCircle3Tile = false
	if $"BlueCircle4".position == adjusted_pos(390, 546):
		BlueCircle4Tile = true
	else:
		BlueCircle4Tile = false
	if $"RedCircle4".position == adjusted_pos(546, 546):
		RedCircle4Tile = true
	else:
		RedCircle4Tile = false
	if RedCircle1Tile == true and BlueCircle1Tile == true and GreenCircle1Tile == true and PurpleCircle1Tile == true and PurpleCircle2Tile == true and GreenCircle2Tile == true and RedCircle2Tile == true and BlueCircle2Tile == true and BlueCircle3Tile == true and RedCircle3Tile == true and BlueCircle3Tile == true and GreenCircle3Tile == true and GreenCircle4Tile == true and PurpleCircle3Tile == true and BlueCircle4Tile == true and RedCircle4Tile == true and almostdone == false:
		almostdone = true
		GlobalStats.is_dragging = false
		$Appear.play()
		GlobalStats.zindex += 1
		$BlackCircle.z_index = GlobalStats.zindex
		$BlackCircle.visible = true
		var tween = create_tween()
		tween.set_parallel()
		tween.tween_property($BlackCircle, "modulate:a", 1, 0.5)
		tween.tween_property($SliderBox/EmptyTile, "modulate:a", 1, 0.5)
	if BlackCircleTile == true and done == false:
		done = true
		Bgm.get_stream_playback().switch_to_clip_by_name("Silence")
		$HUD/Timer/Timer.paused = true
		$HUD/MenuButton.disabled = true
		$HUD/HelpButton.disabled = true
		$HUD/HelpButton/SkipTimer.paused = true
		$HUD/InfoButton.disabled = true
		GlobalStats.mg2 = true
		GlobalStats.location = "ho_2"
		await get_tree().create_timer(1.0).timeout 
		$Mgdone.play()
		await get_tree().create_timer(3.5).timeout
		$HUD/Popup/Transition.play()
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scripts/ho_2.tscn")
