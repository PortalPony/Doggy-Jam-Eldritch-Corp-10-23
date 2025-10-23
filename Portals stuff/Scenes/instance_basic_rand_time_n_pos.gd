extends Node2D

var EnemyScene: PackedScene = preload("res://plus_basic_button.tscn")
var spawn_timer: Timer

func _ready():
	randomize()  # seed RNG

	# create a timer in code
	spawn_timer = Timer.new()
	spawn_timer.wait_time = 2.0       # seconds between spawns
	spawn_timer.autostart = true
	spawn_timer.one_shot = false
	add_child(spawn_timer)

	# connect the timer to our spawn function
	spawn_timer.timeout.connect(spawn_random_enemy)

func spawn_random_enemy():
	# make the enemy
	var enemy = EnemyScene.instantiate()

	# give it a random position (change the numbers to your area)
	var rand_x = randi_range(0, 1024)
	var rand_y = randi_range(0, 600)
	enemy.position = Vector2(rand_x, rand_y)
	
	# add it to the scene
	add_child(enemy)
	print_debug(get_children())
	
	
	
