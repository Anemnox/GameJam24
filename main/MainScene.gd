extends Node2D

var popup_inst = load("res://ui/popup/AnnoyingPopUp.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_popups():
	var mid = Vector2(100, 50)
	
	for n in 10:
		var temp = popup_inst.instantiate()
		
		temp.position = mid + Vector2(randi_range(-20, 85), randi_range(-20, 80))
		
		$CanvasLayer/PopUps.add_child(temp)



func show_jar():
	$CanvasLayer/JarOpen.show_jar()


func hide_jar():
	$CanvasLayer/JarOpen.hide_jar()

func reverse_player_controls():
	
	pass
