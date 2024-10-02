extends Node2D

var menu = "default"

# Called when the node enters the scene tree for the first time.
func _ready():
	$MiniGameUpgrade.button_pressed = true
	$LeftUpgrade.button_pressed = true
	$Label2.text = "GOLD: " + str(State.GOLD)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label2.text = "GOLD: " + str(State.GOLD)
	if $MiniGameUpgrade.button_pressed == true:
		$LeftUpgrade/dodging.show()
		$LeftUpgrade/fridge.hide()
		$MiddleUpgrade/idle.show()
		$MiddleUpgrade/tv.hide()
		$RightUpgrade/clicker.show()
		$RightUpgrade/bed.hide()
		if $LeftUpgrade.button_pressed == true:
			menu = "dodging"
			if !State.dodging_more_valuable:
				$Upgrade1.text = "More valuable coins (Cost: " + str(State.dodge_upgrade1_cost) + ")" 
				$Upgrade1.disabled = false
			else:
				$Upgrade1.text = "MAXED"
				$Upgrade1.disabled = true
				
			if !State.dodging_faster_familiar:
				$Upgrade2.text = "Faster familiar (Cost: " + str(State.dodge_upgrade2_cost) + ")"
				$Upgrade2.disabled = false
			else:
				$Upgrade2.text = "MAXED"
				$Upgrade2.disabled = true
				
			if !State.dodging_fewer_stakes:
				$Upgrade3.text = "Fewer Stakes (Cost: " + str(State.dodge_upgrade3_cost) + ")"
				$Upgrade3.disabled = false
			else:
				$Upgrade3.text = "MAXED"
				$Upgrade3.disabled = true
		if $MiddleUpgrade.button_pressed == true:
			menu = "idle"
			if State.car_level < 3:
				$Upgrade1.text = "Upgrade Car (Cost: " + str(State.idle_upgrade1_cost) + ")"
				$Upgrade1.disabled = false
			else:
				$Upgrade1.text = "MAXED"
				$Upgrade1.disabled = true
			
			if State.pawn_shop_level < 3:
				$Upgrade2.text = "Upgrade Pawn Shop (Cost: " + str(State.idle_upgrade2_cost) + ")"
				$Upgrade2.disabled = false
			else:
				$Upgrade2.text = "MAXED"
				$Upgrade2.disabled = true
				
			if !State.idle_higher_chance:
				$Upgrade3.text = "Higher chance for valuable loot (Cost: " + str(State.idle_upgrade3_cost) + ")"
				$Upgrade3.disabled = false
			else:
				$Upgrade3.text = "MAXED"
				$Upgrade3.disabled = true
		if $RightUpgrade.button_pressed == true:
			menu = "clicker"
			if State.damage_level < 3:
				$Upgrade1.text = "Upgrade Damage (Cost: " + str(State.clicker_upgrade1_cost) + ")"
				$Upgrade1.disabled = false
			else:
				$Upgrade1.text = "MAXED"
				$Upgrade1.disabled = true
				
			if !State.clicker_more_val_enemy:
				$Upgrade2.text = "More valuable enemy (Cost: " + str(State.clicker_upgrade2_cost) + ")"
				$Upgrade2.disabled = false
			else:
				$Upgrade2.text = "MAXED"
				$Upgrade2.disabled = true
				
			if !State.clicker_crit_chance:
				$Upgrade3.text = "Critical hit chance (Cost: " + str(State.clicker_upgrade3_cost) + ")"
				$Upgrade3.disabled = false
			else:
				$Upgrade3.text = "MAXED"
				$Upgrade3.disabled = true
			
	if $VampireUpgrades.button_pressed == true:
		$LeftUpgrade/dodging.hide()
		$LeftUpgrade/fridge.show()
		$MiddleUpgrade/idle.hide()
		$MiddleUpgrade/tv.show()
		$RightUpgrade/clicker.hide()
		$RightUpgrade/bed.show()
		if $LeftUpgrade.button_pressed == true:
			menu = "fridge"
			if State.fridge_level < 3:
				$Upgrade1.text = "Upgrade fridge (Cost: " + str(State.fridge_upgrade1_cost) + ")" 
				$Upgrade1.disabled = false
			else:
				$Upgrade1.text = "MAXED"
				$Upgrade1.disabled = true
				
			if !State.fridge_bigger:
				$Upgrade2.text = "Bigger stomach (Cost: " + str(State.fridge_upgrade2_cost) + ")" 
				$Upgrade2.disabled = false
			else:
				$Upgrade2.text = "MAXED"
				$Upgrade2.disabled = true
				
			if !State.fridge_slower:
				$Upgrade3.text = "Stay full for longer (Cost: " + str(State.fridge_upgrade3_cost) + ")" 
				$Upgrade3.disabled = false
			else:
				$Upgrade3.text = "MAXED"
				$Upgrade3.disabled = true
		if $MiddleUpgrade.button_pressed == true:
			menu = "tv"
			if State.tv_level < 3:
				$Upgrade1.text = "Upgrade TV (Cost: " + str(State.tv_upgrade1_cost) + ")" 
				$Upgrade1.disabled = false
			else:
				$Upgrade1.text = "MAXED"
				$Upgrade1.disabled = true
				
			if !State.tv_bigger:
				$Upgrade2.text = "Higher happiness (Cost: " + str(State.tv_upgrade2_cost) + ")"
				$Upgrade2.disabled = false
			else:
				$Upgrade2.text = "MAXED"
				$Upgrade2.disabled = true
				
			if !State.tv_slower:
				$Upgrade3.text = "Stay happy for longer (Cost: " + str(State.tv_upgrade3_cost) + ")"
				$Upgrade3.disabled = false
			else:
				$Upgrade3.text = "MAXED"
				$Upgrade3.disabled = true
		if $RightUpgrade.button_pressed == true:
			menu = "bed"
			if State.bed_level < 3:
				$Upgrade1.text = "Upgrade Coffin (Cost: " + str(State.tv_upgrade1_cost) + ")"
				$Upgrade1.disabled = false
			else:
				$Upgrade1.text = "MAXED"
				$Upgrade1.disabled = true
			
			if !State.bed_bigger:
				$Upgrade2.text = "Bigger sleep bar (Cost: " + str(State.tv_upgrade2_cost) + ")"
				$Upgrade2.disabled = false
			else:
				$Upgrade2.text = "MAXED"
				$Upgrade2.disabled = true
				
			if !State.bed_slower:
				$Upgrade3.text = "Become tired less often (Cost: " + str(State.tv_upgrade3_cost) + ")"
				$Upgrade3.disabled = false
			else:
				$Upgrade3.text = "MAXED"
				$Upgrade3.disabled = true
		
		


