extends Node2D

var food_options_visible = false
var timerRunning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$boredomBar.value = State.boredom_level
	$sleepBar.value = State.sleep_level
	$foodBar.value = State.food_level
	$boredomBar.max_value = State.max_entertainment
	$foodBar.max_value = State.max_hunger
	$sleepBar.max_value = State.max_sleep
		
		
	State.inMiniGame = false
	State.hasDrainedInMiniGame = false
	food_options_visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $fridge.animation == "level1":
		$fridge.scale = Vector2(0.361,0.361)
		$fridge.position = Vector2(214,800)
		
	elif $fridge.animation == "level2":
		$fridge.scale = Vector2(0.416,0.416)
		$fridge.position = Vector2(164,686)
		
	elif $fridge.animation == "level3":
		$fridge.scale = Vector2(0.416,0.416)
		$fridge.position = Vector2(216,641)
		
		
	if $bed.animation == "bed1_sleep" or $bed.animation == "bed2_sleep" or $bed.animation == "bed3_sleep":
		$bed.position = Vector2(1636, 552)
	else:
		$bed.position = Vector2(1618, 628)
	
	if State.progress > 0:
		$ProgressToGood.value = State.progress
	elif State.progress < 0: 
		$ProgressToBad.value = State.progress * -1
	elif State.progress == 0:
		$ProgressToGood.value = 0
		$ProgressToBad.value = 0
		
		
	#Draining bars
	$boredomBar.value = State.boredom_level
	$sleepBar.value = State.sleep_level
	$foodBar.value = State.food_level
	
	$boredomBar.max_value = State.max_entertainment
	$foodBar.max_value = State.max_hunger
	$sleepBar.max_value = State.max_sleep
	
	if $boredomBar.value/$boredomBar.max_value <= 0.5:
		$Emote.show()
		$Emote.play("bored")
	elif $foodBar.value/$foodBar.max_value <= 0.5:
		$Emote.show()
		$Emote.play("hungry")
	elif $sleepBar.value/$sleepBar.max_value <= 0.5:
		$Emote.show()
		$Emote.play("sleepy")
	else:
		$Emote.hide()
		
	if State.sleeping:
		$Emote.hide()
	
	if State.showShop == true:
		$shop.visible = true
		get_tree().paused = true
	else:
		$shop.visible = false
		
	if State.bed_level == 1:
		if State.sleeping:
			$bed.play("bed1_sleep")
		else:
			$bed.play("bed1_idle")
	if State.bed_level == 2:
		if State.sleeping:
			$bed.play("bed2_sleep")
		else:
			$bed.play("bed2_idle")
	if State.bed_level == 3:
		if State.sleeping:
			$bed.play("bed3_sleep")
		else:
			$bed.play("bed3_idle")
			
	if State.tv_level == 1:
		$tv.play("level1")
	if State.tv_level == 2:
		$tv.play("level2")
	if State.tv_level == 3:
		$tv.play("level3")
		
	if State.fridge_level == 1:
		$fridge.play("level1")
		$FoodOptions.play("both_gray")
		$FoodOptions/blood.disabled = true
		$FoodOptions/broccoli.disabled = true
	if State.fridge_level == 2:
		$fridge.play("level2")
		$FoodOptions.play("bottom_gray")
		$FoodOptions.position = Vector2(340,698)
		$FoodOptions/blood.disabled = false
		$FoodOptions/broccoli.disabled = true
	if State.fridge_level == 3:
		$fridge.play("level3")
		$FoodOptions.play("options")
		$FoodOptions.position = Vector2(214,644)
		$FoodOptions/blood.disabled = false
		$FoodOptions/broccoli.disabled = false
		
	if food_options_visible:
		$FoodOptions.show()
	else:
		$FoodOptions.hide()
		
	if State.progress == 100 or State.progress == -100:
		if timerRunning == false:
			$TransformationTimer.start()
			timerRunning = true
		
		if State.vampire_state == "good":
			$vampire.play("good")
		elif State.vampire_state == "evil":
			$vampire.play("bad")
			
	
func _on_mini_games_pressed():
	$click.play()
	get_tree().paused = true
	$MiniGamesMenu.visible = true

func _on_idle_pressed():
	$click.play()
	get_tree().change_scene_to_file("res://Scenes/Idle/idle.tscn")
	
func _on_dodging_pressed():
	$click.play()
	get_tree().change_scene_to_file("res://Scenes/Dodging/dodging.tscn")

func _on_clicker_pressed():
	$click.play()
	get_tree().change_scene_to_file("res://Scenes/Clicker/clicker.tscn")




func _on_button_pressed():
	$click.play()
	State.showShop = true


func _on_tv_area_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("mouse_click"):
		$click.play()
		if !State.sleeping:
			if State.boredom_level + 25 * State.tv_level < State.max_entertainment:
				State.boredom_level += 25 * State.tv_level
			else:
				State.boredom_level = State.max_entertainment


func _on_sleeping_timer_timeout():
	State.sleeping = false
	$vampire.show()

func _on_bed_area_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("mouse_click"):
		$click.play()
		State.sleeping = true
		$vampire.hide()
		$SleepingTimer.start()
		if State.sleep_level + 25 * State.bed_level < State.max_sleep:
			State.sleep_level += 25 * State.bed_level
		else:
			State.sleep_level = State.max_sleep


func _on_fridge_area_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("mouse_click"):
		$click.play()
		food_options_visible = !food_options_visible


func _on_burger_pressed():
	$click.play()
	if State.food_level + 25 < State.max_hunger:
		State.food_level += 25
	else:
		State.food_level = State.max_hunger
	if State.progress - 25 > - 100:
		State.progress -= 25
	else:
		State.progress = -100
		
	if State.progress == -100:
		State.vampire_state = "evil"


func _on_watermelon_pressed():
	$click.play()
	if State.food_level + 25 < State.max_hunger:
		State.food_level += 25
	else:
		State.food_level = State.max_hunger
	if State.progress + 25 < 100:
		State.progress += 25
	else:
		State.progress = 100
		
	if State.progress == 100:
		State.vampire_state = "good"


func _on_blood_pressed():
	$click.play()
	if State.food_level + 50 < State.max_hunger:
		State.food_level += 50
	else:
		State.food_level = State.max_hunger
		
	if State.progress - 50 > - 100:
		State.progress -= 50
	else:
		State.progress = -100
		
	if State.progress == -100:
		State.vampire_state = "evil"
	
	
func _on_broccoli_pressed():
	$click.play()
	if State.food_level + 50 < State.max_hunger:
		State.food_level += 50
	else:
		State.food_level = State.max_hunger
		
	if State.progress + 50 < 100:
		State.progress += 50
	else:
		State.progress = 100
		
	if State.progress == 100:
		State.vampire_state = "good"


func _on_transformation_timer_timeout():
	State.vampire_state = "default"
	$vampire.play("normal")
	State.progress = 0
	timerRunning = false
