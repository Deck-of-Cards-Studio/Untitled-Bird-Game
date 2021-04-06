extends KinematicBody

var mouse_sensitivity = 0.1

var speed = 10
var acceleration = 5

var direction = Vector3()
var velocity = Vector3()

var gravity = 9.8
var jump = 6.5
var graV = Vector3()

onready var pivot = $Pivot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		pivot.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		pivot.rotation.x = clamp(pivot.rotation.x, deg2rad(-80), deg2rad(80))


func _process(delta):
	var CharecterSpeed = speed
	if Input.is_action_pressed("sprint"):
		CharecterSpeed = speed * 2
#		print("speed") - debugging
	else:
		 CharecterSpeed = speed
	
	direction = Vector3()
	
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
		
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
		
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
		
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	
	
#	Debugging
#	if is_on_floor(): 
#		print("floor")
	
	if not is_on_floor():
		graV.y -= gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		graV.y = jump
	
	
	direction = direction.normalized()
	velocity = direction * CharecterSpeed
	velocity.linear_interpolate(velocity, acceleration * delta)
	move_and_slide(velocity, Vector3.UP)
	move_and_slide(graV, Vector3.UP)
