extends KinematicBody2D

var direction = Vector2()
const top = Vector2(0,-1)
const down = Vector2(0,1)
const left = Vector2(-1,0)
const right = Vector2(1,0)
var velocity = Vector2()

var speed = 0
const max_speed = 400
const idle_speed = 10
var RayNode

var AnimNode
var anim = ""
var animNew = ""


func _ready():
	set_physics_process(true)
	RayNode = get_node("RayCast2D")
	AnimNode = get_node("AnimatedSprite")

func _physics_process(delta):
	var is_moving = (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"))
	
	#MOTION
	if is_moving:
		speed = max_speed
		if(Input.is_action_just_pressed("ui_up")):
			direction = top
			RayNode.set_rotation_degrees(180)
		if(Input.is_action_just_pressed("ui_down")):
			direction = down
			RayNode.set_rotation_degrees(0)
		if(Input.is_action_just_pressed("ui_left")):
			direction = left
			RayNode.set_rotation_degrees(-90)
		if(Input.is_action_just_pressed("ui_right")):
			direction = right
			RayNode.set_rotation_degrees(90)

	else:
		speed = 0
	
	velocity = speed*direction*delta
	move_and_collide(velocity)
	
	#ANIMATION
	if (velocity.length() > idle_speed*0.09):
		if(Input.is_action_pressed("ui_up")):
			anim = "Idle_B"
		if(Input.is_action_pressed("ui_down")):
			anim = "Idle_D"
		if(Input.is_action_pressed("ui_left")):
			anim = "Idle_L"
		if(Input.is_action_pressed("ui_right")):
			anim = "Idle_R"
	else:
		if(Input.is_action_just_pressed("ui_up")):
			anim = "Idle_B"
		if(Input.is_action_just_pressed("ui_down")):
			anim = "Idle_D"
		if(Input.is_action_just_pressed("ui_left")):
			anim = "Idle_L"
		if(Input.is_action_just_pressed("ui_right")):
			anim = "Idle_R"
	
	if anim != animNew:
		animNew = anim
		AnimNode.play(anim)