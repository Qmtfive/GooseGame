extends Node


# Declare member variables here. Examples:
export var geeseOnScreen = 0
export var score = 0
var nextWave = 3
var gameover = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start():
	gameover = false
	spawnWave()

func reset():
	gameover = true
	geeseOnScreen = 0
	score = 0
	$Score.text = "SCORE: 0"
	nextWave = 3
	$theyCome.stop()
	$tillNextWave.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnWave():
	geeseOnScreen = 0
	for i in range(0, nextWave):
		var mothergoose = load("res://Goose.tscn")
		var goose = mothergoose.instance()
		var rand = RandomNumberGenerator.new()
		rand.randomize()
		goose.position.x = rand.randf_range(0, 480)
		rand.randomize()
		var boolean = rand.randi_range(0, 1)
		if boolean == 0:
			goose.position.y = 0
			goose.yvel = 1
		elif boolean == 1:
			goose.position.y = 480
			goose.yvel = -1
		add_child(goose)
		goose.connect("nomoregoose", self, "noMoreGoose")
		goose.connect("score", self, "score")
		geeseOnScreen += 1

func noMoreGoose():
	if gameover != true:
		geeseOnScreen -= 1
		if geeseOnScreen <= 0:
			nextWave += 3
			$tillNextWave.start()
			$theyCome.play()

func score():
	score += 1
	$Score.text = "SCORE: " + str(score)
	$Score.show()

func _on_tillNextWave_timeout():
	$theyCome.stop()
	spawnWave()
