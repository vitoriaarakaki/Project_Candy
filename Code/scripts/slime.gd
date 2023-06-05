extends KinematicBody2D

onready var animation: AnimationPlayer = get_node("Animation")
onready var sprite: Sprite = get_node("Sprite")

var player_ref = null
var velocity: Vector2

export(int) var speed

func _physics_process(_delta: float) -> void:
	move()
	animate()
	verify_direction()
	
func move() -> void:
	if player_ref != null:
		var distance: Vector2 = player_ref.global_position - global_position
		var direction: Vector2 = distance.normalized()
		var distance_lenght: float = distance.length()
		if distance_lenght <= 5:
			player_ref.kill()
			velocity = Vector2.ZERO
		else: 
			velocity = speed * direction
	else: 
		velocity = Vector2.ZERO
		
	velocity = move_and_slide(velocity)

func animate() -> void:
	if velocity != Vector2.ZERO:
		animation.play("walk")
	else:
		animation.play("idle")
	
func verify_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	
func on_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body

func on_body_exited(body):
	if body.is_in_group("player"):
		player_ref = null
