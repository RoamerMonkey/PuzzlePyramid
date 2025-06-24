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
	elif draggable and body_ref != null:
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
					$Circle1Sprite.frame = 1
					$"../Lightcollide".play()
			else:
				tween.tween_property(self, "global_position", Vector2(166, 433), 0.2).set_ease(Tween.EASE_OUT)
				if initialPos == body_ref.position:
					$Circle1Sprite.frame = 0
			checkPad(true)
			$"../Circleputdown".play()

func checkPad(condition : bool):
	if body_ref == $"../NumberPad1":
		$"..".pad1occupied = condition
		$"..".num1 = 0
	elif body_ref == $"../NumberPad2":
		$"..".pad2occupied = condition
		$"..".num2 = 0
	elif body_ref == $"../NumberPad3":
		$"..".pad3occupied = condition
		$"..".num3 = 0
	elif body_ref == $"../NumberPad4":
		$"..".pad4occupied = condition
		$"..".num4 = 0
	elif body_ref == $"../NumberPad5":
		$"..".pad5occupied = condition
		$"..".num5 = 0

func _on_circle_1_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		is_inside_dropable = true
		body_ref = body

func _on_circle_1_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		is_inside_dropable = false

func _on_circle_1_area_mouse_entered() -> void:
	Cursor.ishighlight = true

func _on_circle_1_area_mouse_exited() -> void:
	Cursor.ishighlight = false

func _on_circle_1_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
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
		if colliders[-1] == $Circle1Area:
			GlobalStats.zindex += 1
			self.z_index = GlobalStats.zindex
			draggable = true
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			GlobalStats.is_dragging = true
			$Circle1Sprite.frame = 0
			$"../Circlepickup".play()
			checkPad(false)
