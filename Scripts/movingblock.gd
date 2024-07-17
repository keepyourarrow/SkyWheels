extends CharacterBody2D

@export var move_direction = Vector2.UP
@export var second_position = Vector2.ZERO
@export var move_speed = 40
@export var wait_time = 1
@onready var timer = $waitTimer

var pos
var moves_up_and_down
var targetPos
var init_position
var speed
var moving_forth = true
var timer_started = false

func _ready():
	
	speed = move_speed
	if move_direction == Vector2.RIGHT:
		init_position =-global_position.x
		targetPos = -second_position.x
		moves_up_and_down = false
	elif move_direction == Vector2.UP:
		init_position = global_position.y
		targetPos = second_position.y
		moves_up_and_down = true

func _process(_delta):
	if moves_up_and_down:
		pos = position.y
	else:
		pos = -position.x
	
	if moving_forth:
		velocity = move_direction * speed
		if pos <= targetPos and not timer_started:
			speed = 0
			timer.start(wait_time)
			timer_started = true
	else:
		velocity = -move_direction * speed
		if pos >= init_position and not timer_started:
			speed = 0
			timer.start(wait_time)
			timer_started = true
	
	move_and_slide()

func _on_wait_timer_timeout():
	if moving_forth:
		moving_forth = false
	else:
		moving_forth = true
	speed = move_speed
	timer_started = false
