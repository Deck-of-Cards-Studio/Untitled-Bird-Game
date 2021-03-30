extends KinematicBody

const FLOOR = Vector3(0,-1,0)
const JUMP = 60
var velocity = Vector3(0,0,0)
var MOVE = 10

func _ready():
	pass

func _input(event):
	pass
# both of these above are currently unused

func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()

func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		pass
	elif Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("ui_shift"):
			velocity.x += 2 * MOVE
		else:
			velocity.x += MOVE
	elif Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("ui_shift"):
			velocity.x -= 2 * MOVE
		else:
			velocity.x -= MOVE
	else:
		velocity.x = lerp(velocity.x,0,0.1)
		
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		pass
	elif Input.is_action_pressed("ui_down"):
		if Input.is_action_pressed("ui_shift"):
			velocity.z += 2 * MOVE
		else:
			velocity.z += MOVE
	elif Input.is_action_pressed("ui_up"):
		if Input.is_action_pressed("ui_shift"):
			velocity.z -= 2 * MOVE
		else:
			velocity.z -= MOVE
	else:
		velocity.z = lerp(velocity.z,0,0.1)
	if Input.is_action_just_pressed("ui_accept") and is_on_wall():
		# the floor isn't set, so it treats all surfaces as walls.
		velocity.y = JUMP
	else:
		velocity.y = lerp(velocity.y, -5, 0.1)
		# yes, I know the jump is a bit floaty
	if translation.y <= -2:
		get_tree().reload_current_scene()
	move_and_slide(velocity)
