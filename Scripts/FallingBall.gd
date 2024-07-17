extends RigidBody2D

@export var end_position = 0

var init_position
var falling = true

func _ready():
	mass = 0.2
	init_position = global_position

func _physics_process(_delta):
	pass
	#NEEDS SOME WORK FOR RESPAWNING

