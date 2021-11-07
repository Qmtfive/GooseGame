extends Area2D

# Declare member variables here.
export var speed = 30
export var xvel = 0
export var yvel = 0
var yveltempstore = 0

func newStopTimer():
	var timeTillStop = Timer.new()
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	add_child(timeTillStop)
	timeTillStop.wait_time = rand.randi_range(3, 5)
	timeTillStop.connect("timeout", self, "stop")
	timeTillStop.start()
	return timeTillStop

func newWalkTimer():
	var timeTillWalkAgain = Timer.new()
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	add_child(timeTillWalkAgain)
	timeTillWalkAgain.wait_time = rand.randi_range(1, 3)
	timeTillWalkAgain.connect("timeout", self, "changeDirection")
	timeTillWalkAgain.start()
	return timeTillWalkAgain

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	xvel = rand.randf_range(-.5,.5)
	var timeTillStop = Timer.new()
	newStopTimer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	newWalkTimer()

func changeDirection():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	xvel = rand.randf_range(-.5,.5)
	yvel = yveltempstore
	newStopTimer()
