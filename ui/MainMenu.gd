extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var mouse_inside_area = false

func _on_Area2D_mouse_entered():
	mouse_inside_area = true


func _on_Area2D_mouse_exited():
	mouse_inside_area = false


func _input(event):
	if not mouse_inside_area:
		return
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.pressed:
		$TextureRect.texture = load("res://ui/title_click.png")
	elif event is InputEventMouseButton:
		get_tree().change_scene_to_packed(load('res://main/MainScene.tscn'))

