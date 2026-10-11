extends CharacterBody2D

## Personaje jugable: Oso Thomas
## Fase 3: Movimiento horizontal, salto y gravedad

## Velocidad de movimiento horizontal
@export var speed: float = 200.0

## Velocidad de salto
@export var jump_velocity: float = -400.0

## Gravedad del juego (pixels por segundo al cuadrado)
@export var gravity: float = 800.0

@onready var bear_sprite: AnimatedSprite2D = $BearAnimatedSprite

func _ready() -> void:
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

func _physics_process(delta: float) -> void:
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
