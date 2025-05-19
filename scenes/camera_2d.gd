extends Camera2D

@export var player: Player

func _process(delta: float) -> void:
	global_position = player.global_position
