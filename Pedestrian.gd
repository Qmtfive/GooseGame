extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var min_speed = 10  # Lower Range for slow walk
export var med_speed = 20  # Upper Range for slow, Lower Range for fast
export var max_speed = 30  # Maximum speed for Fast Walk
export var chased = false; # True if a goose has targeted this ped

signal pedHit
signal pedDespawn

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = "WalkSlow"

func walkLeft():
	$AnimatedSprite.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("pedDespawn")
	queue_free()


#func _on_Pedestrian_body_entered(body):
#	print("Entered Ped Body:")
#	print(body)


func _on_Pedestrian_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("Entered Ped Body:")
	print(body)


func _on_ChaseSphere_area_entered(area):
	chased = true
	$AnimatedSprite.animation = "WalkFast"
	if $".".linear_velocity.x <= 0:
		$".".linear_velocity = Vector2(-(rand_range(med_speed, max_speed)), 0)
	else:
		$".".linear_velocity = Vector2(rand_range(med_speed, max_speed), 0)


func _on_DeathBox_area_entered(area):
	emit_signal("pedHit")
