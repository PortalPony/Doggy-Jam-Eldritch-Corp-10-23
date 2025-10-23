extends ProgressBar
var progress := 0.0  # starts at 0%


func _process(delta: float) -> void:
	progress = clamp(PlayerStats.endGame, 0, 100)
	var tween = create_tween()
	tween.tween_property(self, "value", progress, 0.5)  # 0.5 seconds
