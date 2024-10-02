extends Node2D

var car_default_speed = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	update_UI()
	State.inMiniGame = true
	State.hasDrainedInMiniGame = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Original Companion
	$CarPath/CarPathFollow.progress += delta * car_default_speed * State.car_level
	
	if $CarPath/CarPathFollow.progress_ratio > 0.5:
		$CarPath/CarPathFollow/Car.flip_h = true
	else:
		$CarPath/CarPathFollow/Car.flip_h = false

func _on_pawn_shop_area_area_entered(area):
	if area.name == "CarArea":
		var double_value_chance = randi_range(1,5)
		if double_value_chance <= State.chance_to_hit:
			State.GOLD += (State.item_value * State.pawn_shop_level * 2) + (State.item_value * State.pawn_shop_level * 2 * State.evilBoost)
		else:
			State.GOLD += (State.item_value * State.pawn_shop_level) + (State.item_value * State.pawn_shop_level * State.evilBoost)
		
		update_UI()


func update_UI():
	$gold_count.text = str(State.GOLD)


func _on_return_home_pressed():
	$click.play()
	get_tree().change_scene_to_file("res://Scenes/Home/home.tscn")
