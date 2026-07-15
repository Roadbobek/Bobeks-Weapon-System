extends Node3D


var WeaponAnimationPlayer

var DebugPistol
var DebugAutoRifle


var equiped_weapon = "none"


func _ready() -> void:
	DebugPistol = $"JointShoulderRight/UpperArmRight/JointElbowRight/ForearmRight/JointWristRight/DebugPistol"
	DebugAutoRifle = $"JointShoulderRight/UpperArmRight/JointElbowRight/ForearmRight/JointWristRight/DebugAutoRifle"
	WeaponAnimationPlayer = $"WeaponAnimationPlayer"


func _unhandled_key_input(event: InputEvent) -> void:
	# Weapon equip and unequip
	# TODO: expand and make better, for eg an inventory system
	# TODO: make dynamic, not a tree of if and else statements
	# TODO: fucking state machine bro
	# debug_pistol
	if event is InputEventKey and Input.is_action_just_pressed("inventory_tertiary"):
		# unequip if already equiped
		if equiped_weapon == "debug_pistol":
			print("Unequiping debug_pistol") # DEBUG
			print("Equiping none") # DEBUG
			WeaponAnimationPlayer.play_backwards("debug_pistol_equip")
			DebugPistol.visible = false
			equiped_weapon = "none"
		# jus make a state machine gng
		elif equiped_weapon == "debug_auto_rifle":
			print("Unequiping debug_auto_rifle") # DEBUG
			print("Equiping debug_pistol") # DEBUG
			WeaponAnimationPlayer.play_backwards("debug_pistol_equip")
			DebugAutoRifle.visible = false
			equiped_weapon = "debug_pistol"
			DebugPistol.visible = true
			WeaponAnimationPlayer.play("debug_pistol_equip")
		# equip if nothing else equiped
		elif equiped_weapon == "none":
			print("Equiping debug_pistol") # DEBUG
			equiped_weapon = "debug_pistol"
			DebugPistol.visible = true
			WeaponAnimationPlayer.play("debug_pistol_equip")
	
		# debug_auto_rifle
	elif event is InputEventKey and Input.is_action_just_pressed("inventory_primary"):
		# unequip if already equiped
		if equiped_weapon == "debug_auto_rifle":
			print("Unequiping debug_auto_rifle") # DEBUG
			print("Equiping none") # DEBUG
			WeaponAnimationPlayer.play_backwards("debug_pistol_equip")
			DebugAutoRifle.visible = false
			equiped_weapon = "none"
		# jus make a state machine gng
		elif equiped_weapon == "debug_pistol":
			print("Unequiping debug_pistol") # DEBUG
			print("Equiping debug_auto_rifle") # DEBUG
			WeaponAnimationPlayer.play_backwards("debug_pistol_equip")
			DebugPistol.visible = false
			equiped_weapon = "debug_auto_rifle"
			DebugAutoRifle.visible = true
			WeaponAnimationPlayer.play("debug_pistol_equip")
		# equip if nothing else equiped
		elif equiped_weapon == "none":
			print("Equiping debug_auto_rifle") # DEBUG
			equiped_weapon = "debug_auto_rifle"
			DebugAutoRifle.visible = true
			WeaponAnimationPlayer.play("debug_pistol_equip")


func _process(delta: float) -> void:
	pass
