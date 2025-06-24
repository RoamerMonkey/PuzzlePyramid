extends Control

var CursorDefault = load("res://assets/gfx/ui/Cursor1.png")
var CursorClick = load("res://assets/gfx/ui/Cursor2.png")
var CursorHighlightDefault = load("res://assets/gfx/ui/Cursor3.png")
var CursorHighlightClick = load("res://assets/gfx/ui/Cursor4.png")
var ishighlight : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalStats.cursor == true:
		Input.set_custom_mouse_cursor(CursorDefault, 0, Vector2(3, 3))

func _process(delta: float) -> void:
	if GlobalStats.cursor == true:
		if ishighlight == false:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				Input.set_custom_mouse_cursor(CursorClick, 0, Vector2(3, 3))
			else: 
				Input.set_custom_mouse_cursor(CursorDefault, 0, Vector2(3, 3))
		else:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				Input.set_custom_mouse_cursor(CursorHighlightClick, 0, Vector2(3, 3))
			else: 
				Input.set_custom_mouse_cursor(CursorHighlightDefault, 0, Vector2(3, 3))
	else:
		Input.set_custom_mouse_cursor(null)
