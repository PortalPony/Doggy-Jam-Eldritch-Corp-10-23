extends CharacterBody2D



@export var speed = 100
@export var damage: int = 2

@export var range = 200

var time = 0

var dev= randi_range(-1,1)
func _process(delta: float) -> void:
	#Y NO WORK
	velocity = Vector2(dev, -speed).rotated(self.rotation)
	
	#DELETE SELF ON RANGE distance
	time += delta
	if time * speed >= range:
		queue_free()
	
	#DUBM SHIT
	move_and_slide()
	






func _on_area_2d_body_entered(body: Node2D) -> void:

	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()  # Destroy bullet afte
	else:
		queue_free() # Replace with function body.
