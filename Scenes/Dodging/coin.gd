extends Node2D

# Speed of the falling coin
var speed = 200.0

func _process(delta):
	# Move the coin down
	position.y += speed * delta

	# Free the coin if it goes past the bottom of the screen
	if position.y > get_viewport().size.y:
		queue_free()


func _on_hitbox_body_entered(body):
	if body.name == "familiar":
		# Call the function from the main scene to update gold
		get_parent().collect_coin()
		queue_free()
