extends Node2D


@export var thing := "breakerBox"

@export var oneShot = false

func action(amount: int):
	# Get the current value of Inventory[thing] and add amount
	Inventory.set(thing, Inventory.get(thing) + amount)
	$"..".queue_free()
