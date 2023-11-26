extends TileMap

@export var game: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


const jar_actions = {
	Vector2i(0, 0): "error",
	Vector2i(0, 1): "error",
	Vector2i(0, 2): "lava_jam",
	Vector2i(0, 3): "smol_jam",
	Vector2i(1, 0): "error",
	Vector2i(1, 1): "error",
	Vector2i(1, 2): "error",
	Vector2i(1, 3): "hat_jam",
	Vector2i(2, 0): "lose_control",
	Vector2i(2, 1): "spawn_water",
	Vector2i(2, 2): "grow_bushes",
	Vector2i(2, 3): "error",
	Vector2i(3, 0): "freeze",
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
		game.add_jam()


#
#	Jar Interactions
#
func error(point):
	game.show_jar("You've opened a Jar of Jam!")
	print("No action for this yet!")
	$OpenSound.play()


func spawn_water(point):
	game.show_jar("You've opened a jar of jam!")
	$SpecialSound.play()
	pass


func freeze(point):
	game.show_jar("You've opened a jar of jam icecream?!?! You start feeling a bit cold...")
	game.freeze_map()
	$SpecialSound.play()


func grow_bushes(point):
	game.show_jar("Yuck! You've opened a jam that tastes like vegetables!")
	game.grow_map()
	$SpecialSound.play()


func lava_jam(point):
	game.show_jar("You've opened some spicy jam! Things look like they're burning up!")
	game.burn_map()
	$SpecialSound.play()


func smol_jam(point):
	game.show_jar("You've opened some jar that makes the world bigger!")
	game.set_player_style("_smol")
	$SpecialSound.play()


func hat_jam(point):
	game.show_jar("You've found a hat in a jar")
	game.set_player_style("_hat")
	$SpecialSound.play()



func lose_control(point):
	game.show_jar("You've opened a jar of jam that makes you dizzy...")
	game.disorient_player()
	$SpecialSound.play()


func popup(point):
	game.show_jar("You've opened a strange jar... You start to hallucinate")
	game.spawn_popups()
	$SpecialSound.play()


func remove_jar(point):
	erase_cell(0, point)
