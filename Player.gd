extends Area2D

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
onready var anims = $PlayerAnims
var attackdir = 0 # 0 to 3 in clockwise order (left up right, down)
var attacking = false

func _ready():
	anims.play("WalkSide")
	anims.stop()
	screen_size = get_viewport_rect().size

func _process(delta):
	if attacking != true:
		var velocity = Vector2()  # The player's movement vector.
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
			attackdir = 0
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			attackdir = 2
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
			attackdir = 3
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
			attackdir = 1
		if Input.is_action_pressed("ui_select"):
			anims.flip_h = false
			attacking = true
			if attackdir == 0:
				$AttackDetect/AttackLeft.disabled = false
			elif attackdir == 1:
				anims.rotation = deg2rad(90)
				$AttackDetect/AttackUp.disabled = false
			elif attackdir == 2:
				anims.rotation = deg2rad(180)
				$AttackDetect/AttackRight.disabled = false
			elif attackdir == 3:
				anims.rotation = deg2rad(270)
				$AttackDetect/AttackDown.disabled = false
			anims.play("Attack")
			$AttackDetect/AttackTimer.start()
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		if velocity.y > 0:
			anims.play("WalkUp")
		elif velocity.y < 0:
			anims.play("WalkDown")
		elif velocity.x != 0:
			anims.play("WalkSide")
			anims.flip_h = velocity.x > 0
		else:
			anims.stop()
	
		position += velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)

func _on_AttackTimer_timeout():
	attacking = false
	anims.rotation = deg2rad(0)
	anims.stop()
	$AttackDetect/AttackTimer.stop()
	$AttackDetect/AttackLeft.disabled = true
	$AttackDetect/AttackUp.disabled = true
	$AttackDetect/AttackRight.disabled = true
	$AttackDetect/AttackDown.disabled = true
