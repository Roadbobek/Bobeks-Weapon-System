extends Node3D

var GameData = preload("res://scripts/game_data.tres")

var DebugAutoRifle = preload("res://resources/debug_auto_rifle.tres")
var DebugPistol = preload("res://resources/debug_pistol.tres")

var WeaponAnimationPlayer
var DebugAutoRifleNode
var DebugPistolNode

var weapon_resource
var weapon_node


func _ready() -> void:
	WeaponAnimationPlayer = $"WeaponAnimationPlayer"
	DebugAutoRifleNode = get_node("JointShoulderRight/UpperArmRight/JointElbowRight/ForearmRight/JointWristRight/" + DebugAutoRifle.node_on_player)
	DebugPistolNode = get_node("JointShoulderRight/UpperArmRight/JointElbowRight/ForearmRight/JointWristRight/" + DebugPistol.node_on_player)
	
	GameData.primary = "DebugAutoRifle"
	GameData.secondary = ""
	GameData.tertiary = "DebugPistol"
	GameData.knife = ""
	GameData.weaponBusy = false


func handle_weapon_change(switch_to_slot: String):
	if not GameData.weaponBusy: # implement event queue ?
		if switch_to_slot == GameData.equipedWeapon:
			unequip_weapon_or_switch()
		elif GameData.equipedWeapon:
			unequip_weapon_or_switch(switch_to_slot)
		else:
			equip_weapon(switch_to_slot)


func equip_weapon(switch_to_slot: String):
	GameData.equipedWeapon = switch_to_slot
	weapon_resource = get(resolve_weapon_from_slot())
	if weapon_resource:
		GameData.weaponBusy = true
		weapon_node = get(weapon_resource.node_on_player + "Node")
		weapon_node.visible = true
		WeaponAnimationPlayer.play(weapon_resource.animation_name_prefix + "_equip")
		#await WeaponAnimationPlayer.animation_finished


func unequip_weapon_or_switch(switch_to_slot: String = ""):
	if GameData.equipedWeapon:
		weapon_resource = get(resolve_weapon_from_slot())
		if weapon_resource:
			GameData.weaponBusy = true
			weapon_node = get(weapon_resource.node_on_player + "Node")
			WeaponAnimationPlayer.play_backwards(weapon_resource.animation_name_prefix + "_equip")
			await WeaponAnimationPlayer.animation_finished
			weapon_node.visible = false
			GameData.weaponBusy = false
			GameData.equipedWeapon = ""
			weapon_resource = null
			weapon_node = null
			if switch_to_slot:
				equip_weapon(switch_to_slot)


func resolve_weapon_from_slot():
	var slot = GameData.equipedWeapon
	if slot == "primary":
		return GameData.primary
	elif slot == "secondary":
		return GameData.secondary
	elif slot == "tertiary":
		return GameData.tertiary
	elif slot == "knife":
		return GameData.knife


#func resolve_node_from_weapon():
	

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed("inventory_primary"):
		handle_weapon_change("primary")

	elif event is InputEventKey and Input.is_action_just_pressed("inventory_secondary"):
		handle_weapon_change("secondary")
		
	elif event is InputEventKey and Input.is_action_just_pressed("inventory_tertiary"):
		handle_weapon_change("tertiary")


func _process(delta: float) -> void:
	if GameData.weaponBusy and not WeaponAnimationPlayer.is_playing():
		GameData.weaponBusy = false
		# enable firing logic here
	
	if GameData.weaponBusy and not WeaponAnimationPlayer.is_playing():
		GameData.weaponBusy = false




















#func _ready() -> void:
	#DebugPistol = $"JointShoulderRight/UpperArmRight/JointElbowRight/ForearmRight/JointWristRight/DebugPistol"
	#DebugAutoRifle = $"JointShoulderRight/UpperArmRight/JointElbowRight/ForearmRight/JointWristRight/DebugAutoRifle"
	#WeaponAnimationPlayer = $"WeaponAnimationPlayer"
#func _unhandled_key_input(event: InputEvent) -> void:
	## Weapon equip and unequip
	## TODO: expand and make better, for eg an inventory system
	## TODO: make dynamic, not a tree of if and else statements
	## TODO: fucking state machine bro
	## debug_pistol
	#if event is InputEventKey and Input.is_action_just_pressed("inventory_tertiary"):
		## unequip if already equiped
		#if equiped_weapon == "debug_pistol":
			#print("Unequiping debug_pistol") # DEBUG
			#print("Equiping none") # DEBUG
			#WeaponAnimationPlayer.play_backwards("debug_pistol_equip")
			#DebugPistol.visible = false
			#equiped_weapon = "none"
		## jus make a state machine gng
		#elif equiped_weapon == "debug_auto_rifle":
			#print("Unequiping debug_auto_rifle") # DEBUG
			#print("Equiping debug_pistol") # DEBUG
			#WeaponAnimationPlayer.play_backwards("debug_pistol_equip")
			#DebugAutoRifle.visible = false
			#equiped_weapon = "debug_pistol"
			#DebugPistol.visible = true
			#WeaponAnimationPlayer.play("debug_pistol_equip")
		## equip if nothing else equiped
		#elif equiped_weapon == "none":
			#print("Equiping debug_pistol") # DEBUG
			#equiped_weapon = "debug_pistol"
			#DebugPistol.visible = true
			#WeaponAnimationPlayer.play("debug_pistol_equip")
	#
		## debug_auto_rifle
	#elif event is InputEventKey and Input.is_action_just_pressed("inventory_primary"):
		## unequip if already equiped
		#if equiped_weapon == "debug_auto_rifle":
			#print("Unequiping debug_auto_rifle") # DEBUG
			#print("Equiping none") # DEBUG
			#WeaponAnimationPlayer.play_backwards("debug_pistol_equip")
			#DebugAutoRifle.visible = false
			#equiped_weapon = "none"
		## jus make a state machine gng
		#elif equiped_weapon == "debug_pistol":
			#print("Unequiping debug_pistol") # DEBUG
			#print("Equiping debug_auto_rifle") # DEBUG
			#WeaponAnimationPlayer.play_backwards("debug_pistol_equip")
			#DebugPistol.visible = false
			#equiped_weapon = "debug_auto_rifle"
			#DebugAutoRifle.visible = true
			#WeaponAnimationPlayer.play("debug_pistol_equip")
		## equip if nothing else equiped
		#elif equiped_weapon == "none":
			#print("Equiping debug_auto_rifle") # DEBUG
			#equiped_weapon = "debug_auto_rifle"
			#DebugAutoRifle.visible = true
			#WeaponAnimationPlayer.play("debug_pistol_equip")
