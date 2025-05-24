class_name PlayerJumpingState extends PlayerState

const MAX_JUMP_STRENGTH = 400

var jump_strength

func enter() -> void:
	var on_planet = player.on_planet
	var planet_radius = player.global_position.distance_to(player.on_planet.global_position)
	
	player.global_position = on_planet.global_position + planet_radius * Vector2(cos(player.rotation), sin(player.rotation))
	jump_strength = 0

func physics_update(_delta: float):
	jump_strength += _delta * 800
	if Input.is_action_just_released("jump"):
		var angle = get_angle_to_planet()
		player.velocity = Vector2(cos(angle), sin(angle)) * min(jump_strength, MAX_JUMP_STRENGTH)
		Transitioned.emit(self, "PlayerFloatState")

func get_angle_to_planet() -> float:
	return player.global_position.angle_to_point(player.on_planet.global_position) + PI
