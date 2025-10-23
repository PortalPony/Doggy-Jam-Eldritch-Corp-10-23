extends Node2D
@onready var timer: Timer = $Timer

var current
@export var spawn_scene:PackedScene

var hasnode = false
@export var time: float
 

func _ready() -> void:
	spawn()



func _process(_delta: float) -> void:

	if current == null:
		current = self
		print("DSasdas")

		hasnode = true
	if hasnode:
		hasnode = false
		timer.wait_time = time
		timer.start()

func spawn():
	var scene_in = spawn_scene.instantiate()
	current = scene_in
	add_child(scene_in)
	scene_in.connect("tree_exiting",qued_free)   


func _on_timer_timeout() -> void:
	print("dfggfgdfg")
	spawn()

func qued_free():
	
	current = null
