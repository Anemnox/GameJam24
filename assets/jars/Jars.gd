extends TileMap

@export var game: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


const jar_actions = {
	Vector2i(0, 0): "error",
	Vector2i(0, 1): "error",
	Vector2i(0, 2): "error",
	Vector2i(0, 3): "error",
	Vector2i(1, 0): "error",
	Vector2i(1, 1): "error",
	Vector2i(1, 2): "error",
	Vector2i(1, 3): "error",
	Vector2i(2, 0): "error",
	Vector2i(2, 1): "spawn_water",
	Vector2i(2, 2): "error",
	Vector2i(2, 3): "error",
	Vector2i(3, 0): "error",
	Vector2i(3, 1): "popup",
	Vector2i(3, 2): "error",
	Vector2i(3, 3): "error",
}


func interact(point):
	$Polygon2D.position = point
	point = local_to_map(point)

	var tile = get_cell_atlas_coords(0, point)
	if tile == null:
		return
	if tile in jar_actions:
		remove_jar(point)
		call(jar_actions[tile], point)


#
#	Jar Interactions
#
func error(point):
	game.show_jar()
	print("No action for this yet!")
	await get_tree().create_timer(1).timeout
	game.hide_jar()


func spawn_water(point):
	game.show_jar()
	await get_tree().create_timer(1).timeout
	game.hide_jar()


func popup(point):
	game.show_jar()
	await get_tree().create_timer(1).timeout
	game.spawn_popups()
	game.hide_jar()
	
	


func remove_jar(point):
	erase_cell(0, point)
