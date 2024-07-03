class_name Player
extends Node2D

@onready var camera = $Camera2D

var cars: Array[Car] = []
var car_scene_paths = []
var current_car_index = 0

func _ready():
	create_and_add_cars()
	add_first_car()

func create_and_add_cars():
	var car_scenes = [
		preload("res://Scenes/cars/sedan.tscn"),
		preload("res://Scenes/cars/sport.tscn"),
		preload("res://Scenes/cars/pick_up_truck.tscn"),
		preload("res://Scenes/cars/hatchback.tscn")
	]

	for car_scene in car_scenes:
		var car_instance = car_scene.instantiate()
		cars.append(car_instance)
		car_scene_paths.append(car_scene.resource_path)

func add_first_car():
	add_child(cars[0])
	cars[0].show_car()

func _physics_process(_delta):
	handle_camera_zoom()
	handle_car_switching()
	update_position()

func update_position():
	camera.global_position = cars[current_car_index].global_position
	
func handle_car_switching():
	if Input.is_action_just_pressed("1"):
		switch_car(0)
	elif Input.is_action_just_pressed("2"):
		switch_car(1)
	elif Input.is_action_just_pressed("3"):
		switch_car(2)
	elif Input.is_action_just_pressed("4"):
		switch_car(3)
		
func handle_camera_zoom():
	if Input.is_action_pressed("z"):
		camera.zoom = Vector2(2, 2)
	if Input.is_action_pressed("x"):
		camera.zoom = Vector2(1, 1)
	
	
func switch_car(index):
	if index == current_car_index:
		return
	
	global_position = cars[current_car_index].global_position 
	remove_child(cars[current_car_index])
	# reinstantiate the scene so the position is refreshed
	cars[current_car_index] = load(car_scene_paths[current_car_index]).instantiate()
	current_car_index = index
	add_child(cars[current_car_index])
	cars[current_car_index].global_position = global_position
	
	
