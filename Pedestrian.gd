extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var min_speed = 50  # Lower Range for slow walk
export var med_speed = 75  # Upper Range for slow, Lower Range for fast
export var max_speed = 100  # Maximum speed for Fast Walk
export var chased = false; # True if a goose has targeted this ped


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = "WalkSlow"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
