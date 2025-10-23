extends CharacterBody2D

var movement_speed: float = 200.0

@onready var target = %Player.global_position

var hp = 10


func _physics_process(_delta):
	target = %Player.global_position
	velocity = self.global_position.direction_to(target) * movement_speed
	
	move_and_slide()
	

func die():
	if hp <=0:
		queue_free()


func takeDamage(dam):
	
	hp -= dam
