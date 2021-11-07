extends Area2D

# Declare member variables here.
export var chaseSpeed = 50
export var speed = 30
export var xvel = 0
export var yvel = 0
var yveltempstore = 0
var timeTillStop = null
var timeTillWalkAgain = null
var victim = null #The Pedestrian the Goose is currently chasing

signal hit(victim)

func newStopTimer():
	timeTillStop = Timer.new()
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	add_child(timeTillStop)
	timeTillStop.wait_time = rand.randi_range(3, 5)
	timeTillStop.connect("timeout", self, "stop")
	timeTillStop.start()
	return timeTillStop

func newWalkTimer():
	timeTillWalkAgain = Timer.new()
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
	timeTillStop = newStopTimer()

func chase_victim():
	var xdir = victim.position.x - $".".position.x
	var ydir = victim.position.y - $".".position.y
	var velocity = Vector2()
	velocity.x = xdir
	velocity.y = ydir
	velocity = velocity.normalized() * chaseSpeed
	return velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if victim != null:
		var vel = chase_victim()
		xvel = vel.x
		yvel = vel.y
	var velocity = Vector2(xvel, yvel)
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$GooseAnimation.play()
	else:
		$GooseAnimation.stop()
	position += velocity * delta

func stop():
	timeTillStop.stop()
	yveltempstore = yvel
	yvel = 0
	xvel = 0
	timeTillWalkAgain = newWalkTimer()

func changeDirection():
	timeTillWalkAgain.stop()
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	xvel = rand.randf_range(-.5,.5)
	yvel = yveltempstore
	timeTillStop = newStopTimer()

func _on_Visibility_screen_exited():
	queue_free()

func _on_Goose_body_entered(body):
	victim = null
	#emit_signal("hit", body)
	#print("Entered Ped Body:")
	#print(body.position)

func _on_Goose_area_entered(area):
	if victim == null:
		timeTillStop.stop()
		timeTillWalkAgain.stop()
		yveltempstore = yvel
		if area.get_parent() != null:
			victim = area.get_parent()
		else:
			victim = area
		var vel = chase_victim()
		xvel = vel.x
		yvel = vel.y

func clear_victim():
	victim = null
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	xvel = rand.randf_range(-.5,.5)
	timeTillStop = newStopTimer()
