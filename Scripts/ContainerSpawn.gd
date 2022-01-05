extends PathFollow2D

#export (PackedScene) var container_scene

export var speed : float = 100

func _physics_process(delta):
	move(delta)

func move(delta):
	set_offset(get_offset() + speed * delta)
