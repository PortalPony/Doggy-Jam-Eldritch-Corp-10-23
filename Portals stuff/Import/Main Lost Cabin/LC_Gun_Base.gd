extends Node2D

#needs this to add it here so its not affected by parent
@onready var main = get_tree().get_first_node_in_group("player")
#ammo type collition changed in code for enimes vs allies
@export var spawn : String = "res://Main Lost Cabin/LC_bullet.tscn"
#shoot fast 
@export var firerate = 0.5

var instance
var scene 


@onready var timer = $Timer


@export var player = false

@export var ranged = false

func _ready() -> void:
	
	scene = load(spawn)
	timer.wait_time = firerate
	if player == true:
		timer.stop()

func _process(delta: float) -> void:
	if player:
		
		if Input.is_action_just_pressed("click"):
			timer.start()
			
			
		elif Input.is_action_just_released("click"):
			timer.stop()


func _on_timer_timeout() -> void:
	
	spawnBullet()
func spawnBullet():
	
	instance = scene.instantiate()
	if player == true:
		
		instance.collision_layer = 3
		instance.collision_mask = 4
	
	instance.global_position = self.global_position
	instance.rotation = $"..".rotation
	
	
	#BRoken Not sure why melee not work sends it global pos x2 of player
	if ranged == true:
		$"..".add_sibling(instance) # Replace with function body.
	else:
		self.add_sibling(instance)


var hp: int = 20

func take_damage(amount: int) -> void:
	hp -= amount
	
	if hp <= 0:
		die()
	
func die() -> void:
	queue_free()  # Removes the enemy from the scene
