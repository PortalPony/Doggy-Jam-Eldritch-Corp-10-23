extends Node2D

var time = 0
# 1 minute
var payPeriod = 2
var payRate = PlayerStats.payRate

func _process(delta: float) -> void:
	time += delta
	if time >= payPeriod:
		time -=payPeriod
		PlayerStats.money += PlayerStats.payRate
		PlayerStats.worldAwareness += PlayerStats.worldAwarenessGrowth
