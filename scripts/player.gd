extends CharacterBody2D

## Personaje jugable: Oso Thomas
## Fase 2: Movimiento básico, salto y gravedad

## Velocidad de movimiento horizontal
@export var speed: float = 200.0

## Velocidad de salto
@export var jump_velocity: float = -400.0

## Gravedad del juego (pixels por segundo al cuadrado)
@export var gravity: float = 800.0

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Permitir salto solo si está en el suelo
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

	# Obtener entrada de movimiento horizontal
	var direction: float = 0.0
	if Input.is_action_pressed("move_left"):
		direction = -1.0
	if Input.is_action_pressed("move_right"):
		direction = 1.0

	# Aplicar velocidad horizontal
	velocity.x = direction * speed

	# Mover el personaje
	move_and_slide()
