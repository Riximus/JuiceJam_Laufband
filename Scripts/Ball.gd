extends Sprite

signal picked_up

var boolean : bool

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed == true:
		emit_signal("picked_up")
