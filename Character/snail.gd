extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@export var movement_speed : float = 30.0
@export var starting_move_direction : Vector2 = Vector2.LEFT
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@export var hit_state : State

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	

	var direction : Vector2 = starting_move_direction
	if direction && state_machine.check_if_can_move():
		velocity.x = direction.x * movement_speed
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
	
	
	
	move_and_slide()
	
