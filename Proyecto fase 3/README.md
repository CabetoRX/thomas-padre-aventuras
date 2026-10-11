# Proyecto fase 3

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

## Estado Actual

**Fase 3** — Movimiento horizontal y salto del personaje con gravedad y colisiones sobre un suelo estático.

## Estructura de Carpetas

```text
thomas-padre-aventuras/
├── Proyecto fase 3/
│   ├── assets/
│   ├── audio/
│   ├── levels/
│   ├── scenes/
│   │   ├── ground.tscn
│   │   ├── main.tscn
│   │   └── player.tscn
│   ├── scripts/
│   │   ├── main.gd
│   │   └── player.gd
│   ├── ui/
│   ├── project.godot
│   └── README.md
└── .gitignore
```

## Cómo Abrirlo y Probarlo

### Requisitos

- Godot 4.x instalado

### Pasos

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/CabetoRX/thomas-padre-aventuras.git
   cd thomas-padre-aventuras
   cd "Proyecto fase 3"
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
   - El fondo de España está en `assets/backgrounds/fondo-espana.png`
   - El osito reproduce su animación de carrera al moverse; los fotogramas transparentes están en `assets/characters/bear/run/`
   - Las plataformas y el muro final usan cuerpos estáticos separados con colisiones invisibles; puedes saltar sobre el muro derecho

## Desarrollo

Este proyecto se desarrolla en fases:

- **Fase 1**: Estructura y configuración ✓
- **Fase 2**: Movimiento del personaje y suelo con colisión ✓
- **Fase 3**: Movimiento horizontal y salto con gravedad ✓
- **Fase 3**: Nivel España y cámara
- **Fase 4**: Enemigos
- **Fase 5**: Objetos coleccionables
- **Fase 6**: Checkpoints
- **Fase 7**: Meta y condición de victoria
- **Fase 8**: Sistema de niveles bloqueados
