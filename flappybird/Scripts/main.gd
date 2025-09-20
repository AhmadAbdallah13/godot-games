extends Node

const PLAYER = preload("res://Scenes/player.tscn")

@onready var main_menu_container: MarginContainer = %MainMenuContainer
@onready var game_over_container: MarginContainer = %GameOverContainer
@onready var playable_area: Node2D = %PlayableArea
@onready var parallax_2d: Parallax2D = $PlayableArea/PlayableAreaParallaxBG/Stars
@onready var player_spawn_location: Marker2D = $PlayableArea/PlayerSpawnLocation
@onready var obstacles_container: Node2D = %ObstaclesContainer
@onready var playing_container: MarginContainer = %PlayingContainer
@onready var score_label: Label = %ScoreLabel
@onready var end_scroe: Label = %EndScroe
@onready var high_score_label: Label = %HighScore
@onready var point_sound: AudioStreamPlayer = $PointSound
@onready var you_lose_sound: AudioStreamPlayer = $YouLoseSound

var parallax_2d_speed: float = 200.0
var parallax_2d_speed_increment: float = 0.1

var player: Player
var score: int = 0
var high_score: int = 0

func _process(delta: float) -> void:
	if playable_area.game_started:
		parallax_2d.scroll_offset.x -= parallax_2d_speed * delta

func start_game():
	player = PLAYER.instantiate()
	player.position = player_spawn_location.position
	score = 0
	playable_area.add_child(player)
	playable_area.visible = true
	playable_area.game_started = true
	playing_container.visible = true
	score_label.text = "Score: 0"

func _on_start_button_pressed() -> void:
	var start_game_tween = get_tree().create_tween()
	start_game_tween.tween_property(
		main_menu_container, "position", Vector2(1922, 0), 1
	)
	start_game_tween.tween_callback(start_game)

func _on_restart_game_btn_pressed() -> void:
	var start_game_tween = get_tree().create_tween()
	start_game_tween.tween_property(
		game_over_container, "position", Vector2(0, -1080), 1
	)
	start_game_tween.tween_callback(start_game)

func end_game():
	playing_container.visible = false
	playable_area.game_started = false
	if score > high_score:
		high_score = score
	if player:
		player.queue_free()

	for child in obstacles_container.get_children():
		child.queue_free()

	var start_game_tween = get_tree().create_tween()
	start_game_tween.tween_property(
		game_over_container, "position", Vector2(0, 0), 1
	)
	end_scroe.text = "Score: " + str(score)
	high_score_label.text = "High Score: " + str(high_score)
	you_lose_sound.play()

func grant_point():
	score += 1
	score_label.text = "Score: " + str(score)
	point_sound.play()
