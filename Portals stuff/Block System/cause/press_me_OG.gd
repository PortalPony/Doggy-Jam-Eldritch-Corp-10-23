extends Area2D


var here = false

@export var amount = 1
func _process(delta: float) -> void:
	if here:
		if Input.is_action_pressed("action"):
			$"..".action(amount*delta) 

func _on_body_entered(body: Node2D) -> void:
	here = true # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	here = false # Replace with function body.
