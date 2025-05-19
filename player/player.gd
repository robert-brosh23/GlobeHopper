class_name Player extends CharacterBody2D

@export var state_machine: StateMachine

var planets = []

var on_planet: Planet

func _ready() -> void:
	planets = get_tree().get_nodes_in_group("planet")

func _physics_process(delta: float) -> void:
	move_and_slide()
