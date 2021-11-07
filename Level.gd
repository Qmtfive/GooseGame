extends Node2D


export (PackedScene) var Pedestrian

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PedSpawnTimer_timeout():
	var tospawn = randi() % 3 # Determine if ped should spawn
	if tospawn == 0:
		tospawn = randi() % 2 # Determine which side to spawn ped on
		var ped = Pedestrian.instance()
		add_child(ped)
		if tospawn == 0:
			ped.position = $PedSpawnLeft.transform.get_origin()
			ped.position.y = ped.position.y + ((randi()%40) - 20)
			ped.rotation = deg2rad(180)
			ped.linear_velocity = Vector2(rand_range(ped.min_speed, ped.med_speed), 0)
		else:
			ped.position = $PedSpawnRight.transform.get_origin()
			ped.position.y = ped.position.y + ((randi()%40) - 20)
			ped.rotation = deg2rad(0)
			ped.linear_velocity = Vector2(-(rand_range(ped.min_speed, ped.med_speed)), 0)
	
	
