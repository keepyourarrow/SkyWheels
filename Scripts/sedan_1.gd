extends RigidBody2D

@onready var Wheel1 = $"PinJoint2D/Wheel-1"
@onready var Wheel2= $"PinJoint2D2/Wheel-2"
@onready var F_cast = $PinJoint2D/FrontRayCast
@onready var R_cast = $PinJoint2D2/RearRaycast
@onready var resetButton = $Camera2D/Resetbutton


@export var force = 100
var MAX_SPEED = Vector2(350,0)

func _process(_delta):
	
	var forceVec = Vector2(force-rotation*5,0).rotated(rotation)
	
	if F_cast.is_colliding() or F_cast.is_colliding():
		print("On Ground") 
		if linear_velocity.rotated(rotation) <= MAX_SPEED:
			if Input.is_action_pressed("ui_right") or Input.is_action_pressed("R1"):
				apply_central_impulse(forceVec)
				
				#Rear Light activation-----------------
				if linear_velocity.rotated(rotation).x <0:
					$rearLight.enabled = true
					$backingLight.visible = false
				else:
					$rearLight.enabled = false
				#--------------------------------------
		if linear_velocity.rotated(rotation) >= -MAX_SPEED:
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("L1"):
				apply_central_impulse(-forceVec)
				
				#Rear Light activation--------------------
				if linear_velocity.rotated(rotation).x >0:
					$rearLight.enabled = true
				else:
					$rearLight.enabled = false
					$backingLight.visible = true
				#-----------------------------------------
	else:
		print("in air")
	
	if Input.is_action_pressed("z"):
		$Camera2D.zoom = Vector2(2,2)
	if Input.is_action_pressed("x"):
		$Camera2D.zoom = Vector2(1,1)
