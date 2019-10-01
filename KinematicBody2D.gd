extends KinematicBody2D

var direction = 0

var move = 0
var move_x = 0
var move_y = 0
var empuje = 250

export var tope = 700


var jump = false
var saltando = false
var controlEnSalto = 1
var subida = 0


var timerDamage
var timerGrab = 0

var colisionador

var gravity = 0
var dir = 1
var dirSalto = 0


var empujeconst = 265


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	
	move_x =  empuje
	
	if Input.is_action_just_pressed("ui_accept") and jump:
		saltando = true
	
	if Input.is_action_pressed("ui_accept"):
		jump = false
		if saltando:
			if subida < tope*0.95:
				subida = lerp(subida,tope, 0.2)
			else:
				saltando = false
				dirSalto = dir

		
	elif Input.is_action_just_released("ui_accept") and saltando:
		saltando = false
		dirSalto = dir
	
	if is_on_floor():
		gravity = 0
		jump = true
		subida = 0
	else:
		if not saltando:
			subida = lerp(subida,0,0.1)
		
	
		if not is_on_floor():
			gravity += 1450 * delta
		else:
			gravity = 0
			jump = true
			subida = 0

		
	var colliders = move_and_slide(Vector2(move_x,gravity-subida), Vector2(0,-1))
	
	if is_on_ceiling():
		saltando = false
		subida = 0
