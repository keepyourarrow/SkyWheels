extends StaticBody2D

func _on_area_2d_area_entered(area):
	if area.name == "PlayerArea2d":
		switch_level()

func switch_level():
	var current_level = str(get_tree().current_scene.name)
	var next_level
	
	for c in current_level:
		if c <= "9" and c >= "0":
			var num = int(c) + 1
			num = str(num)
			next_level = "res://Scenes/levels/level_" + num + ".tscn"
			get_tree().change_scene_to_file(next_level)
	
	
