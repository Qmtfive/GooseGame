extends Node


# Declare member variables here. Examples:
export var geeseOnScreen = 0
export var score = 0
var nextWave = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnWave():
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
