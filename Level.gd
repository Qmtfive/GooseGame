extends Node2D


export (PackedScene) var Pedestrian

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var starter = null


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var startscene = load("res://Start.tscn")
	var start = startscene.instance()
	add_child(start)
	starter = start
	starter.connect("gameTimeStarted", self, "start_game")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_game():
	$PedSpawnTimer.start()
	$GooseSpawner.start()

func game_over():
	$PedSpawnTimer.stop()
	get_tree().call_group("geese", "queue_free")
	get_tree().call_group("pedestrians", "queue_free")
	$GooseSpawner.reset()
	$VE_LOST.show()
	$LossTimer.start()

func stop_chase():
	get_tree().call_group("geese", "clear_victim")

func _on_PedSpawnTimer_timeout():
	var tospawn = randi() % 3 # Determine if ped should spawn
	if tospawn == 0:
		tospawn = randi() % 2 # Determine which side to spawn ped on
		var ped = Pedestrian.instance()
		add_child(ped)
		ped.connect("pedHit", self, "game_over")
		ped.connect("pedDespawn", self, "stop_chase")
		if tospawn == 0:
			ped.position = $PedSpawnLeft.transform.get_origin()
			ped.position.y = ped.position.y + ((randi()%40) - 20)
			ped.walkLeft()
			ped.linear_velocity = Vector2(rand_range(ped.min_speed, ped.med_speed), 0)
		else:
			ped.position = $PedSpawnRight.transform.get_origin()
			ped.position.y = ped.position.y + ((randi()%40) - 20)
			ped.rotation = deg2rad(0)
			ped.linear_velocity = Vector2(-(rand_range(ped.min_speed, ped.med_speed)), 0)
	

func _on_LossTimer_timeout():
	$VE_LOST.hide()
	starter.ShowStuff()
