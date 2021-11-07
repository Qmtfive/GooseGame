extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 10):
		var mothergoose = load("res://Goose.tscn")
		var goose = mothergoose.instance()
		var rand = RandomNumberGenerator.new()
		rand.randomize()
		goose.position.x = rand.randf_range(0, 475)
		rand.randomize()
		var boolean = rand.randi_range(0, 1)
		if boolean == 0:
			goose.position.y = -10
			goose.yvel = 1
		elif boolean == 1:
			goose.position.y = 500
			goose.yvel = -1
		add_child(goose)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