func _on_mini_game_upgrade_toggled(toggled_on):
	if toggled_on:
		$VampireUpgrades.button_pressed = false


func _on_vampire_upgrades_toggled(toggled_on):
	if toggled_on:
		$MiniGameUpgrade.button_pressed = false


func _on_left_upgrade_toggled(toggled_on):
	if toggled_on:
		$MiddleUpgrade.button_pressed = false
		$RightUpgrade.button_pressed = false
		


func _on_middle_upgrade_toggled(toggled_on):
	if toggled_on:
		$LeftUpgrade.button_pressed = false
		$RightUpgrade.button_pressed = false

func _on_right_upgrade_toggled(toggled_on):
	if toggled_on:
		$LeftUpgrade.button_pressed = false
		$MiddleUpgrade.button_pressed = false


func _on_right_upgrade_2_pressed():
	State.showShop = false
	get_tree().paused = false


func _on_upgrade_1_pressed():
	if menu == "dodging":
		if State.GOLD >= State.dodge_upgrade1_cost:
			State.GOLD -= State.dodge_upgrade1_cost
			State.dodging_more_valuable = true
			State.gold_worth = 20
			
	if menu == "idle":
		if State.GOLD >= State.idle_upgrade1_cost:
			State.GOLD -= State.idle_upgrade1_cost
			if State.car_level < 3:
				State.car_level += 1
				
	if menu == "clicker":
		if State.GOLD >= State.clicker_upgrade1_cost:
			State.GOLD -= State.clicker_upgrade1_cost
			if State.damage_level < 3:
				State.damage_level += 1
				
	if menu == "fridge":
		if State.GOLD >= State.fridge_upgrade1_cost:
			State.GOLD -= State.fridge_upgrade1_cost
			if State.fridge_level < 3:
				State.fridge_level += 1
				
	if menu == "tv":
		if State.GOLD >= State.tv_upgrade1_cost:
			State.GOLD -= State.tv_upgrade1_cost
			if State.tv_level < 3:
				State.tv_level += 1
	
	if menu == "bed":
		if State.GOLD >= State.bed_upgrade1_cost:
			State.GOLD -= State.bed_upgrade1_cost
			if State.bed_level < 3:
				State.bed_level += 1
				



