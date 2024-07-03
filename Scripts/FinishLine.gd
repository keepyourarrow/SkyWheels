extends StaticBody2D

func _on_area_2d_area_entered(area):
	if area.name == "PlayerArea2d":
		switch_level()

func switch_level():
	var current_level = get_tree().current_scene.name
	var next_level
	
	for c in "level_1":
		if c <= "9" and c >= "0":
			var num = int(c) + 1
			num = str(num)
			next_level = "res://Scenes/level_" + num + ".tscn"
	
	get_tree().change_scene_to_file(next_level)
