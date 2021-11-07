extends Node2D

signal gameTimeStarted

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Frame.play()
	$StartMuzic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func ShowStuff():
	$Frame.show()
	$StartMuzic.play()
	$StartButton.show()

func _on_StartButton_pressed():
	$StartButton.hide()
	$Frame.hide()
	$StartMuzic.stop()
	$StartTimer.start()


func _on_StartTimer_timeout():
	emit_signal("gameTimeStarted")
