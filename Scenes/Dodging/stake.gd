extends Node2D

# Speed of the falling object
var speed = 200.0

func _process(delta):
	# Move the object down
	position.y += speed * delta

	# Free the object if it goes past the bottom of the screen
	if position.y > get_viewport().size.y:
		queue_free()


func _on_area_body_entered(body):
	if body.name == "familiar":
		State.game_running = false
