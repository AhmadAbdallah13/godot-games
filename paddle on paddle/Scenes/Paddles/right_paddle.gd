extends CharacterBody2D


func move_paddle():
	var direction = Input.get_axis("RightPaddleUp", "RightPaddleDown")
	velocity.y = int(direction) * 1000

func _physics_process(delta):
	move_paddle()
	
	move_and_collide(velocity * delta)
