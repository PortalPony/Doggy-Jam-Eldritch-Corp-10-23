extends CharacterBody2D
@export var target: = Node2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D


func _physics_process(delta: float) -> void:

	if target:
		navigation_agent_2d.set_target_position(target.global_position)
		
		if navigation_agent_2d.is_navigation_finished():
			velocity = Vector2.ZERO
			return
		var next_path_pos = navigation_agent_2d.get_next_path_position()
		var cur_agent_pos = global_position
		var newvel = global_position.direction_to(next_path_pos) * 100
		
		velocity = velocity.lerp(newvel, 0.1)
		move_and_slide()
		pass
func _on_navigation_agent_2d_path_changed():
	print("New path calculated!")
