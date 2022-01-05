extends KinematicBody2D

export (PackedScene) var ball_scene

export var speed : float = 500

signal placed_object

var direction : Vector2
var screenSize : Vector2 = Vector2.ZERO

var interactArea : bool
var hasObject : bool
var pickedObjectArea : bool

#onready var ball_scene = preload("res://Ball.tscn")

func _ready():
	#connect to signals
	get_parent().get_node("Ball").connect("picked_up", self, "_picked_up_ball")

	
	screenSize = get_viewport_rect().size
	print("Screen Size = ", screenSize)

func _process(_delta: float):
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)
	if get_parent().get_node("ContainerPath").has_node("ContainerSpawn"):
		get_parent().get_node("ContainerPath/ContainerSpawn/Container").connect("placing_object", self, "_placing_in_container")
		get_parent().get_node("ContainerPath/ContainerSpawn/Container").connect("has_object", self, "_has_object")
	else:
		print("there is no container")

func _physics_process(_delta: float):
	player_move()

func player_move():
	direction = get_direction()
	if direction.length() > 1.0: #for vertical movement
		direction = direction.normalized()
	look_at(get_global_mouse_position())
	move_and_slide(speed * direction)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
### SIGNALS ###
func _picked_up_ball():
	var ball_instance = ball_scene.instance() # object gets instantiated
	if interactArea:
		if get_node("PickedObject").has_node("Ball"):
			print("has ball")
		else:
			get_node("PickedObject").add_child(ball_instance)
	else:
		print("too far away")

func _placing_in_container():
	if get_node("PickedObject").has_node("Ball") and pickedObjectArea and !hasObject:
		get_node("PickedObject/Ball").queue_free()
		emit_signal("placed_object") # placed object signal
		print("placed the object")
	elif get_node("PickedObject").has_node("Ball") and pickedObjectArea and hasObject:
		print("already occupied")
	elif !get_node("PickedObject").has_node("Ball") and pickedObjectArea:
		print("has no ball to place")
	else:
		print("get a ball")
		
# OLD ROUND AREA AROUND PLAYER
#func _on_InteractingArea_area_entered(area):
#	interactArea = true
#	get_node("PickedObject/PickedObjectArea").set_deferred("Monitorable", true)
#	#print(area.name)	
#
#func _on_InteractingArea_exited(area):
#	interactArea = false
#	get_node("PickedObject/PickedObjectArea").set_deferred("Monitorable", false)

func _on_PickedObjectArea_area_entered(area):
	if area.name == "ContainerArea":
		#print("inside containerArea")
		pickedObjectArea = true
	if area.name == "BallArea":
		interactArea = true

func _on_PickedObjectArea_area_exited(area):
	if area.name == "ContainerArea":
		#print("outside containerArea")
		pickedObjectArea = false
	if area.name == "BallArea":
		interactArea = false

func _has_object(boolean):
	hasObject = boolean


