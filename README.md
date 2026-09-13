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

## Estado Actual

**Fase 1** — Estructura inicial del proyecto Godot 4.x.

## Estructura de Carpetas

```text
thomas-padre-aventuras/
├── assets/
├── audio/
├── levels/
├── scenes/
│   └── main.tscn
├── scripts/
│   └── main.gd
├── ui/
├── project.godot
├── README.md
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
   ```

2. Abrir el proyecto en Godot 4.x:
   - Abre el editor de Godot
   - Selecciona "Abrir proyecto"
   - Navega a la carpeta clonada
   - Abre `project.godot`

3. Ejecutar el proyecto:
   - Presiona `F5` o haz clic en el botón "Reproducir"
   - Deberías ver la pantalla principal con el mensaje de bienvenida

## Desarrollo

Este proyecto se desarrolla en fases:

- **Fase 1**: Estructura y configuración ✓
- **Fase 2**: Movimiento del personaje
- **Fase 3**: Nivel España y cámara
- **Fase 4**: Enemigos
- **Fase 5**: Objetos coleccionables
- **Fase 6**: Checkpoints
- **Fase 7**: Meta y condición de victoria
- **Fase 8**: Sistema de niveles bloqueados
