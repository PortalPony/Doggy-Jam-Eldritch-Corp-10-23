extends Node2D


@export var spawn : String = "res://base_enemy.tscn"

var instance
var amountSpawned = 5
var scene 

func _ready() -> void:
	scene = load(spawn)
	



func _process(delta: float) -> void:
	instance = scene.instantiate()
	instance.get_child(4).health += 3
	instance.position.x += 200 * amountSpawned + self.global_position.x
	instance.position.y += self.global_position.y
	add_sibling(instance)
	amountSpawned -= 1
	if amountSpawned <= 0:
		queue_free()
