extends Node2D

const OBSTACLE = preload("res://Scenes/obstacle.tscn")
@onready var obstacles_spawn_location: Marker2D = %ObstaclesSpawnLocation
@onready var obstacles_container: Node2D = %ObstaclesContainer

var obstacles_speed: int = 5
var game_started: bool = false

func _on_floor_border_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_group("main", "end_game")

func _on_obstacle_creation_timer_timeout() -> void:
	"""
	create an obstacle each time the timer fires this signal
	"""

	if game_started:
		var obstacle = OBSTACLE.instantiate()
		obstacle.movement_speed = obstacles_speed
		obstacle.position.x = obstacles_spawn_location.position.x
		obstacles_container.add_child(obstacle)

func _on_screen_border_area_2d_body_entered(body: Node2D) -> void:
	# body is always an obstacle
	body.queue_free()
