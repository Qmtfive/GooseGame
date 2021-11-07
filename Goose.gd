extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 50
export var xvel = 0
export var yvel = 0
var yveltempstore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	xvel = rand.randf_range(-.75,.75)
	var velocity = Vector2(xvel, yvel)
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$GooseAnimation.play()
	else:
		$GooseAnimation.stop()
	position += velocity * delta

func stop():
	yveltempstore = yvel
	yvel = 0
	xvel = 0

func changeDirection():
	yvel = yveltempstore
