class_name Car
extends RigidBody2D

@export var power: int
@export var max_speed: int

@onready var Rjoint = $PinJoint2D
@onready var Fjoint = $PinJoint2D2
@onready var Wheel1 = $"PinJoint2D/Wheel"
@onready var Wheel2 = $"PinJoint2D2/Wheel"
@onready var F_cast = $"PinJoint2D/RayCast"
@onready var R_cast = $"PinJoint2D2/Raycast"
@onready var rear_light: PointLight2D = $RearLight
@onready var backing_light: Sprite2D = $BackingLight

const ROTATION_MODIFIER = 5;
const BODY_TORQUE = 8000

func _physics_process(_delta):
	handle_movement()
	
func handle_movement():
	var current_velocity = linear_velocity.rotated(rotation)
	var forceVec = Vector2(power-rotation * ROTATION_MODIFIER, 0).rotated(rotation)
	
	var is_on_ground = F_cast.is_colliding() or F_cast.is_colliding()
	var is_right_pressed = Input.is_action_pressed("ui_right") or Input.is_action_pressed("R1")
	var is_left_pressed = Input.is_action_pressed("ui_left") or Input.is_action_pressed("L1")
	
	if is_on_ground:
		if current_velocity.x <= max_speed:
			if is_right_pressed:
				apply_central_impulse(forceVec)
				apply_torque(-BODY_TORQUE)
		if current_velocity.x >= -max_speed:
			if is_left_pressed:
				apply_central_impulse(-forceVec)
				apply_torque(BODY_TORQUE)
		update_rear_lights(current_velocity)
	else:
		if is_right_pressed:
				apply_torque(-BODY_TORQUE)
		if is_left_pressed:
				apply_torque(BODY_TORQUE)


func update_rear_lights(velocity):
	const REAR_LIGHT_THRESHOLD = 1
	const BACK_LIGHT_THRESHOLD = -10
	
	rear_light.enabled = velocity.x > REAR_LIGHT_THRESHOLD
	backing_light.visible = velocity.x < BACK_LIGHT_THRESHOLD

func show_car():
	visible = true

func hide_car():
	visible = false
	
