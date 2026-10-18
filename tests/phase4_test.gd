extends SceneTree

func _initialize() -> void:
	call_deferred("_run_checks")

func _run_checks() -> void:
	var main_scene := load("res://scenes/main.tscn") as PackedScene
	var main_instance := main_scene.instantiate()
	root.add_child(main_instance)
	for _frame in range(30):
		await physics_frame

	var player := main_instance.get_node("Player")
	var bull := main_instance.get_node("Ground/Bull")
	var lives_label := main_instance.get_node("Ground/CanvasLayer/LivesLabel")
	assert(player.lives == 3, "The player should start with three lives.")
	assert(lives_label.text == "Vidas: 3 / 3", "The level HUD should show the initial lives.")
	assert(bull.animated_sprite.is_playing(), "The bull animation should be playing.")
	assert(bull.animated_sprite.sprite_frames.get_frame_count("chase") == 36, "All bull animation frames should load.")
	assert(bull.animated_sprite.sprite_frames.get_frame_texture("chase", 0).get_image().detect_alpha(), "Bull frames should have transparent backgrounds.")
	assert(bull.global_position.x > 120.0, "The bull should chase the stationary player.")
	assert(player.is_on_floor(), "The player should land on the level floor.")

	var starting_x: float = player.global_position.x
	Input.action_press("ui_right")
	for _frame in range(12):
		await physics_frame
	Input.action_release("ui_right")
	assert(player.global_position.x > starting_x, "The player should move to the right.")

	var starting_y: float = player.global_position.y
	Input.action_press("jump")
	await physics_frame
	Input.action_release("jump")
	for _frame in range(10):
		await physics_frame
	assert(player.global_position.y < starting_y, "The player should jump.")

	bull.global_position = player.global_position + Vector2(-5.0, 0.0)
	for _frame in range(3):
		await physics_frame
	assert(player.lives == 2, "Contact with the bull should remove one life.")
	assert(player.invulnerability_timer > 0.0, "Contact should enable invulnerability.")
	assert(not player.take_damage(bull.global_position), "Invulnerability should block repeat damage.")
	assert(player.lives == 2, "Repeated damage during invulnerability should not change lives.")
	assert(lives_label.text == "Vidas: 2 / 3", "The HUD should update when the player takes damage.")

	await create_timer(player.invulnerability_duration + 0.1).timeout
	player.set_checkpoint(Vector2(300.0, 397.0))
	assert(player.take_damage(bull.global_position), "Damage should resume after invulnerability.")
	assert(player.lives == 1, "A later hit should remove one life.")

	await create_timer(player.invulnerability_duration + 0.1).timeout
	assert(player.take_damage(bull.global_position), "The third hit should be accepted.")
	assert(player.lives == 3, "Lives should be restored after reaching zero.")
	assert(player.global_position.is_equal_approx(Vector2(300.0, 397.0)), "The player should respawn at the checkpoint.")
	assert(lives_label.text == "Vidas: 3 / 3", "The HUD should update after respawning.")

	print("Phase 4 gameplay checks passed.")
	quit()
