extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rand = RandomNumberGenerator.new()
	var mothergoose = load("res://Goose.tscn")
	for i in range(0,10):
		var goose = mothergoose.instance()
		rand.randomize()
		var x = rand.randf_range(0,100)
		rand.randomize()
		var y = rand.randf_range(0,100)
		goose.position.y = y
		goose.position.x = x
		add_child(goose)
