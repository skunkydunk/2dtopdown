extends CharacterBody2D

#defining a variable and exporting it to be visible from inspector
@export var move_speed : float = 100

@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree

#controls the state of the animation (walk or idle)
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)
	
#underscore delta because we're not using right now
func _physics_process(_delta):
	#Get input direction 
	var input_direction = Vector2(
		#making positive value = right, negative value = left
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	#testing by constantly printing the input_direction vector
	print(input_direction)
	
	#constantly updates the parameters
	update_animation_parameters(input_direction)
	
	#Update velocity to be input direction affected by move_speed parameter
	velocity = input_direction * move_speed
	
	
	#Move and Slide function uses velocity of character body to move character on map 
	#slide (instead of collide) allows some sliding on walls instead of just stopping
	move_and_slide()
	
	#constantly updates animation states
	pick_new_state()

func update_animation_parameters(move_input : Vector2):
	#Don't change animation parameters if there is no move input 
	if(move_input != Vector2.ZERO):
		#setting the animation parameters (based on blend tree) 
		animation_tree.set("parameters/Walk/blend_position",move_input)
		animation_tree.set("parameters/Idle/blend_position",move_input)
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
