class_name Player extends CharacterBody2D

@export var state_machine: StateMachine

var planets = []
var gravity_on = true

var on_planet: Planet

func _ready() -> void:
	planets = get_tree().get_nodes_in_group("planet")

func _physics_process(delta: float) -> void:
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_gravity"):
		gravity_on = !gravity_on
