class_name PlayerFloatState extends PlayerState

var planets = []

func _ready() -> void:
	planets = get_tree().get_nodes_in_group("planet")
	
func physics_update(_delta: float):
	var collision = player.get_last_slide_collision()
	
	var collided_object = null
	if collision:
		collided_object = collision.get_collider().owner
		if collided_object is Planet:
			player.on_planet = collided_object
			Transitioned.emit(self, "PlayerGroundedState")
			return

	player.velocity += get_force_from_planets()
	

func get_force_from_planets() -> Vector2:
	var x_force = 0.0
	var y_force = 0.0
	
	for planet: Planet in planets:
		var planet_scale = planet.scale.x
		var distance = player.global_position.distance_to(planet.global_position) + (50 * planet_scale)
		var angle = player.global_position.angle_to_point(planet.global_position)
		x_force += cos(angle) * 300 * pow(planet_scale*100, 2) / pow(distance*5,2)
		y_force += sin(angle) * 300 * pow(planet_scale*100, 2)  / pow(distance*5,2)
		#print(x_force, " ", y_force)
	
	return Vector2(x_force, y_force)
