extends Resource
class_name WeaponSkillStatsRes

var playerStatsRes: PlayerStatsRes	= load ("res://Resources/PlayerStatsRes.tres")
var rotationCurve: Curve			= load ("res://Resources/Graphs/rotationCurve.tres")
var movementCurve: Curve			= load ("res://Resources/Graphs/movementCurve.tres")
var accelerationCurve: Curve		= load ("res://Resources/Graphs/accelerationCurve.tres")


#Check parent.is_in_group()

#--------------------
#base for every skill
#functions in this category must be present in the spawner script

func add_parent_to_groups (parent: Node, groups: Array):
	for i in groups:
		parent.add_to_group(i)

func attack_speed_timer (timerNode):
	timerNode.wait_time = 1 / playerStatsRes.finalAttackSpeed
#--------------------

#--------------------
#base for every skill
#functions in this category must be present in the weaponSkill script

func handle_aimDegrees (skill, value):
	if skill.aimDegrees == null:
		skill.aimDegrees = value

func handle_playerVector (skill, value):
	#disable snapshotting for snappier movement, enable for more physics based
	if skill.playerVector == null:
		skill.playerVector = value


#change playerdirect to mousedirect

func movement (parent, skill, delta):
	if parent.is_in_group ("PROJECTILE"):
		if skill.curveFinished == true:
			projectile_duration (parent, skill, delta)
			if skill.projectileDuration > 0:
				#create combination of projectile and player movement
				skill.projectileVector = (skill.position - playerStatsRes.playerPosition)
#				skill.combinedVector = (skill.projectileVector + skill.playerVector).normalized()
				skill.projectileMove = skill.projectileVector.normalized () * playerStatsRes.finalProjectileSpeed
				skill.combinedMove = skill.projectileMove + skill.playerVector  * playerStatsRes.playerMovementSpeedCalculation ()
				skill.collisionObject = skill.move_and_collide (skill.combinedMove * delta)
#				if skill.collisionObject:
#					if skill.bounceVector == null:
#						skill.bounceVector = skill.combinedVector.bounce (skill.collisionObject.normal)
#				if skill.bounceVector:
#					skill.collisionObject = skill.move_and_collide (skill.bounceVector * playerStatsRes.finalProjectileSpeed * delta)
#				else:
					

func skill_spawner (parent, weaponPath):
	if parent.is_in_group("CIRCULAR") and parent.is_in_group ("STATIONARY"):
		var children = parent.get_children()
		for i in children:
			i.queue_free ()
		for i in playerStatsRes.projectiles:
			var newCircular = weaponPath.instance ()
			#newCircular.rotation_degrees += ((360 / projectiles) * i)
			newCircular.rotationDegrees += ((360 / playerStatsRes.projectiles) * i)
			parent.add_child (newCircular)
	if parent.is_in_group ("PROJECTILE"):
		for i in playerStatsRes.projectiles:
			var newProjectile = weaponPath.instance ()
			# starts with 0 which is divideable by 2
			if i % 2 == 0 and i != 0:
				var projAngle = (- playerStatsRes.finalProjectileSpread * (i / 2))
				newProjectile.rotationDegrees += projAngle
				newProjectile.rotationOffset += projAngle
			elif i != 0:
				var projAngle = (playerStatsRes.finalProjectileSpread * ((i / 2) + 1))
				newProjectile.rotationDegrees += projAngle
				newProjectile.rotationOffset += projAngle
			parent.add_child (newProjectile)
		pass

#--------------------

#--------------------
#rotations

func rotation_adder (skill, parent, delta):
	if skill.curveFinished == false:
		skill.rotationCurve = rotationCurve.interpolate_baked (skill.animationStep) * rotationCurve.bake_resolution / 2
		skill.movementCurve = 0.3 + movementCurve.interpolate_baked (skill.animationStep) * movementCurve.bake_resolution / 12
		skill.accelerationCurve = accelerationCurve.interpolate_baked (skill.animationStep) * accelerationCurve.bake_resolution / 12

		if parent.is_in_group ("PROJECTILE"):
			skill.animationStep += delta * 2
		elif parent.is_in_group ("STATIONARY") and parent.is_in_group ("CIRCULAR"):
			skill.animationStep += delta / 1.5

	if parent.is_in_group ("PROJECTILE"):
		skill.rotationDegrees -= delta * skill.rotationCurve * playerStatsRes.finalProjectileSpeed / 5
		
	elif parent.is_in_group ("STATIONARY") and parent.is_in_group ("CIRCULAR"):
		skill.rotationDegrees += delta * skill.accelerationCurve  * playerStatsRes.finalProjectileSpeed / 20

	skill.rotationRadians = deg2rad(skill.rotationDegrees)

