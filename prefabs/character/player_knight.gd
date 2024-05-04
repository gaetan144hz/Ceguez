extends CharacterBody2D
class_name Player

@onready var audio_stream_player = $AudioStreamPlayer
var audio_jump = preload("res://assets/sounds/jump.wav")
var audio_hurt = preload("res://assets/sounds/hurt.wav")

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var all_interaction = []

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		audio_stream_player.stream = audio_jump
		audio_stream_player.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction : -1, 0 , 1
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip Sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
	# Play Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
		
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


# Interaction Methods
######################################################

func _on_area_2d_body_entered(area):
	all_interaction.insert(0, area)
	update_interactions()


func _on_area_2d_body_exited(area):
	all_interaction.erase(area)
	update_interactions()


func update_interactions():
	if all_interaction:
		print("Interact!")
	else:
		print("NOT Interact!")
