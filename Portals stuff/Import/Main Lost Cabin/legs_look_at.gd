extends Sprite2D



func _process(delta: float) -> void:
	look_at($"..".velocity +global_position)
