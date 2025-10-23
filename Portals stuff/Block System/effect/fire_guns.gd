extends Node2D


@export var spawn : String = "res://Old Code/bullet.tscn"
@onready var main = get_tree().get_root().get_node("Main Sky Mech")
var instance
#var amountSpawned = 5
var scene 

func _ready() -> void:
	scene = load(spawn)
	

func action(amount):
	instance = scene.instantiate()
	print_debug(main)
	#spawn where you are
	instance.global_position = self.global_position
	instance.global_rotation = self.global_rotation
	#spawn next to node
	main.add_sibling(instance)
