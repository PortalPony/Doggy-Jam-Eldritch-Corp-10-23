extends CanvasLayer


@onready var bar = $TellVar
@onready var label = $Label

var progress := 0.0  # starts at 0%

func _ready():
	update_progress(0)
func update_progress(amount: float):
	progress = clamp(amount, 0, 100)
	var tween = create_tween()
	tween.tween_property(bar, "value", progress, 0.5)  # 0.5 seconds


func _process(delta: float) -> void:


	update_progress(PlayerStats.worldAwareness)
	
