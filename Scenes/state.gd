extends Node
# Clicker game variables
var current_level = 1
var damage_level = 1
var coin_value = 10
var chance_to_crit = 1

# Dodging game variables
var game_running : bool = true
var retryClicked = false
var gold_worth = 10
var gold_max_time_to_spawn = 10
var spawn_rate = 1.0
var familiar_speed = 600

#Idle Game variables
var car_level = 1
var pawn_shop_level = 1
var item_value = 10
var chance_to_hit = 1

#Home Variables
var fridge_level = 1
var bed_level = 1
var tv_level = 1
var max_hunger = 100
var max_sleep = 100
var max_entertainment = 100
var vampire_state = "default"
var points_needed_for_good = 100
var points_needed_for_bad = 100
var progress = 0
var food_level = 100
var boredom_level = 100
var sleep_level = 100
var food_drain_rate = 3
var boredom_drain_rate = 3
var sleep_drain_rate = 3
var inMiniGame = false
var hasDrainedInMiniGame = false
var sleeping = false

#Shop variables
var showShop = false
#COSTS
#minigames
var dodge_upgrade1_cost = 100
var dodge_upgrade2_cost = 100
var dodge_upgrade3_cost = 100
var idle_upgrade1_cost = 100
var idle_upgrade2_cost = 100
var idle_upgrade3_cost = 100
var clicker_upgrade1_cost = 100
var clicker_upgrade2_cost = 100
var clicker_upgrade3_cost = 100

#vampire
var fridge_upgrade1_cost = 100
var fridge_upgrade2_cost = 100
var fridge_upgrade3_cost = 100
var tv_upgrade1_cost = 100
var tv_upgrade2_cost = 100
var tv_upgrade3_cost = 100
var bed_upgrade1_cost = 100
var bed_upgrade2_cost = 100
var bed_upgrade3_cost = 100

#Purchased
var dodging_more_valuable = false
var dodging_faster_familiar = false
var dodging_fewer_stakes = false

var idle_higher_chance = false

var clicker_more_val_enemy = false
var clicker_crit_chance = false

var fridge_bigger = false
var fridge_slower = false

var tv_bigger = false
var tv_slower = false

var bed_bigger = false
var bed_slower = false

#Global variables:
var GOLD = 100
var firstTimePlaying = true

func _process(delta):
	if !inMiniGame:
		food_level -= delta * food_drain_rate
		boredom_level -= delta * boredom_drain_rate
		if !sleeping:
			sleep_level -= delta * sleep_drain_rate
	else:
		if !hasDrainedInMiniGame:
			hasDrainedInMiniGame = true
			var randFoodSub = randi_range(20,40)
			var randBoredomSub = randi_range(20,40)
			var randSleepSub = randi_range(20,40)
			
			if food_level - randFoodSub < 10:
				food_level = 10
			else:
				food_level -= randFoodSub
				
			if boredom_level - randBoredomSub < 10:
				boredom_level = 10
			else:
				boredom_level -= randBoredomSub
				
			if sleep_level - randSleepSub < 10:
				sleep_level = 10
			else:
				sleep_level -= randSleepSub
