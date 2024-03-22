extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree.get("parameters/playback")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

func _ready():
	update_animation_parameters(starting_direction)
	
func _physics_process(delta):
	# Get input direction
	var input_direction = Vector2(
	 	Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	)
	
	if Input.is_action_pressed("left"):
		$Sprite2D.scale = Vector2(1, 1)
	elif Input.is_action_pressed("right"):
		$Sprite2D.scale = Vector2(-1, 1)
	
	# update velocity
	velocity = input_direction * move_speed
	
	# move
	move_and_slide()
	pick_new_state()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return

func update_animation_parameters(move_inupt: Vector2):
	pass


func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel('walk')
	else:
		state_machine.travel('idle')
