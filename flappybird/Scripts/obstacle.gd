extends Node2D

@export var movement_speed: int

@onready var upper_area_collision: CollisionShape2D = $UpperObsArea/UpperAreaCollision
@onready var safe_area_collision: CollisionShape2D = $SafeArea/SafeAreaCollision
@onready var lower_area_collision: CollisionShape2D = $LowerObsArea/LowerAreaCollision

func _ready() -> void:
	position.y = randi_range(-300, 300)

func _physics_process(_delta: float) -> void:
	if movement_speed:
		position.x -= movement_speed

func _on_obs_area_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_group("main", "end_game")

func _on_safe_area_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_group("main", "grant_point")