func rotate_everything (parent, skill, toRotate, particleNode, offsetAngle, delta):
	if parent.is_in_group ("ROTATING"):
		rotation_adder (skill, parent, delta)
		if parent.is_in_group ("STATIONARY"):
			offset_rotator(skill, skill.rotationOffset, skill.rotationRadians, playerStatsRes.playerPosition)
			#pivot_rotator (skill, toRotate, particleNode, shaderBool, offsetAngle, skill.rotationDegrees, null, false)
			pivot_rotator (parent, skill, skill, particleNode, offsetAngle, skill.rotationDegrees, null, false)
		if parent.is_in_group ("PROJECTILE"):
			if skill.curveFinished == false:
				offset_rotator (skill, skill.movementCurve , playerStatsRes.mouseAngleRadians + deg2rad(skill.rotationOffset), playerStatsRes.playerPosition)
			pivot_rotator (parent, skill, toRotate, particleNode, offsetAngle, skill.rotationDegrees, (rad2deg(playerStatsRes.mouseAngleRadians)), true)
			offset_rotator (toRotate, skill.graphicsOffset, deg2rad(skill.rotationDegrees), Vector2.ZERO)
	else:
		pass

func offset_rotator(toRotate, posOffset, rotationRad, currentPos):
	#playerStatsRes.playerPosition
	if posOffset == null:
		posOffset = 0
	var pos= Vector2.ZERO
	pos.x = currentPos.x + (cos (rotationRad)) * posOffset
	pos.y = currentPos.y + (sin (rotationRad)) * posOffset
	if toRotate != null:
		toRotate.set_position (pos)
	return pos

func pivot_rotator (parent, skill, toRotate, particleNode, offsetAngle, rotDegrees, aimingDegrees, aiming: bool):
	#offsetAngle = 90 if toRotate is flipped (eg: circular stationary rotation, with skill facing in movement)
	var degreesToRotateParticle = 0.0
	if offsetAngle == null:
		offsetAngle = 0
	if aiming == true and skill.curveFinished == false:
		degreesToRotateParticle = rotDegrees + aimingDegrees
		skill.rotation_degrees = aimingDegrees
	elif skill.aimDegrees != null:
		degreesToRotateParticle = rotDegrees + skill.aimDegrees
	else:
		degreesToRotateParticle = rotDegrees
	if parent.is_in_group ("CIRCULAR") and parent.is_in_group ("STATIONARY"):
		toRotate.rotation_degrees = rotDegrees + 90 #+ offsetAngle
		if particleNode != null:
			particleNode.process_material.set_shader_param ("emission_angle", - degreesToRotateParticle + 90)
	elif parent.is_in_group ("PROJECTILE"):
		toRotate.rotation_degrees = rotDegrees + offsetAngle
		if particleNode != null:
			particleNode.process_material.set_shader_param ("emission_angle", - degreesToRotateParticle - offsetAngle)

func projectile_duration (parent, skill, delta):
	#calc dur for movement by projectilespeed
	#onready set duration = finalProjectileSpeed
	skill.projectileDuration -= delta * 60 * 2
	if skill.projectileDuration <= 0:
		if parent.is_in_group ("RETURNING"):
			return_to_player(skill, delta)
		else:
			skill.queue_free ()

func return_to_player (skill, delta):
	#calculates the return vector and deletes self if near player
	skill.projectileVector = (playerStatsRes.playerPosition - skill.position)
	if skill.projectileVector.length () <= 5:
		skill.queue_free ()

	skill.projectileMove = skill.projectileMove.move_toward (skill.projectileVector.normalized () * (playerStatsRes.finalMovementSpeed + 20), 100)
	skill.move_and_collide (skill.projectileMove * delta)



#--------------------

#--------------------
#hits and crits

func calc_crit (occurence):
	for i in occurence:
		if randf () < playerStatsRes.finalCritChance:
			return playerStatsRes.finalCritMulti / 100
		else:
			return 1.0

func calc_hit ():
	var occurance = 1
	if playerStatsRes.luckyCrit == true:
		occurance = 2
	var hit = playerStatsRes.finalHitDamage * calc_crit(occurance)
	return hit

func calc_dot ():
	# take this damage every second / finalDotTickRate
	var source
	if playerStatsRes.dotBasedOnHit == true:
		source = calc_hit()
	elif playerStatsRes.dotBasedOnHit == false:
		source = playerStatsRes.finalDotDamage
	var dot = source * playerStatsRes.finalDotDuration / playerStatsRes.finalDotTickRate
	return dot

func apply_damage (victim: Node):
	victim.health -= calc_hit()
	if playerStatsRes.dotBasedOnHit == null:
		return
	var dotPerTick = calc_dot() / playerStatsRes.finalDotTickRate
	for i in playerStatsRes.finalDotDuration:
		victim.health -= dotPerTick

#--------------------

#--------------------
#wip


func scaling (scalecoeff, particleNode, offset):
	self.scale = Vector2(scalecoeff, scalecoeff)
	particleNode.process_material.scale = scalecoeff
	self.offset = offset + scalecoeff * 2


