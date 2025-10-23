extends Node2D

var item = 1

var rate = 10

var siz = 30

#retartRate look it up with crtl+F idiot
var restartRate = 80

var timerSelf = 0

## part 0 cheast, 1 left knee, 2 right kneew, 3 L arm, 4 R arm
@export var partNumber = 0


@onready var fleshBit =%fleashyBit
## NO TEXTURES RN BUT WILL ADD LATER FOR EACH BODY PART? BUT WHAT ABOUT ANIMATION
#func _ready() -> void:
	#$FleshBlob.texture = 

func _process(delta: float) -> void:
	
	if item > 20:
		fleshBit.hide()
		$GreyBrick.hide()
	
	elif item < 0:
		$GreyBrick.show()
		fleshBit.hide()
		timerSelf += delta
		if timerSelf >= 1:
			timerSelf -=1
			
			if rate > randi_range(0,restartRate):
				item = 0
				show()


	else:
		fleshBit.show
		item += rate * delta
		$GreyBrick.show()
	# 3 HOURS atleast CUZ MAKE THIS SCALE NOT SIZE YOU DUMB F$CKER
	fleshBit.scale = Vector2(item/10,item/10)
	PlayerStats.endGameParts[partNumber] = item
	

func _on_button_pressed() -> void:
	item -= PlayerStats.damage
