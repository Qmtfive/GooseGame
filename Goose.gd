extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 300


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2(5, 6)  # The player's movement vector.
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$GooseAnimation.play()
	else:
		$GooseAnimation.stop()
	position += velocity * delta
