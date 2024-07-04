extends CharacterBody2D

@export var move_direction = Vector2.UP
@export var second_position = Vector2.ZERO
@export var move_speed = 40
@export var wait_time = 1
@onready var timer = $waitTimer

var init_position
var speed
var distance_reached
var timer_started = false

func _ready():
	init_position = global_position
	speed = move_speed
	print(init_position)

func _process(_delta):
	velocity = move_direction * speed
	move_and_slide()
	
	if position <= second_position and not timer_started or position >= init_position and not timer_started:
		speed = 0
		timer.start(wait_time)
		timer_started = true

func _on_wait_timer_timeout():
	init_position = global_position
	speed = -move_speed
	print(init_position)
	timer_started = false
