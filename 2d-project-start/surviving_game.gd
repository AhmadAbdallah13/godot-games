extends Node2D


func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func spawn_pine_tree():
	var pine_tree = preload("res://pine_tree.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	pine_tree.global_position = %PathFollow2D.global_position
	add_child(pine_tree)

func _on_timer_timeout():
	spawn_mob()
	spawn_pine_tree()

func _on_player_defated():
	%GameOver.visible = true
	get_tree().paused = true

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
