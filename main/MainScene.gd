extends Node2D
var popup_inst = load("res://ui/popup/AnnoyingPopUp.tscn")


var total_jam = 20
var collected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.tilemap = $LevelOne/Floor
	$Player.disabled = true
	show_jar("A mysterious island with curious jars...")
	await get_tree().create_timer(3).timeout
	show_jar("I wonder what they do...")
	await get_tree().create_timer(3).timeout
	show_jar("(W, A, S, D) to move. E to interact with jars.")
	$Player.disabled = false
	await get_tree().create_timer(3).timeout
	show_jar("Whatever you do, DON'T open any jars!")
	await get_tree().create_timer(3).timeout
	pass # Replace with function body.


func spawn_popups():
	var mid = Vector2(100, 50)
	
	for n in 6:
		var temp = popup_inst.instantiate()
		temp.position = mid + Vector2(randi_range(-50, 50), randi_range(-50, 50))
		
		await get_tree().create_timer(0.1).timeout
		$CanvasLayer/PopUps.add_child(temp)

func end_game():
	$Player.disabled = true
	await get_tree().create_timer(2).timeout
	show_jar("This is the final jar....")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_packed(load("res://ui/EndScreen.tscn"))


func add_jam():
	collected += 1
	$CanvasLayer/JamIndicator.add_jam()
	if collected == total_jam:
		end_game()


func show_jar(text=""):
	$CanvasLayer/JarOpen.show_jar(text)


const TILES = {
	"ICE": Vector2i(3, 2),
	"LAVA": Vector2i(2, 2),
	"DIRT": Vector2i(1, 2),
	"BUSH": Vector2i(0, 2),
	"LIGHT_GRASS": Vector2i(0, 1),
	"SHALLOW_WATER": Vector2i(3, 1),
}


func disorient_player():
	$Player.become_dizzy()


func set_player_style(text):
	$Player.animation_style = text
	$Player.update_animation()


func swap(tile1, tile2):
	var tiles = $LevelOne/Floor.get_used_cells(0)
	for i in tiles:
		var prev = $LevelOne/Floor.get_cell_atlas_coords(0, i)
		if prev == tile1:
			$LevelOne/Floor.set_cell(0, i, 0, tile2)


func freeze_map():
	swap(TILES.SHALLOW_WATER, TILES.ICE)
	#swap(TILES.LAVA, TILES.DIRT)
	pass


func burn_map():
	swap(TILES.DIRT, TILES.LAVA)
	#swap(TILES.ICE, TILES.SHALLOW_WATER)
	pass


func grow_map():
	swap(TILES.LIGHT_GRASS, TILES.BUSH)
	pass


func reverse_player_controls():
	
	pass
