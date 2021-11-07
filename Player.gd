extends Area2D

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
onready var anims = $PlayerAnims

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		anims.play("WalkSide")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		anims.play("WalkSide")
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		anims.play("WalkDown")
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		anims.play("WalkUp")
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		anims.play()
	else:
		anims.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	if velocity.x != 0:
		anims.flip_h = velocity.x > 0
