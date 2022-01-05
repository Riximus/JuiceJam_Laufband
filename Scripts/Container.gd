extends Sprite

export (PackedScene) var ball_scene

signal placing_object
signal has_object

func _ready():
	get_tree().root.get_child(0).get_node("Player").connect("placed_object", self, "_placed_object")

func _on_ContainerArea_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == true:
		emit_signal("placing_object")

func _on_ContainerArea_area_entered(area):
	#print(area.name)
	if area.name == "PickedObjectArea" and has_node("Ball"):
		#print('area.name == "PickedObjectArea" and has_node("Ball")')
		emit_signal("has_object", true)
	elif area.name == "PickedObjectArea" and !has_node("Ball"):
		emit_signal("has_object", false)

func _placed_object():
	var ball_instance = ball_scene.instance() # object gets instantiated
	add_child(ball_instance)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
