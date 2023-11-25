extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.visible = false
	pass # Replace with function body.

func show_jar():
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("popup")

func hide_jar():
	$AnimatedSprite2D.play("dip")
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.visible = false
