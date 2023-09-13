extends CharacterBody2D

#defining a variable and exporting it to be visible from inspector
@export var move_speed : float = 100

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
	
	#Update velocity to be input direction affected by move_speed parameter
	velocity = input_direction * move_speed
	
	
	#Move and Slide function uses velocity of character body to move character on map 
	#slide (instead of collide) allows some sliding on walls instead of just stopping
	move_and_slide()
	
