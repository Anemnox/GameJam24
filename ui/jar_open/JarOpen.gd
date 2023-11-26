extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.visible = false
	pass # Replace with function body.


var curr = 0


func show_jar(text = ""):
	$AnimatedSprite2D.visible = true
	$RichTextLabel.text = text
	$RichTextLabel.visible = true
	$AnimatedSprite2D.play("popup")
	curr += 1
	var now = curr
	await get_tree().create_timer(2).timeout
	hide_jar(now)


func hide_jar(num):
	if curr != num:
		return
	$AnimatedSprite2D.play("dip")
	$RichTextLabel.visible = false
	await get_tree().create_timer(1).timeout
	if curr != num:
		return
	$AnimatedSprite2D.visible = false
	
