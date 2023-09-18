extends CharacterBody2D

#listing states that Cows can have
enum COW_STATE {IDLE, WALK }

#setting move speed and exporting to inspector
@export var move_speed : float = 20

#accessing AnimationTree
@onready var animation_tree = $AnimationTree

#setting timers for idle/walk states
@export var idle_time : float = 5 
@export var walk_time : float = 2

#accessing timer node
@onready var timer = $Timer

#accessing sprite node
@onready var sprite = $Sprite2D

#controls the state of the animation (walk or idle)
@onready var state_machine = animation_tree.get("parameters/playback")

var move_direction : Vector2 = Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE

func _ready():
	
	pick_new_state()
	

func _physics_process(_delta):
	if (current_state == COW_STATE.WALK):
		velocity = move_direction * move_speed
	
		move_and_slide()

func select_new_direction():
	move_direction = Vector2(
		randi_range(-1,1),
		randi_range(-1,1)
	)
	
	#flipping sprite if walking left
	if (move_direction.x < 0):
		sprite.flip_h = true
	elif (move_direction.x > 0):
		sprite.flip_h = false
	

func pick_new_state():
	#change to walk state
	if(current_state == COW_STATE.IDLE):
		state_machine.travel ("walk_right")
		current_state = COW_STATE.WALK
		select_new_direction()
		timer.start(walk_time)
	#change to idle state
	elif(current_state == COW_STATE.WALK):
		state_machine.travel ("idle_right")
		current_state = COW_STATE.IDLE
		timer.start(idle_time)


func _on_timer_timeout():
	pick_new_state()
