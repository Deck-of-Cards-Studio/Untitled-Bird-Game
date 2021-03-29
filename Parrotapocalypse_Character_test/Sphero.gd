extends KinematicBody

const FLOOR = Vector3(0,-1,0)
const JUMP = 60
var velocity = Vector3(0,0,0)
var MOVE = 1

func _ready():
	pass


func _physics_process(delta):
	if Input.is_action_pressed("ui_shift"):
		MOVE = 2
		# this is meant to be a sprint
	else:
		MOVE = 1
	# because of the way I wrote this part, you can't move diagonally while holding shift.
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		pass
	elif Input.is_action_pressed("ui_right"):
		velocity.x += MOVE
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= MOVE
	else:
		velocity.x = lerp(velocity.x,0,0.1)
		
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		pass
	elif Input.is_action_pressed("ui_down"):
		velocity.z += MOVE
	elif Input.is_action_pressed("ui_up"):
		velocity.z -= MOVE
	else:
		velocity.z = lerp(velocity.z,0,0.1)
	move_and_slide(velocity)
	if Input.is_action_just_pressed("ui_accept") and is_on_wall():
		# the floor isn't set, so it treats all surfaces as walls.
		velocity.y = JUMP
	else:
		velocity.y = lerp(velocity.y, -(JUMP / 2), 0.1)

# this stuff is the start of getting a camera that moves with the mouse
#func _input(event):
	#if event is InputEventMouseButton:
		#print("mouse button event at ", event.position)
