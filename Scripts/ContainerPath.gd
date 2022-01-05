extends Path2D

export (PackedScene) var container_spawn_scene

func _unhandled_input(event):
	#print("click")
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed == true:
		var container_spawn_instance = container_spawn_scene.instance() # object gets instantiated
		add_child(container_spawn_instance)
		print("container created")
