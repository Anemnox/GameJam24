extends Node2D
var popup_inst = load("res://ui/popup/AnnoyingPopUp.tscn")


var total_jam = 20
var collected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.tilemap = $LevelOne/Floor
	pass # Replace with function body.


func spawn_popups():
	var mid = Vector2(100, 50)
	
	for n in 10:
		var temp = popup_inst.instantiate()
		
		temp.position = mid + Vector2(randi_range(-20, 85), randi_range(-20, 80))
		
		$CanvasLayer/PopUps.add_child(temp)


func add_jam():
	collected += 1
	$CanvasLayer/JamIndicator.add_jam()


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
	swap(TILES.LAVA, TILES.DIRT)
	pass


func burn_map():
	swap(TILES.DIRT, TILES.LAVA)
	swap(TILES.ICE, TILES.SHALLOW_WATER)
	pass


func grow_map():
	swap(TILES.LIGHT_GRASS, TILES.BUSH)
	pass


func reverse_player_controls():
	
	pass
