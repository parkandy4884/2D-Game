extends Control

func _on_button_pressed():
	var _scene = get_tree().change_scene_to_file("res://Game.tscn")


func _on_button_2_pressed():
	get_tree().quit()