extends Node2D

var circle : String
var draggable = false
var is_inside_dropable = false
var body_ref
var offset : Vector2
var initialPos : Vector2

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if body_ref == null:
		body_ref = $"../CircleHolder"
	elif body_ref == $"../CircleHolder":
				$Circle5Label.text = "1"
	if draggable and body_ref != null:
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			draggable = false
			GlobalStats.is_dragging = false
			var tween = create_tween()
			if is_inside_dropable:
				if body_ref == $"../CircleHolder":
					self.position = global_position
				else:
					tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
					$Circle5Sprite.frame = 3
					$"../Lightcollide".play()
			else:
				tween.tween_property(self, "global_position", Vector2(219, 648), 0.2).set_ease(Tween.EASE_OUT)
				$Circle5Sprite.frame = 2
			checkPad(true)
			$"../Circleputdown".play()

func checkPad(condition : bool):
	if body_ref == $"../NumberPad1":
		$"..".pad1occupied = condition
		if $"..".pad1occupied == true:
			$"..".num1 = 0
			$Circle5Label.text = "0"
		else:
			$"..".num1 = 0
			$Circle5Label.text = "1"
	elif body_ref == $"../NumberPad2":
		$"..".pad2occupied = condition
		if $"..".pad2occupied == true:
			$"..".num2 = 3
			$Circle5Label.text = "3"
		else:
			$"..".num2 = 0
			$Circle5Label.text = "1"
	elif body_ref == $"../NumberPad3":
		$"..".pad3occupied = condition
		if $"..".pad3occupied == true:
			$"..".num3 = -1
			$Circle5Label.text = "-1"
		else:
			$"..".num3 = 0
			$Circle5Label.text = "1"
	elif body_ref == $"../NumberPad4":
		$"..".pad4occupied = condition
		if $"..".pad4occupied == true:
			$"..".num4 = 2
			$Circle5Label.text = "2"
		else:
			$"..".num4 = 0
			$Circle5Label.text = "1"
	elif body_ref == $"../NumberPad5":
		$"..".pad5occupied = condition
		if $"..".pad5occupied == true:
			$"..".num5 = 2
			$Circle5Label.text = "2"
		else:
			$"..".num5 = 0
			$Circle5Label.text = "1"

func _on_circle_5_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		is_inside_dropable = true
		body_ref = body

func _on_circle_5_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		is_inside_dropable = false

func _on_circle_5_area_mouse_entered() -> void:
	Cursor.ishighlight = true

func _on_circle_5_area_mouse_exited() -> void:
	Cursor.ishighlight = false

func _on_circle_5_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click") and not GlobalStats.is_dragging:
		var query_parameter: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
		query_parameter.position = event.position
		query_parameter.collide_with_areas = true
		var objects_clicked = get_world_2d().direct_space_state.intersect_point(query_parameter)
		var colliders = objects_clicked.map(
			func(area):
				return area.collider
		)
		colliders.sort_custom(
			func(c1, c2):
				return c1.z_index < c2.z_index
		)
		if colliders[-1] == $Circle5Area:
			GlobalStats.zindex += 1
			self.z_index = GlobalStats.zindex
			draggable = true
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			GlobalStats.is_dragging = true
			$Circle5Sprite.frame = 2
			$"../Circlepickup".play()
			checkPad(false)
