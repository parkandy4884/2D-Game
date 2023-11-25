extends Node

@onready var SM = get_parent()
@onready var enemy = get_node("../..")

func _ready():
	await enemy.ready

func start():
	if enemy.direction < 0:
		enemy.set_animation("Attacking",Vector2(-95,0))
	else:
		enemy.set_animation("Attacking")
	enemy.velocity = Vector2.ZERO
	$Timer.start()

func physics_process(_delta):
	pass

func _on_timer_timeout():
	if SM.state_name == "Attack":
		var target = enemy.attack_target()
		if target != null and target.name == "Player":
			target.die()
