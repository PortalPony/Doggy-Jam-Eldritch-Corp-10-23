extends Node2D
var textbox
func _ready() -> void:  
  textbox = preload("res://Portals stuff/Scenes/textboxui.tscn").instantiate()                                                                                                                                      
  add_child(textbox)                                                                                                                                                                                      
  textbox.show_dialogue([                                                                                                                                                                                                  
	  {"speaker": "Portal", "text": "Welcome to Portal Station!" },                                                                                                                                           
	  {"text": "This is the end"}                                                                                                                                                                    
  ])            
  textbox.show_dialogue([                                                                                                                                                                                                  
	  {"speaker": "Portal", "text": "Pick a portal?", 
		"choices": [                                                                                                                                                                              
		  {"text": "Skybridge", "callback": Callable(self, "_on_skybridge_choice")},                                                                                                                                       
		  {"text": "Depth Gate", "callback": Callable(self, "_on_depth_gate_choice")}                                                                                                                                      
	  ]}                                                                                                                                                                                                                   
  ])

func _on_skybridge_choice() -> void:                                                                                                                                                                                     
  textbox.show_dialogue([                                                                                                                                                                                                  
	  {"speaker": "Portal", "text": "You chose Skybridge!" }                                                                                                                    
  ]) 
  textbox.show_dialogue([                                                                                                                                                                                                  
	  {"speaker": "Portal", "text": "And it was the worst decision ever. You lost all your money on bitcoin." }                                                                                                                    
  ])
  textbox.dialogue_finished.connect(func(): textbox.queue_free())   
func _on_depth_gate_choice() -> void:                                                                                                                                                                                     
  textbox.show_dialogue([                                                                                                                                                                                                  
	  {"speaker": "Portal", "text": "You chose Depth Gate!" }                                                                                                                    
  ])          
  textbox.dialogue_finished.connect(func(): textbox.queue_free())  
