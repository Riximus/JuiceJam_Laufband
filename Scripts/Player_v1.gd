extends KinematicBody2D

export var speed : float = 500

export (PackedScene) var ball_scene

var direction : Vector2
var dir : float

#onready var ball_scene = preload("res://Ball.tscn")

func _ready():
	get_parent().get_node("Ball").connect("picked_up", self, "_picked_up_ball")

func _physics_process(_delta: float):
	player_move()

func player_move():
	var direction: Vector2 = get_direction()
	if direction.length() > 1.0: #for vertical movement
		direction = direction.normalized()
	look_at(get_global_mouse_position())
	move_and_slide(speed * direction)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
func _picked_up_ball():
	var ball_instance = ball_scene.instance()
	add_child(ball_instance)
	print("hey")
