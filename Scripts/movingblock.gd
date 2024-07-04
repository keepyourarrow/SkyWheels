extends CharacterBody2D

@export var move_direction = Vector2.UP
@export var second_position = Vector2.ZERO
@export var move_speed = 40
@export var wait_time = 1
@onready var timer = $waitTimer

var init_position
var speed
var moving_up = true
var timer_started = false

func _ready():
	init_position = global_position
	speed = move_speed

func _process(_delta):
	if moving_up:
		velocity = move_direction * speed
		if position.y <= second_position.y and not timer_started:
				speed = 0
				timer.start(wait_time)
				timer_started = true
	else:
		velocity = -move_direction * speed
		if position.y >= init_position.y and not timer_started:
			speed = 0
			timer.start(wait_time)
			timer_started = true
	
	move_and_slide()

func _on_wait_timer_timeout():
	if moving_up:
		moving_up = false
	else:
		moving_up = true
	speed = move_speed
	timer_started = false
