extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	pass # Replace with function body.


func _on_audio_stream_player_finished():
	await get_tree().create_timer(3).timeout
	$AudioStreamPlayer.play()
