class_name Dialogue
extends Control
  
@onready var content := get_node("Content") as RichTextLabel
@onready var type_timer := get_node("TypeTyper") as Timer
@onready var pause_timer := get_node("PauseTimer") as Timer
  
# We are going to use this logic to test, will be removed later
func _ready() -> void:
	await(get_tree().create_timer(1.0), "timeout")
	update_message("Hi I was generated for the dialogue system test for the godot game engine")
  
# File: Dialogue.gd
	
# Start typing the provided message
func update_message(message: String) -> void:
	content.bbcode_text = message
	content.visible_characters = 0
	type_timer.start()

# File: Dialogue.gd
	
func _on_TypeTyper_timeout() -> void:
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
	else:
		type_timer.stop()
