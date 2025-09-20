class_name Player
extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump_amount = -500

func _physics_process(delta: float) -> void:
	get_input()
	# Add the gravity.
	velocity.y += gravity * delta
	move_and_slide()

func get_input():
	if Input.is_action_just_pressed("elevate_rocket"):
		elevate_rocket()

func elevate_rocket():
	velocity.y = jump_amount
