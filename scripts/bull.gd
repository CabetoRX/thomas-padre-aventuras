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
	queue_redraw()

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
			if facing != direction:
				facing = direction
				queue_redraw()
			velocity.x = direction * speed

	animated_sprite.flip_h = facing < 0.0
	move_and_slide()

func knock_back_from(target_position: Vector2) -> void:
	facing = signf(global_position.x - target_position.x)
	if facing == 0.0:
		facing = 1.0
	queue_redraw()
	knockback_timer = knockback_duration
	velocity.x = facing * knockback_speed
	global_position.x += facing * 20.0

func _draw() -> void:
	draw_set_transform(Vector2.ZERO, 0.0, Vector2(facing, 1.0))
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(-25, -23), Vector2(-14, -35), Vector2(6, -34),
			Vector2(19, -26), Vector2(25, -16), Vector2(12, -8),
			Vector2(-20, -9)
		]),
		Color(0.55, 0.19, 0.1)
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(10, -32), Vector2(20, -38), Vector2(27, -29),
			Vector2(24, -16), Vector2(13, -14), Vector2(5, -22)
		]),
		Color(0.63, 0.24, 0.12)
	)
	draw_colored_polygon(
		PackedVector2Array([Vector2(10, -36), Vector2(4, -44), Vector2(17, -37)]),
		Color(0.92, 0.78, 0.48)
	)
	draw_colored_polygon(
		PackedVector2Array([Vector2(21, -35), Vector2(31, -40), Vector2(25, -29)]),
		Color(0.92, 0.78, 0.48)
	)
	draw_circle(Vector2(22, -29), 1.5, Color(0.08, 0.05, 0.04))
	for leg_x in [-16.0, -3.0, 10.0]:
		draw_line(Vector2(leg_x, -12), Vector2(leg_x, -1), Color(0.24, 0.1, 0.08), 4.0)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or not body.has_method("take_damage"):
		return

	if body.take_damage(global_position):
		knock_back_from(body.global_position)
