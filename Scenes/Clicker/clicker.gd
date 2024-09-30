extends Node2D
var npc_current_hp = 0
var npc_max_hp = 100 
var particles = load("res://Scenes/Clicker/Particles/particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	npc_max_hp = npc_max_hp * State.current_level
	npc_current_hp = npc_max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if npc_current_hp <= 0:
		do_damage()
	$Label.text = str(npc_current_hp)
	$Label2.text = str(npc_max_hp)

func healthbar_update():
	pass



func do_damage():
	if npc_current_hp > 0:
		var crit_chance = randi_range(1,5)
		if crit_chance == 3:
			npc_current_hp -= 50 * State.damage_level * 2
		else:
			npc_current_hp -= 50 * State.damage_level
	else:
		State.current_level += 1
		npc_max_hp = floor(npc_max_hp * 1.15)
		npc_current_hp = npc_max_hp
	healthbar_update()



func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if Input.is_action_just_pressed("mouse_click"):
		spawn_particles(event.position)
		$AnimatedSprite2D.play("flinch")
		do_damage()
		
	
func spawn_particles(position: Vector2):
	var particle_instance = particles.instantiate()  # Create particle instance
	particle_instance.global_position = position  # Set particle position to mouse click position
	add_child(particle_instance)  # Add the particle instance to the scene tree


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "flinch":
		$AnimatedSprite2D.play("idle")
		
