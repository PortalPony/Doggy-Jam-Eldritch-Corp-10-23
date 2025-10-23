extends Node


var twoUnits = false


func _ready() -> void:
	if twoUnits:
		PlayerStats.units += 2
