extends CharacterBody2D

## Personaje jugable: Oso Thomas
## Movimiento, salto, vidas y reaparicion desde checkpoint.

## Velocidad de movimiento horizontal
@export var speed: float = 200.0

@export var max_lives: int = 3
@export var invulnerability_duration: float = 2.0

## Velocidad de salto
@export var jump_velocity: float = -400.0

## Gravedad del juego (pixels por segundo al cuadrado)
@export var gravity: float = 800.0

signal lives_changed(current_lives: int, maximum_lives: int)

@onready var bear_sprite: AnimatedSprite2D = $BearAnimatedSprite

var lives: int
var checkpoint_position: Vector2
var invulnerability_timer: float = 0.0

func _ready() -> void:
	add_to_group("player")
	lives = max_lives
	checkpoint_position = global_position

	var frame_paths := DirAccess.get_files_at("res://assets/characters/bear/run")
	frame_paths.sort()

	var sprite_frames := SpriteFrames.new()
	sprite_frames.add_animation("run")
	sprite_frames.set_animation_speed("run", 10.0)
	sprite_frames.set_animation_loop("run", true)

	var frame_count := 0
	for path in frame_paths:
		if not path.ends_with(".png"):
			continue

		var texture := load("res://assets/characters/bear/run/" + path) as Texture2D
		if texture == null:
			push_error("Could not load bear animation frame: " + path)
			return
		sprite_frames.add_frame("run", texture)
		frame_count += 1

	if frame_count == 0:
		push_error("No bear animation frames found in res://assets/characters/bear/run.")
		return

	bear_sprite.sprite_frames = sprite_frames
	bear_sprite.animation = "run"
	bear_sprite.stop()

	lives_changed.emit(lives, max_lives)

func _physics_process(delta: float) -> void:
	_update_invulnerability(delta)

	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == 0.0:
		var right_pressed := Input.is_physical_key_pressed(KEY_D) or Input.is_physical_key_pressed(KEY_RIGHT)
		var left_pressed := Input.is_physical_key_pressed(KEY_A) or Input.is_physical_key_pressed(KEY_LEFT)
		direction = float(right_pressed) - float(left_pressed)

	velocity.x = direction * speed
	bear_sprite.flip_h = direction < 0.0
	if is_zero_approx(direction):
		bear_sprite.stop()
	else:
		bear_sprite.play("run")

	move_and_slide()

func take_damage(_source_position: Vector2) -> bool:
	if invulnerability_timer > 0.0:
		return false

	lives -= 1
	lives_changed.emit(lives, max_lives)
	invulnerability_timer = invulnerability_duration

	if lives <= 0:
		lives = max_lives
		global_position = checkpoint_position
		velocity = Vector2.ZERO
		lives_changed.emit(lives, max_lives)

	return true

func set_checkpoint(position: Vector2) -> void:
	checkpoint_position = position

func _update_invulnerability(delta: float) -> void:
	if invulnerability_timer <= 0.0:
		return

	invulnerability_timer = maxf(invulnerability_timer - delta, 0.0)
	if invulnerability_timer == 0.0:
		bear_sprite.modulate = Color.WHITE
	else:
		bear_sprite.modulate.a = 0.35 if fmod(invulnerability_timer, 0.2) < 0.1 else 1.0
