extends Control

@export var max_jam: int = 20

var curr_jam = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_jam(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_jam():
	set_jam(curr_jam + 1)
	

func set_jam(num):
	curr_jam = num
	$RichTextLabel.text = str(curr_jam) +  " / " + str(max_jam)
