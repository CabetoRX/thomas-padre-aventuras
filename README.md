# Thomas y Padre Aventuras

Un oso viaja por diferentes países superando cada nivel para desbloquear el siguiente.

## Tecnologías

- **Godot 4.x**
- **GDScript**
- **Git & GitHub**

## Concepto

Prototipo de un juego 2D donde el jugador controla a un oso que debe:
- Recorrer plataformas
- Evitar enemigos
- Recolectar objetos
- Alcanzar la meta para desbloquear nuevos niveles

Cada país es un nivel independiente, bloqueado hasta completar el anterior.

## Estado actual

**Fase 4** — Nivel de España con movimiento y salto, cámara, toro perseguidor animado, tres vidas, daño con invulnerabilidad temporal y reaparición desde el checkpoint inicial.

## Estructura de Carpetas

```text
thomas-padre-aventuras/
├── assets/
│   └── characters/
│       └── bull/
│           ├── bull_enemy_jump.webm
│           └── chase/ (36 fotogramas PNG)
├── scenes/
│   ├── bull.tscn
│   ├── ground.tscn
│   ├── main.tscn
│   └── player.tscn
├── scripts/
│   ├── bull.gd
│   ├── main.gd
│   ├── player.gd
│   └── spain_level.gd
├── project.godot
└── README.md
```

## Cómo Abrirlo y Probarlo

### Requisitos

- Godot 4.x instalado

### Pasos

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/CabetoRX/thomas-padre-aventuras.git
   cd thomas-padre-aventuras
   ```

2. Abrir el proyecto en Godot 4.x:
   - Abre el editor de Godot
   - Selecciona "Abrir proyecto"
   - Navega a la carpeta clonada
   - Abre `project.godot`

3. Ejecutar el proyecto:
   - Presiona `F5` o haz clic en el botón "Reproducir"
   - Usa `A`/`D` o las flechas izquierda/derecha para moverte
   - Usa `Espacio` o `W` para saltar (solo al tocar el suelo)
   - El WebM del toro se conserva como origen; sus 36 fotogramas se usan como PNG con el fondo negro eliminado, ya que el video no contiene canal alfa.
   - El contacto con el toro resta una vida y activa dos segundos de invulnerabilidad. Al agotar las tres vidas, el oso reaparece en su checkpoint actual con las vidas restauradas.

### Pruebas de juego

Ejecuta las comprobaciones automatizadas de movimiento, salto, persecución, daño, invulnerabilidad, HUD y checkpoint:

```bash
godot --headless --path . --quit-after 900 --script res://tests/phase4_test.gd
```

## Fases de desarrollo

- **Fase 1**: Base del proyecto ✓
- **Fase 2**: Movimiento, salto, gravedad y colisiones ✓
- **Fase 3**: Nivel de España, animación del oso y cámara ✓
- **Fase 4**: Toro animado perseguidor, vidas, daño, invulnerabilidad y checkpoint inicial ✓
- **Fase 5**: Objetos coleccionables
- **Fase 6**: Checkpoints adicionales
- **Fase 7**: Meta y condición de victoria
- **Fase 8**: Sistema de niveles bloqueados
