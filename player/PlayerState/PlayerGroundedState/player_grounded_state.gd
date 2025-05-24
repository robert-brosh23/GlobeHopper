class_name GroundedState extends PlayerState

const GROUND_SPEED: float = 5000.0

var cam: Camera2D

var planet_radius

func _ready() -> void:
	cam = get_tree().get_first_node_in_group("camera")
	
func enter() -> void:
	player.velocity = Vector2(0,0)
	planet_radius = player.global_position.distance_to(player.on_planet.global_position)

func physics_update(_delta: float):
	if Input.is_action_just_pressed("jump"):
		jump()
	move_via_mouse(_delta)
	player.rotation = get_angle_to_planet() + PI/2
		
func jump():
	Transitioned.emit(self, "PlayerJumpingState")
	
func move_via_mouse(_delta: float):
	var mouse_screen = get_viewport().get_mouse_position()
	var canvas_xform = get_viewport().get_canvas_transform()
	var mouse_world  = canvas_xform.affine_inverse() * mouse_screen
	var angle = player.on_planet.global_position.angle_to_point(mouse_world)
	
	player.global_position = player.on_planet.global_position + planet_radius * Vector2(cos(angle), sin(angle))

func move_counterclockwise(_delta: float):
	var angle = get_angle_to_planet()
	angle -= get_step_length(_delta)
	player.global_position = player.on_planet.global_position + planet_radius * Vector2(cos(angle), sin(angle))

func move_clockwise(_delta: float):
	var angle = get_angle_to_planet()
	angle += get_step_length(_delta)
	player.global_position = player.on_planet.global_position + planet_radius * Vector2(cos(angle), sin(angle))
	
func get_angle_to_planet() -> float:
	return player.global_position.angle_to_point(player.on_planet.global_position) + PI
	
func get_step_length(_delta: float) -> float:
	return _delta * 200 / planet_radius
