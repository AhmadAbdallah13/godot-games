extends RigidBody2D

var velocity = Vector2.ZERO
const SPEED = 400

func _ready():
	randomize()
	velocity.x = [-1,1][randi() % 2]
	velocity.y = [-0.8,0.8][randi() % 2]

func _physics_process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta * SPEED)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(reflect)

func _on_arena_body_exited(body):
	self.global_transform.origin = Vector2(576, 320)
	_ready()
