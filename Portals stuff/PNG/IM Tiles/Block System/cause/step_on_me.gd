extends Area2D

var switch = false


var selfTimer = 0
var amount = 1
@export var oneshot = false
func _process(delta: float) -> void:
	if switch:
			$"..".action(amount)
			queue_free()
			
			selfTimer += 1
			$"..".action(amount) 
			

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		switch = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		switch = false
 # Replace with function body.
