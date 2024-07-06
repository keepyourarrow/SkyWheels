extends Node2D

@onready var cloud1 = $Clouds/cloud1
@onready var horiScreenSize = DisplayServer.screen_get_size().x

@export var cloudSPEEDmin = 75
@export var cloudSPEEDmax = 150

func _process(delta):
	pass
	#For each cloud, assign a random speed like this:
	# cloud1.position += randi_range(cloudSPEEDmin, cloudSPEEDmax) * delta
	#reset their position.x to somewhere like -300, when they pass the screen (horiScreenSize)
	# but this should be for multiple clouds
	
