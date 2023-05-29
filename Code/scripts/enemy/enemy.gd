extends KinematicBody2D
class_name Enemy

onready var sprite: Sprite = get_node("Texture")
onready var attack_time: Timer = get_node("Attack")
onready var animation: AnimationPlayer = get_node("Animation")

var player_ref: KinematicBody2D = null
var velocity: Vector2

export(int) var move_speed
export(int) var distance_threshold

export(float) var attack_cooldown

var can_deal_demage: bool = true

export(int) var health
export(int) var enemy_damage

func _physics_process(_delta: float) -> void:
	if player_ref == null:
		return
	
	move()
	velocity = move_and_slide(velocity)
	verify_orientation()
	
func move() -> void:
	var x_distance: float = player_ref.global_position.x - global_position.x
	var x_direction: float = sign(x_distance)
	if abs(x_distance) < distance_threshold and can_deal_demage:
		player_ref.update_health(enemy_damage)
		attack_time.start(attack_cooldown)
		can_deal_demage = false
		velocity.x = 0
		
	if abs(x_distance) > distance_threshold:
		velocity.x = x_direction * move_speed
	
	
func on_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body
	
	
func on_body_exited(body):
	if body.is_in_group("player"):
		player_ref = null 


func on_timeout() -> void:
	can_deal_demage = true


func update_health(value: int) -> void:
	health -= value
	if health <= 0:
		Global.kill_count()
		queue_free()
		return
		
	animation.play("hit") #animação de vida do enemuy
	
func verify_orientation() -> void:
	if velocity.x > 0:
		sprite.flip_h = true
		
	if velocity.x < 0:
		sprite.flip_h = false


func on_animation_finished(_anim_name: String) -> void:
	animation.play("idle") #colocar o parametro da animação
	set_physics_process(true)
	
