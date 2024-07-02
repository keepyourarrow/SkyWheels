extends RigidBody2D

@onready var Rjoint = $PinJoint2D
@onready var Fjoint = $PinJoint2D2
@onready var Wheel1 = $"PinJoint2D/Wheel-1"
@onready var Wheel2= $"PinJoint2D2/Wheel-2"
@onready var F_cast = $PinJoint2D/FrontRayCast
@onready var R_cast = $PinJoint2D2/RearRaycast
@onready var resetButton = $Camera2D/Resetbutton

@export var force = 100
var MAX_SPEED = 350
const ROTATION_MODIFIER = 5;
const bodytorque = 8000
var current_velocity

var carList = [
{'Name': 'sedan1','sprite': 'Carbodies/sedan1', 'Type': 'sedan','power':70,'maxSpeed':350,'FwheelPos':29,'RwheelPos':-23},
{'Name': 'sport1','sprite': 'Carbodies/sport1','Type': 'sport','power':120,'maxSpeed':480,'FwheelPos':29,'RwheelPos':-33},
{'Name': 'pckup1','sprite': 'Carbodies/pckup1','Type': 'pickup','power':100,'maxSpeed':370,'FwheelPos':29,'RwheelPos':-31},
{'Name': 'htchbck1','sprite': 'Carbodies/Htchbck1','Type': 'hatchback','power':90,'maxSpeed':375,'FwheelPos':29,'RwheelPos':-25}
]

func _physics_process(_delta):
	current_velocity = linear_velocity.rotated(rotation)
	handle_movement()
	handle_camera_zoom()
	carSelector()

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
		if current_velocity.x <= MAX_SPEED:
			if is_right_pressed:
				apply_central_impulse(forceVec)
				apply_torque(-bodytorque)
		if current_velocity.x >= -MAX_SPEED:
			if is_left_pressed:
				apply_central_impulse(-forceVec)
				apply_torque(bodytorque)
		update_rear_lights(current_velocity)
	else:
		if is_right_pressed:
				apply_torque(-bodytorque)
		if is_left_pressed:
				apply_torque(bodytorque)
	


func update_rear_lights(velocity):
	const REAR_LIGHT_THRESHOLD = 1
	const BACK_LIGHT_THRESHOLD = -10
	
	$rearLight.enabled = velocity.x > REAR_LIGHT_THRESHOLD
	$backingLight.visible = velocity.x < BACK_LIGHT_THRESHOLD

func carSelector():
	if Input.is_action_just_pressed("1"):
		_carSpriteLoader(0)
		force = carList[0]['power']
		MAX_SPEED = carList[0]['maxSpeed']
		Rjoint.position.x = carList[0]['RwheelPos']
	elif Input.is_action_just_pressed("2"):
		_carSpriteLoader(1)
		get_node(carList[1]['sprite']).visible = true
		force = carList[1]['power']
		MAX_SPEED = carList[1]['maxSpeed']
		Rjoint.position.x = carList[2]['RwheelPos']
	elif Input.is_action_just_pressed("3"):
		_carSpriteLoader(2)
		force = carList[2]['power']
		MAX_SPEED = carList[2]['maxSpeed']
		Rjoint.position.x = carList[2]['RwheelPos']
	elif Input.is_action_just_pressed("4"):
		_carSpriteLoader(3)
		force = carList[3]['power']
		MAX_SPEED = carList[3]['maxSpeed']
		Rjoint.position.x = carList[3]['RwheelPos']

func _carSpriteLoader(selected_car):
	for i in range(len(carList)):
		if i == selected_car:
			get_node(carList[i]['sprite']).visible = true
		else:
			get_node(carList[i]['sprite']).visible = false
