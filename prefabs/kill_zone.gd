extends Area2D

@onready var timer = $Timer
@onready var audio_stream = $AudioStreamPlayer2D
var death = preload("res://assets/sounds/explosion.wav")

func _on_body_entered(body):
	if body.name == 'Player_Knight':
		print("You Died!")
		audio_stream.stream = death
		audio_stream.play()
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		timer.start()
	


func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	
