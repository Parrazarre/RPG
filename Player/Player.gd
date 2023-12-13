extends CharacterBody2D

# base values for movement and attacking, can't be changed as of now
const ACCELERATION = 1040
const MAX_SPEED = 125
const FRICTION = 660
const ATTACK_SPEED = 1.4 # a value of 1 is a speed of 0.4 seconds

# gives values from 0 to 2 to each element
enum{
	MOVE,
	ROLL,
	ATTACK
}

# state when starting the game
var state = MOVE

# makes each variable available on the ready call
var animationPlayer = null
var animationTree = null
var animationState = null

# on start -> these get called
func _ready():
	animationPlayer = $AnimationPlayer # makes the AnimationPlayer callable in code
	animationTree = $AnimationTree # makes the AnimationTree callable in code
	animationState = animationTree.get("parameters/playback") # state machine initialisation

# on each frame -> these get called
func _process(delta):
	# movement function
	match state:
		MOVE:
			move_state(delta)

		ROLL:
			pass

		ATTACK:
			attack_state(delta)

# movement function
func move_state(delta):
	# basic keybinds for movement
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() # makes diagonals as long as cardinal movement
	
	# moving
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		# called here to prevent changing direction and to use the input_vector
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
	# idleing
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) # applies friction to slow down
	
	move_and_slide() # type of 2D movement
	
	if Input.is_action_just_pressed("cs_attack"):
		state = ATTACK
		#$Idle01.scale = Vector2(1.1, 0.9) #squashes the player when they attack 

# attack functino
func attack_state(delta):
	velocity = Vector2.ZERO
	animationTree.advance(delta * ATTACK_SPEED) # speeds up the animation according to the ATTACK_SPEED
	animationState.travel("Attack")
	animationTree.advance(delta * 1)
	
func attack_animation_finished():
	state = MOVE
	#$Idle01.scale = Vector2(1, 1) #resets the scale











