extends RigidBody2D

@onready var Wheel1 = $"PinJoint2D/Wheel-1"
@onready var Wheel2= $"PinJoint2D2/Wheel-2"
@onready var F_cast = $PinJoint2D/FrontRayCast
@onready var R_cast = $PinJoint2D2/RearRaycast
@onready var resetButton = $Camera2D/Resetbutton

@export var force = 100
const MAX_SPEED = Vector2(350,0)
const ROTATION_MODIFIER = 5;

func _physics_process(_delta):
	handle_movement()
	handle_camera_zoom()
	$Camera2D.zoom = Vector2(4,4)

func handle_camera_zoom():
	if Input.is_action_pressed("z"):
		$Camera2D.zoom = Vector2(2,2)
	if Input.is_action_pressed("x"):
		$Camera2D.zoom = Vector2(1,1)
	
	
func handle_movement():
	var forceVec = Vector2(force-rotation * ROTATION_MODIFIER, 0).rotated(rotation)
	
	var is_on_ground = F_cast.is_colliding() or F_cast.is_colliding()
	var is_right_pressed = Input.is_action_pressed("ui_right") or Input.is_action_pressed("R1")
	var is_left_pressed = Input.is_action_pressed("ui_left") or Input.is_action_pressed("L1")
	
	if is_on_ground:
		print("On Ground") 
		if linear_velocity.rotated(rotation) <= MAX_SPEED:
			if is_right_pressed:
				apply_central_impulse(forceVec)
		if linear_velocity.rotated(rotation) >= -MAX_SPEED:
			if is_left_pressed:
				apply_central_impulse(-forceVec)
				
		update_rear_lights(linear_velocity.rotated(rotation))			
	else:
		print("in air")
		

func update_rear_lights(velocity):
	const REAR_LIGHT_THRESHOLD = 1
	const BACK_LIGHT_THRESHOLD = -10
	
	$rearLight.enabled = velocity.x > REAR_LIGHT_THRESHOLD
	$backingLight.visible = velocity.x < BACK_LIGHT_THRESHOLD
