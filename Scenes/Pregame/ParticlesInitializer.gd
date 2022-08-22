extends Node2D
onready var particlePath = ("res://Particles/ParticleResources/")
onready var animation = preload ("res://Scenes/Pregame/CharacterSelection/CharacterSelectionButton.tscn")
var fileManipulator = load ("res://Resources/FileManipulation/FileManipulator.tres")

signal particlesInitialized

var idleAnimation
var runAnimation

func _ready():
	set_anim_mat ()
	prefire_particles()

func set_anim_mat ():
	idleAnimation = animation.instance ()
	var idleAnim = idleAnimation.get_node("AnimationPlayer")
	idleAnim.play ("Idle")
	runAnimation = animation.instance ()
	var runAnim = idleAnimation.get_node("AnimationPlayer")
	runAnim.play ("Run")

func prefire_particles ():
	for i in fileManipulator.load_item_list(particlePath):
		var particle = Particles2D.new()
		particle.set_modulate (Color(1,1,1,0))
		particle.set_process_material (i)
		particle.set_one_shot (true)
		particle.set_emitting (true)
		add_child(particle)
	#animations
	add_child (idleAnimation)
	add_child (runAnimation)

	yield (get_tree().create_timer(0.05), "timeout")
	emit_signal ("particlesInitialized")
	#self.queue_free()



