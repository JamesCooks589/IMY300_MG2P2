extends CharacterBody2D


func _physics_process(delta):

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * State.familiar_speed
	else:
		velocity.x = move_toward(velocity.x, 0, State.familiar_speed)
		
	if Input.is_action_just_pressed("left"):
		$AnimatedSprite2D.play("left")
	elif Input.is_action_just_pressed("right"):
		$AnimatedSprite2D.play("right")
	
	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		$AnimatedSprite2D.play("default")

	move_and_slide()
