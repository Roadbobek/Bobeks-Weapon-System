extends CharacterBody3D

const SPEED = 5.0
const SPRINT_MULTIPLIER = 1.666
const JUMP_VELOCITY = 4.0
const LOOK_SENSITIVITY = 0.3 # TODO: add to settins

var HEAD_JOINT
var mouse_movement = Vector2.ZERO


func _ready():	
	# capture, lock mouse
	# TODO: maybe migrate mouse capturing and locking logic to its own script
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	HEAD_JOINT = $JointHead


func _unhandled_input(event: InputEvent) -> void:
	# Capture mouse movement
	if event is InputEventMouseMotion:
		# use InputEventMouseMotion.screen_relative instead of .relative to-
		# avoid player looking appearing different depending on resolution
		mouse_movement = event.screen_relative
		#print(mouse_movement) # DEBUG
	

func _physics_process(delta: float) -> void:
	# Rotate player
	rotate_y(-mouse_movement.x * LOOK_SENSITIVITY * 0.01)
	
	# Rotate head
	HEAD_JOINT.rotate_x(-mouse_movement.y * LOOK_SENSITIVITY * 0.01)
	# clamp at 90 degrees, 1.57 radians
	HEAD_JOINT.rotation.x = clamp(HEAD_JOINT.rotation.x, -1.57, 1.57)
	
	# reset mouse velocity
	mouse_movement = Vector2.ZERO
	
	# Gravity
	if not is_on_floor():
		# TODO: can we cache this?
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Walk / sprint
	var input_dir := Input.get_vector("player_move_left", "player_move_right", "player_move_forward", "player_move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Input.is_action_pressed("player_sprint"):
			velocity.x = direction.x * SPEED * SPRINT_MULTIPLIER
			velocity.z = direction.z * SPEED * SPRINT_MULTIPLIER
		else:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
