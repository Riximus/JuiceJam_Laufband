extends Sprite

signal picked_up

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == true:
		emit_signal("picked_up")
