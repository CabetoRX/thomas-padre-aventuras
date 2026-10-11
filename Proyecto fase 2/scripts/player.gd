extends CharacterBody2D

## Personaje jugable: Oso Thomas
## Fase 2: Movimiento básico, salto y gravedad

## Velocidad de movimiento horizontal
@export var speed: float = 200.0

## Aceleración horizontal para iniciar el movimiento con suavidad
@export var acceleration: float = 1200.0

## Desaceleración horizontal al soltar las teclas
@export var deceleration: float = 1600.0

## Velocidad de salto
@export var jump_velocity: float = -400.0

## Gravedad del juego (pixels por segundo al cuadrado)
@export var gravity: float = 800.0

func _physics_process(delta: float) -> void:
	# La gravedad y el salto se procesan antes del movimiento y las colisiones.
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

	var direction := Input.get_axis("move_left", "move_right")
	var target_speed := direction * speed
	var horizontal_rate := acceleration if direction != 0.0 else deceleration
	velocity.x = move_toward(velocity.x, target_speed, horizontal_rate * delta)

	move_and_slide()
