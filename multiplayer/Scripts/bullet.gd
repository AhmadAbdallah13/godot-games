extends CharacterBody2D


const SPEED = 500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2


func _ready() -> void:
	direction = Vector2(1, 0).rotated(rotation)

func _physics_process(delta: float) -> void:
	velocity = SPEED * direction

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()
