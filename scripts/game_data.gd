extends Resource
class_name GameData


var health = 100.0


var baseFOV = 70.0
var scopedFOV = 70.0
var lookSensitivity = 1.0
var aimSensitivity = 1.0
var scopeSensitivity = 1.0

var primary: String # string for the weapons resource, for eg "DebugAutoRifle" for var DebugAutoRifle = preload("res://resources/debug_auto_rifle.tres")
var secondary: String # same
var tertiary: String # same
var knife: String # same
var equipedWeapon: String # primary, secondary, tertiary, knife, none=("")
var equipingWeapon: bool
var weaponState: String # hip, aim, reload
var firemode = 1
var isScoped = false
var weaponPosition = 1
var inspectPosition = 1
var jammed = false
var flashlight = false

var freeze = false
var isGrounded = false
var isFalling = false
var isFlying = false
var isIdle = false
var isMoving = false
var isWalking = false
var isRunning = false
var isCrouching = false
var isAiming = false
var isFiring = false
var isReloading = false
var isInspecting = false
var isInserting = false
var isChecking = false
var isClearing = false


func Reset():
	health = 100.0


	baseFOV = 70.0
	scopedFOV = 70.0
	lookSensitivity = 1.0
	aimSensitivity = 1.0
	scopeSensitivity = 1.0

	primary = ""
	secondary = ""
	tertiary = ""
	knife = ""
	equipedWeapon = ""
	equipingWeapon = false
	weaponState = "" 
	firemode = 1
	isScoped = false
	weaponPosition = 1
	inspectPosition = 1
	jammed = false
	flashlight = false

	freeze = false
	isGrounded = false
	isFalling = false
	isFlying = false
	isIdle = false
	isMoving = false
	isWalking = false
	isRunning = false
	isCrouching = false
	isAiming = false
	isFiring = false
	isReloading = false
	isInspecting = false
	isInserting = false
	isChecking = false
	isClearing = false
