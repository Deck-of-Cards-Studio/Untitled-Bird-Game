extends Camera

const MOUSE_SENS = 0.5

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= MOUSE_SENS * event.relative.x
		#rotation_degrees.x -= MOUSE_SENS * event.relative.y
		
