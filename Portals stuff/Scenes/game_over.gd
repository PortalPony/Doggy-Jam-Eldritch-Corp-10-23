extends Node2D


# GameManager.gd (autoload)
var current_scene: Node = null

func set_root_scene(scene: Node) -> void:
	current_scene = scene


var cost = 0

# In your main scene script
func _ready():
	set_root_scene(self)



func _on_return_button_button_down() -> void:
	call_deferred("_safe_change_scene")
	

func _on_start_with_2_units_button_down() -> void:
	cost = 100
	if Upgrades.twoUnits:
		PlayerStats.endGamePoints += cost 
		Upgrades.twoUnits = false
	elif PlayerStats.endGamePoints <= cost:
		PlayerStats.endGamePoints -= cost
		Upgrades.twoUnits = true
	print_debug(cost)

func _safe_change_scene():
	var new_scene = preload("res://Portals stuff/Scenes/main_blackbird.tscn").instantiate()
	
	# Remove current scene
	if current_scene:
		current_scene.queue_free()
	
	# Add new scene to root of the running scene tree
	# Since we don’t want get_tree(), use the root node from Engine
	var root_node = Engine.get_main_loop() as SceneTree
	root_node.root.add_child(new_scene)

	# Update current_scene reference
	current_scene = new_scene
