extends Node2D


@export var thing := "breakerBox"

@export var oneShot = false

func action(amount: int):
	# Get the current value of Inventory[thing] and add amount
	PlayerStats.set(thing, PlayerStats.get(thing) + amount)
	$"..".queue_free()
