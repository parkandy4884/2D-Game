extends Node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(_event):
	if Input.is_action_just_pressed("Menu"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu == null:
			get_tree().quit()
		else:
			if menu.visible:
				get_tree().paused = false
				menu.hide()
			else:
				get_tree().paused = true
				menu.show()
