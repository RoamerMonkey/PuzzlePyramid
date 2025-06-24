extends Node2D

var circle : String
var draggable = false
var is_inside_dropable = false
var body_ref
var offset : Vector2
var initialPos : Vector2
var isin = false

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
				elif body_ref == $"../Infobox":
					tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
					$BlueCircle1Sprite.frame = 3
					$"../Lightup".play()
				else:
					tween.tween_property(self, "position", Vector2(body_ref.position.x + 652, body_ref.position.y + 386), 0.2).set_ease(Tween.EASE_OUT)
					$BlueCircle1Sprite.frame = 3
					$"../Lightcollide".play()
					isin = true
			else:
				tween.tween_property(self, "global_position", $"../CircleHolder".position, 0.2).set_ease(Tween.EASE_OUT)
				if initialPos == $"../CircleHolder".position:
					$BlueCircle1Sprite.frame = 2
			$"../Circleputdown".play()
	if isin == true:
		self.position = Vector2(body_ref.position.x + 652, body_ref.position.y + 386)

func _on_blue_circle_1_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("dropable") and (body == $"../SliderBox/BlueTile1" or
										 body == $"../SliderBox/BlueTile2" or
										 body == $"../SliderBox/BlueTile3" or
										 body == $"../SliderBox/BlueTile4" or
										 body == $"../CircleHolder" or
										 body == $"../Infobox"):
		is_inside_dropable = true
		body_ref = body

func _on_blue_circle_1_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("dropable") and (body == $"../SliderBox/BlueTile1" or
										 body == $"../SliderBox/BlueTile2" or
										 body == $"../SliderBox/BlueTile3" or
										 body == $"../SliderBox/BlueTile4" or
										 body == $"../CircleHolder" or
										 body == $"../Infobox"):
		is_inside_dropable = false

func _on_blue_circle_1_area_mouse_entered() -> void:
	Cursor.ishighlight = true

func _on_blue_circle_1_area_mouse_exited() -> void:
	Cursor.ishighlight = false

func _on_blue_circle_1_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click") and not GlobalStats.is_dragging and not $"..".almostdone:
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
		if colliders[-1] == $BlueCircle1Area:
			GlobalStats.zindex += 1
			self.z_index = GlobalStats.zindex
			draggable = true
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			GlobalStats.is_dragging = true
			$BlueCircle1Sprite.frame = 2
			$"../Circlepickup".play()
			isin = false
