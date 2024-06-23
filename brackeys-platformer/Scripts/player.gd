extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		# apply jumping animation 
		animated_sprite.play("jump")
		
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (
		is_on_floor() or not coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		animated_sprite.flip_h = false if direction == 1 else true
		velocity.x = direction * SPEED
		
		# apply running animation 
		animated_sprite.play("run")
	else:
		# apply idle animation
		animated_sprite.play("idle")
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var was_on_the_floor = self.is_on_floor()
	move_and_slide()
	
	# start the grace period of allowing the player to jump from the cliff
	if was_on_the_floor and not self.is_on_floor():
		coyote_timer.start()
