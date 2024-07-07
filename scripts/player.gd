class_name Player extends CharacterBody2D

#region Properties

enum orientation {FRONT,BACK,RIGHT,LEFT}

@onready var current_orientation = orientation.FRONT
@onready var isIdle = true
@onready var anim = $AnimatedSprite2D

@export var speed = 200

#endregion

#region Gameloop

func _ready():
	anim.play("idle_front")

func _process(delta):
	var wasIdle = isIdle
	var previous_orientation = current_orientation
	compute_velocity()
	if wasIdle != isIdle || previous_orientation != current_orientation:
		animate()

func _physics_process(delta):
	move_and_slide()
	
#endregion

#region Methods

func compute_velocity():
	if Input.is_action_pressed("MoveRight"):
		velocity.x = speed
		velocity.y = 0
		current_orientation = orientation.RIGHT
		isIdle = false
	elif Input.is_action_pressed("MoveLeft"):
		velocity.x = -speed
		velocity.y = 0
		current_orientation = orientation.LEFT
		isIdle = false
	elif Input.is_action_pressed("MoveDown"):
		velocity.x = 0
		velocity.y = speed
		current_orientation = orientation.FRONT
		isIdle = false
	elif Input.is_action_pressed("MoveUp"):
		velocity.x = 0
		velocity.y = -speed
		current_orientation = orientation.BACK
		isIdle = false
	else:
		velocity.x = 0
		velocity.y = 0
		isIdle = true

func animate():
	if current_orientation == orientation.BACK && isIdle:
		anim.play("idle_back")
	elif current_orientation == orientation.BACK && !isIdle:
		anim.play("walk_back")
	elif current_orientation == orientation.FRONT && isIdle:
		anim.play("idle_front")
	elif current_orientation == orientation.FRONT && !isIdle:
		anim.play("walk_front")
	elif current_orientation == orientation.LEFT && isIdle:
		anim.play("idle_left")
	elif current_orientation == orientation.LEFT && !isIdle:
		anim.play("walk_left")
	elif current_orientation == orientation.RIGHT && isIdle:
		anim.play("idle_right")
	elif current_orientation == orientation.RIGHT && !isIdle:
		anim.play("walk_right")

#endregion

