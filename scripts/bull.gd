extends CharacterBody2D

@export var speed: float = 175.0
@export var gravity: float = 800.0
@export var knockback_speed: float = 240.0
@export var knockback_duration: float = 0.35

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var player: CharacterBody2D
var knockback_timer: float = 0.0
var facing: float = 1.0

func _ready() -> void:
	var frame_paths := DirAccess.get_files_at("res://assets/characters/bull/chase")
	frame_paths.sort()

	var sprite_frames := SpriteFrames.new()
	sprite_frames.add_animation("chase")
	sprite_frames.set_animation_speed("chase", 12.0)
	sprite_frames.set_animation_loop("chase", true)

	var frame_count := 0
	for path in frame_paths:
		if not path.ends_with(".png"):
			continue

		var texture := load("res://assets/characters/bull/chase/" + path) as Texture2D
		if texture == null:
			push_error("Could not load bull animation frame: " + path)
			return
		sprite_frames.add_frame("chase", texture)
		frame_count += 1

	if frame_count == 0:
		push_error("No bull animation frames found in res://assets/characters/bull/chase.")
		return

	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.animation = "chase"
	animated_sprite.play("chase")

func _physics_process(delta: float) -> void:
	if player == null or not is_instance_valid(player):
		var player_node := get_tree().get_first_node_in_group("player")
		if player_node is CharacterBody2D:
			player = player_node
		else:
			return

	if not is_on_floor():
		velocity.y += gravity * delta

	if knockback_timer > 0.0:
		knockback_timer = maxf(knockback_timer - delta, 0.0)
	else:
		var direction := signf(player.global_position.x - global_position.x)
		if direction != 0.0:
			facing = direction
			velocity.x = direction * speed

	animated_sprite.flip_h = facing < 0.0
	move_and_slide()

func knock_back_from(target_position: Vector2) -> void:
	facing = signf(global_position.x - target_position.x)
	if facing == 0.0:
		facing = 1.0
	knockback_timer = knockback_duration
	velocity.x = facing * knockback_speed
	global_position.x += facing * 20.0

func _on_hitbox_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or not body.has_method("take_damage"):
		return

	if body.take_damage(global_position):
		knock_back_from(body.global_position)
