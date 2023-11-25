extends CharacterBody2D

@onready var SM = $StateMachine

@export var walking = 500
@export var running = 1000
@export var path = [Vector2(3230,1190), Vector2(5150,1190)]
var direction = 1
@onready var default_position = $AnimatedSprite2D.position

func _ready():
	position = path[0]
	velocity.x = walking
	SM.set_state("Move")

func _physics_process(_delta):
	move_and_slide()
	
	if velocity.x < 0 and not $AnimatedSprite2D.flip_h: 
		$AnimatedSprite2D.flip_h = true
		direction = -1
		$Attack.target_position.x = -1*abs($Attack.target_position.x)
	if velocity.x > 0 and $AnimatedSprite2D.flip_h: 
		$AnimatedSprite2D.flip_h = false
		direction = 1
		$Attack.target_position.x = abs($Attack.target_position.x)
	
func set_animation(anim, off = Vector2.ZERO):
	if $AnimatedSprite2D.animation == anim and $AnimatedSprite2D.is_playing(): return
	if $AnimatedSprite2D.sprite_frames.has_animation(anim): $AnimatedSprite2D.play(anim)
	else: $AnimatedSprite2D.play()
	$AnimatedSprite2D.position = off + default_position

func damage():
	if SM.state_name != "Die":
		SM.set_state("Die")


func should_attack():
	if $Attack.is_colliding() and $Attack.get_collider().name == "Player":
		return true
	return false

func attack_target():
	if $Attack.is_colliding():
		return $Attack.get_collider()
	return null


func _on_area_2d_body_entered(body):
	if body.name == "Player" and SM.state_name != "Die":
		body.die()


func _on_animated_sprite_2d_animation_finished():
	if SM.state_name == "Attack":
		SM.set_state("Move")
	if SM.state_name == "Die":
		queue_free()
