extends CharacterBody2D

@export var speed = 400

var input_direction = Vector2(0,0)

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	
	get_input()
	move_and_slide()
	look_at(get_global_mouse_position())
	
