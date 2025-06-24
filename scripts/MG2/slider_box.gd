extends Area2D #(652, 386)

var tiles = []
var mouse = false
var isin = false

# Called when the node enters the scene tree for the first time.
func _ready():
	tiles = [$RedTile1, $BlueTile1, $GreenTile1, $PurpleTile1,
			 $PurpleTile2, $GreenTile2, $RedTile2, $BlueTile2,
			 $BlueTile3, $RedTile3, $EmptyTile, $GreenTile3,
			 $GreenTile4, $PurpleTile3, $BlueTile4, $RedTile4]
	shuffle_tiles()
	
func shuffle_tiles():
	var previous = 99
	var previous_1 = 98
	for t in range(0,1000):
		var tile = randi() % 16
		if tiles[tile] != $EmptyTile and tile != previous and tile != previous_1:
			var rows = int(tiles[tile].position.y / 156)
			var cols = int(tiles[tile].position.x / 156)
			check_neighbours(rows,cols)
			previous_1 = previous
			previous = tile
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse and not $"..".almostdone and isin == true:
		var mouse_copy = mouse
		mouse = false
		mouse_copy.position.x -= 652
		mouse_copy.position.y -= 386
		var rows = int(mouse_copy.position.y / 156)
		var cols = int(mouse_copy.position.x / 156)
		check_neighbours(rows,cols)

func check_neighbours(rows, cols):
	var empty = false
	var done = false
	var pos = rows * 4 + cols
	while !empty and !done:
		var new_pos = tiles[pos].position
		if rows < 3:
			new_pos.y += 156
			empty = find_empty(new_pos,pos)
			new_pos.y -= 156
		if rows > 0:
			new_pos.y -= 156
			empty = find_empty(new_pos,pos)
			new_pos.y += 156
		if cols < 3:
			new_pos.x += 156
			empty = find_empty(new_pos,pos)
			new_pos.x -= 156
		if cols > 0:
			new_pos.x -= 156
			empty = find_empty(new_pos,pos)
			new_pos.x += 156
		done = true
			
func find_empty(position, pos):
	var new_rows = int(position.y / 156)
	var new_cols = int(position.x / 156)
	var new_pos = new_rows * 4 + new_cols
	if tiles[new_pos] == $EmptyTile:
		swap_tiles(pos, new_pos)
		return true
	else:
		return false

func swap_tiles(tile_src, tile_dst):
	var temp_pos = tiles[tile_src].position
	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos
	var temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = temp_tile
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$"../Pieceslide".play()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		mouse = event

func _on_mouse_entered() -> void:
	isin = true

func _on_mouse_exited() -> void:
	isin = false
