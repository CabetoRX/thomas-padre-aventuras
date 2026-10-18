extends Node2D

@onready var lives_label: Label = $CanvasLayer/LivesLabel

func _ready() -> void:
	call_deferred("_connect_player")

func _connect_player() -> void:
	var player := get_tree().get_first_node_in_group("player")
	if player == null or not player.has_signal("lives_changed"):
		push_error("Spain level could not find a player with a lives_changed signal.")
		return

	player.lives_changed.connect(_on_player_lives_changed)
	_on_player_lives_changed(player.lives, player.max_lives)

func _on_player_lives_changed(current_lives: int, maximum_lives: int) -> void:
	lives_label.text = "Vidas: %d / %d" % [current_lives, maximum_lives]
