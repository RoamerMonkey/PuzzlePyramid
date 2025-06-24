extends CanvasLayer

signal on_transition_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BG.visible = false
	$Animate.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == "FadeIn":
		on_transition_finished.emit()
		$Animate.play("FadeOut")
	elif anim_name == "FadeOut":
		$BG.visible = false

func transition():
	$BG.visible = true
	$Animate.play("FadeIn")
