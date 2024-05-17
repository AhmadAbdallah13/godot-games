extends CharacterBody2D

@export var speed = 150
@export var gravity = 15
var jump_force = 450

@onready var player = get_node(".")

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var player_collision = $CollisionShape2D

@onready var player_crouch_left_ray = $CrouchRay_1
@onready var player_crouch_right_ray = $CrouchRay_2

var crouching_collision = preload("res://Resources/player_crouch_collision.tres")
var standing_collision = preload("res://Resources/player_standing_collision.tres")

var is_crouching = false
var is_standing_blocked = false

func player_movement():
	var direction = Input.get_axis("WalkLeft", "WalkRight")
	velocity.x = int(direction) * speed
	
	if Input.is_action_just_pressed("Jump") and not is_standing_blocked:
		if is_on_floor():
			velocity.y = -jump_force

	if direction != 0:
		flip_player(direction)

	if Input.is_action_just_pressed("crouch"):
		crouch()
	if Input.is_action_just_released("crouch"):
		if is_above_player_empty():
			stand()
		else:
			if not is_standing_blocked:
				is_standing_blocked = true

	if is_standing_blocked and is_above_player_empty():
		if not Input.is_action_just_pressed("crouch"):
			stand()
			is_standing_blocked = false

	update_animation(direction)

func _process(_delta):
		player_movement()

func _physics_process(_delta):
	if !is_on_floor():
		velocity.y += gravity
	
	move_and_slide()

func update_animation(direction):
	if is_on_floor():
		if direction == 0:
			if not is_crouching:
				ap.play("idle")
			elif is_crouching:
				ap.play("crouch")
		else:
			if not is_crouching:
				ap.play("run")
			elif is_crouching:
				ap.play("crouch_walk")
	else:
		if velocity.y > 1:
			ap.play("fall")
		elif velocity.y < 1:
			ap.play("jump")

func flip_player(direction):
	sprite.flip_h = (direction == -1)
	sprite.position.x = 4 * direction

func crouch():
	if is_crouching:
		return
	is_crouching = true
	player_collision.shape = crouching_collision
	player_collision.position.y = -14

func stand():
	if not is_crouching:
		return
	is_crouching = false
	player_collision.shape = standing_collision
	player_collision.position.y = -20

func is_above_player_empty():
	var result = (not player_crouch_left_ray.is_colliding() and 
		not player_crouch_right_ray.is_colliding())
	return result
