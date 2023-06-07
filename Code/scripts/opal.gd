extends KinematicBody2D

onready var animation: AnimationPlayer = get_node("animation")
onready var sprite: Sprite = get_node("Sprite")

var velocity: Vector2
var can_die: bool = false
export (int) var speed

func _physics_process(_delta: float) -> void:
	move()
	animate()
	animate1()
	animate2()
	animate3()
	animate4()

func move() -> void:
	var direction_vector: Vector2 = Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		Input.get_action_strength("s") - Input.get_action_strength("w")
	).normalized()
	velocity = direction_vector * speed
	velocity = move_and_slide(velocity)
	
func animate() -> void:
	if Input.is_key_pressed(KEY_D):
		animation.play("run right")
		
func animate1() -> void:
	if Input.is_key_pressed(KEY_A):
		animation.play("run left")
		
func animate2() -> void:
	if Input.is_key_pressed(KEY_W):
		animation.play("run up")
		
func animate3() -> void:
	if Input.is_key_pressed(KEY_S):
		animation.play("run down")
		
func animate4() -> void:
	if velocity == Vector2.ZERO:
		animation.play("idle down")

func kill() -> void:
	can_die = true
