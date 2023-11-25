extends CharacterBody2D


var tile_size = 16
var inputs = {
		"right": Vector2.RIGHT,
		"left": Vector2.LEFT,
		"up": Vector2.UP,
		"down": Vector2.DOWN
	}

var animation_speed = 5
var moving = false

var direction = "left"
@export var start_position: Vector2 = Vector2.ONE


@onready var move_ray = $Move
@onready var detect_ray = $Detect
@onready var animation = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(start_position * tile_size)
	position += Vector2.ONE * tile_size/2
	pass # Replace with function body.


func handle_input():
	if moving:
		return
	if Input.is_action_just_pressed("interact"):
		open_jar()
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			if dir == "left":
				animation.flip_h = true
			else:
				animation.flip_h = false
			move(dir)


func move(dir):
	direction = dir
	move_ray.target_position = inputs[dir] * tile_size
	detect_ray.target_position = inputs[dir] * tile_size
	update_animation()
	animation.stop()
	move_ray.force_raycast_update()
	if !move_ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size, 1.0 / animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	handle_input()

	if(moving):
		update_animation()	
	else:
		animation.stop()
	pass

func update_animation():
	if direction == "up":
		animation.play("walk_up")
	elif direction == "right" or direction == "left":
		animation.play("walk_side")
	else:
		animation.play("walk_down")	

func open_jar():
	if detect_ray.is_colliding():
		var object = detect_ray.get_collider()
		if object.is_in_group("interactable"):
			var point = detect_ray.get_collision_point()
			if direction == "right":
				point += inputs[direction] * 5
			elif direction == "up":
				point += inputs[direction] * 5
			object.interact(point)


	else:
		print("no jar!")
