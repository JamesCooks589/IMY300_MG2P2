extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
