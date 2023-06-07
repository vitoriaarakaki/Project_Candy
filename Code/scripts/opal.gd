extends KinematicBody2D

onready var animation: AnimationPlayer = get_node("animation")
onready var sprite: Sprite = get_node("Sprite")

var velocity: Vector2
export (int) var speed


func _physics_process(_delta: float) -> void:
	move()
	animate()
	direction()

func move() -> void:
	var direction_vector: Vector2 = Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		Input.get_action_strength("s") - Input.get_action_strength("w")
	).normalized()
	velocity = direction_vector * speed
	velocity = move_and_slide(velocity)

func animate() -> void:
	if velocity != Vector2.ZERO: 
		animation.play("run right")
	else: 
		animation.play("idle down")

func direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	else: 
		sprite.flip_h = true



