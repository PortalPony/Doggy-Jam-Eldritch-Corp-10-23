extends CanvasLayer
# Example list of store items
var labelShows = false
var dirtyTimer = 0
var store_items = [
	{"name": "Sword", "price": 50},
	{"name": "Shield", "price": 30},
	{"name": "Potion", "price": 10},
	{"name": "suck", "price": 10}
]

func _ready():
	update_money_display()
	populate_store()

func _process(delta: float) -> void:
	update_money_display()
	
	if labelShows:
		dirtyTimer += delta
		if dirtyTimer > 1.5:
			dirtyTimer =0
			labelShows = false
			$"No money".hide()
func update_money_display():

	%"Label Money".text = "Money: $" + str(PlayerStats.money)
	
func populate_store():
	var container = $HBoxContainer/VBoxContainer
	if container.get_child_count() > 0:
		for i in container.get_children():
			i.queue_free() # clear old buttons if reopened

	for item in store_items:
		var hbox = HBoxContainer.new()

		var name_label = Label.new()
		name_label.text = item["name"]
		hbox.add_child(name_label)

		var price_label = Label.new()
		price_label.text = "$" + str(item["price"])
		hbox.add_child(price_label)

		var buy_button = Button.new()
		buy_button.text = "Buy"
		buy_button.pressed.connect(buy_item.bind(item))
		hbox.add_child(buy_button)

		container.add_child(hbox)

func buy_item(item):
	if PlayerStats.money  >= item["price"]:
		PlayerStats.money  -= item["price"]
		
		update_money_display()
		print("Bought:", item["name"])
		# Add item to inventory here
		PlayerStats.inventory += [item["name"]]
	else:
		$"No money".show()
		labelShows = true
		print("Not enough money!")
