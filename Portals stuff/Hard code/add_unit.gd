extends Node2D


@export var thing := "units"

var units = [0]

var currentUnit = 0

func _ready() -> void:
	$"Units Label".text = str(units[currentUnit])

func _on_add_unit_pressed() -> void:
	if PlayerStats.get(thing) > 0:
		PlayerStats.set(thing, PlayerStats.get(thing) - 1)
		units[currentUnit] += 1
		$"Units Label".text = str(units[currentUnit])

func _on_minus_unit_pressed() -> void:
	
	if units[currentUnit] > 0:
		units[currentUnit] -= 1
		$"Units Label".text = str(units[currentUnit])
