extends KinematicBody2D

onready var collision: CollisionShape2D = get_node("AttackArea/Collision")
onready var animation: AnimationPlayer = get_node("animation")
onready var sprite: Sprite = get_node("Sprite")

var velocity: Vector2
var can_die: bool = false
var can_attack: bool = false 

export (int) var speed

func _physics_process(_delta: float) -> void:
	move()
	attack()
	animate()
	direction()

func move() -> void:
	var direction_vector: Vector2 = Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		Input.get_action_strength("s") - Input.get_action_strength("w")
	).normalized()
	velocity = direction_vector * speed
	velocity = move_and_slide(velocity)

func attack() -> void:
	if Input.is_action_just_pressed("ui_select") and not can_attack: 
		can_attack = true 
	
func animate() -> void:
	if can_die:
		animation.play("dead")
		set_physics_process(false)
	elif can_attack:
		animation.play("attack")
		set_physics_process(false)
	elif velocity != Vector2.ZERO: 
		animation.play("run")
	else: 
		animation.play("idle")

func direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
		collision.position = Vector2(30.688, 13.859)
	else: 
		sprite.flip_h = true
		collision.position = Vector2(-30.688, 13.859)

func kill() -> void:
	can_die = true

func on_animation_finished(anim_name):
	if anim_name == "dead":
		var _reload: bool = get_tree().reload_current_scene()
	elif anim_name == "attack":
		can_attack = false
		set_physics_process(true)
