extends Area2D


var here = false

var time = 0
var reverse = 1
@export var amount = 1
func _process(delta: float) -> void:
	if here:
		if Input.is_action_just_pressed("action"):
			$"..".action(amount*delta *reverse) 
			here = false
			reverse *= -1
			time = 1
			self.hide()
	if time > 0:
		time -= delta
	else:
		self.show()
func _on_body_entered(body: Node2D) -> void:
	here = true # Replace with function body.
	print_debug(here)

func _on_body_exited(body: Node2D) -> void:
	here = false # Replace with function body.
