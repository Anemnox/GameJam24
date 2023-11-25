extends PanelContainer

var mouse_inside_area = false

func _on_Area2D_mouse_entered():
	mouse_inside_area = true

func _on_Area2D_mouse_exited():
	mouse_inside_area = false

func _input(event):
	$AnimatedSprite2D.play("default")
	if not mouse_inside_area:
		return
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.pressed:
		$AnimatedSprite2D.play("click")
	elif event is InputEventMouseButton:
		get_parent().remove_child(self)

