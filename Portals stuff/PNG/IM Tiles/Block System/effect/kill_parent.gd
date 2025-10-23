extends Node2D


@export var hp = 10

@export var changeScene = false
func action(amount):
	hp -= amount
	
	if hp <=0:
		
		if changeScene:
			get_tree().change_scene_to_file("res://main/game_over.tscn")
