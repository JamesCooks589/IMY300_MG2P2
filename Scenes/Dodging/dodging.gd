extends Node2D

# Variables
var object_speed = 200.0
var score = 0


# Preload falling object and coin scenes
@export var falling_object_scene: PackedScene
@export var coin_scene: PackedScene

# Timer for spawning objects and coins
var spawn_timer = 0.0
var coin_spawn_timer = 0.0

# Nodes
@onready var score_label = $ScoreLabel
@onready var gold_label = $GoldLabel

func _ready():
	# Reset score and speed when game starts
	score = 0
	object_speed = 200.0
	State.game_running = true
	get_tree().paused = false
	State.inMiniGame = true
	if !State.retryClicked:
		State.hasDrainedInMiniGame = false
	
	gold_label.text = "Gold: %d" % State.GOLD


func _process(delta):
	# Check if the game is running
	if State.game_running == false:
		# Pause the game
		get_tree().paused = true
		show_game_over_screen()
		return
	
	# Update score based on how long the player survives
	score += int(delta * 100)
	score_label.text = "Score: %d" % score

	# Increase object speed based on score
	object_speed = 200.0 + score * 0.1

	# Handle object spawning
	spawn_timer += delta
	coin_spawn_timer += delta

	if spawn_timer >= State.spawn_rate:
		spawn_falling_object()
		spawn_timer = 0.0

	# Spawn a coin randomly every 5-10 seconds
	if coin_spawn_timer >= randi_range(5, State.gold_max_time_to_spawn):
		spawn_coin()
		coin_spawn_timer = 0.0
		
	gold_label.text = "Gold: %d" % State.GOLD

func spawn_falling_object():
	# Instance the falling object
	var falling_object = falling_object_scene.instantiate()
	# Set the position randomly at the top of the screen
	falling_object.position = Vector2(randi_range(0, get_viewport().size.x), -100)
	# Set the object speed (this will be handled in the object's script)
	falling_object.speed = object_speed
	# Add to the scene
	add_child(falling_object)

func spawn_coin():
	# Instance the coin
	var coin = coin_scene.instantiate()
	# Set the position randomly at the top of the screen
	coin.position = Vector2(randi_range(0, get_viewport().size.x), -100)
	# Set coin speed
	coin.speed = object_speed
	add_child(coin)

# Function to handle collecting coins
func collect_coin():
	State.GOLD += State.gold_worth

# Function to display the game over screen (or reset option)
func show_game_over_screen():
	var game_over_menu = $GameOverMenu
	game_over_menu.visible = true

# Function to reset the game
func reset_game():
	get_tree().paused = false  # Unpause the game
	get_tree().reload_current_scene()  # Reload the current scene

func _on_play_again_pressed():
	$click.play()
	State.retryClicked = true
	reset_game()


func _on_play_again_2_pressed():
	$click.play()
	get_tree().paused = false
	State.retryClicked = false
	get_tree().change_scene_to_file("res://Scenes/Home/home.tscn")