func _on_upgrade_2_pressed():
	if menu == "dodging":
		if State.GOLD >= State.dodge_upgrade2_cost:
			State.GOLD -= State.dodge_upgrade2_cost
			State.dodging_faster_familiar = true
			State.familiar_speed *= 2
			
			
	if menu == "idle":
		if State.GOLD >= State.idle_upgrade2_cost:
			State.GOLD -= State.idle_upgrade2_cost
			if State.pawn_shop_level < 3:
				State.pawn_shop_level += 1
				
	if menu == "clicker":
		if State.GOLD >= State.clicker_upgrade2_cost:
			State.GOLD -= State.clicker_upgrade2_cost
			State.clicker_more_val_enemy = true
			State.coin_value = 20
			
				
	if menu == "fridge":
		if State.GOLD >= State.fridge_upgrade2_cost:
			State.GOLD -= State.fridge_upgrade2_cost
			State.fridge_bigger = true
			State.max_hunger *= 2
			
				
	if menu == "tv":
		if State.GOLD >= State.tv_upgrade2_cost:
			State.GOLD -= State.tv_upgrade2_cost
			State.tv_bigger = true
			State.max_entertainment *= 2
			
	
	if menu == "bed":
		if State.GOLD >= State.bed_upgrade2_cost:
			State.GOLD -= State.bed_upgrade2_cost
			State.bed_bigger = true
			State.max_sleep *= 2
			



func _on_upgrade_3_pressed():
	if menu == "dodging":
		if State.GOLD >= State.dodge_upgrade3_cost:
			State.GOLD -= State.dodge_upgrade3_cost
			State.dodging_fewer_stakes = true
			State.spawn_rate *= 2
			
			
	if menu == "idle":
		if State.GOLD >= State.idle_upgrade3_cost:
			State.GOLD -= State.idle_upgrade3_cost
			State.idle_higher_chance = true
			State.chance_to_hit *= 2
			
				
	if menu == "clicker":
		if State.GOLD >= State.clicker_upgrade3_cost:
			State.GOLD -= State.clicker_upgrade3_cost
			State.clicker_crit_chance = true
			State.chance_to_crit *= 2
			
			
				
	if menu == "fridge":
		if State.GOLD >= State.fridge_upgrade3_cost:
			State.GOLD -= State.fridge_upgrade3_cost
			State.fridge_slower = true
			State.food_drain_rate -= 1
			
			
				
	if menu == "tv":
		if State.GOLD >= State.tv_upgrade3_cost:
			State.GOLD -= State.tv_upgrade3_cost
			State.tv_slower = true
			State.boredom_drain_rate -= 1
			
	
	if menu == "bed":
		if State.GOLD >= State.bed_upgrade3_cost:
			State.GOLD -= State.bed_upgrade3_cost
			State.bed_slower = true
			State.sleep_drain_rate -= 1
