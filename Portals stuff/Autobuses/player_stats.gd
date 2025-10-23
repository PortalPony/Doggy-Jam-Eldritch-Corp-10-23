extends Node2D

var damage = 10
var money = 0
var payRate = 10
var inventory = []
var worldAwareness = 0  
var worldAwarenessGrowth = 1

var units = 10

var endGame = 0
var endGameParts = [0,0,0,0,0]

var endGamePoints = 0

func _process(delta: float) -> void:
	if endGame > 99:
		gameOver()
	endGame = endGameParts.reduce(func(accum, value): return accum + value, 0)


func gameOver():
	get_tree().change_scene_to_file("res://Portals stuff/Scenes/game_over.tscn")
	print_debug("huh")

var resistances = {
	"shooting": 0.0,
	"ice": 0.0,
	"physical": 0.0,
	"poison": 0.0
}

var damage_taken = {
	"shooting": 0.0,
	"ice": 0.0,
	"physical": 0.0,
	"poison": 0.0
}
