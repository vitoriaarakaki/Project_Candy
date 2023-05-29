extends Node
class_name Player

const PROJECTILE: PackedScene = preload("res://Scripts/Player/arma.gd") #repertorio do script da arma

#fazer referencia a sprite
onready var sprite: Sprite = get_node("Texture")
onready var spawn_point: Position2D = get_node("SpawnPoint")
onready var animation: AnimationPlayer = get_node("Animation")

#Variaveis
var velocity: Vector2 
var can_attack: bool = true

#Variaveis que podem ser modificadas sem precisar mexer no scirpt
export(int) var move_speed
export(int) var jump_speed
export(int) var gravity_speed

#Fazer as inputs do teclado 
func _physics_process(delta: float) -> void:
	move()
	attack()
	jump(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	sprite.animate(velocity)
	
func move() -> void:
	velocity.x = move_speed * get_direction()
	
func get_direction() -> float:
	return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

func attack() -> void:
	if Input.get_action_just_pressed("ui_attack") and is_on_floor() and can_attack:
		sprite.action_behavaior("attack")
		can_attack = false

func jump(delta: float) -> void:
	#1/60 ~ 0.0016667 - valor de delta
	velocity.y += delta * gravity_speed
	 
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = -jump_speed
	
func spaw_projectile() -> void:
	var projectile: Aroow = PROJECTILE.instance()
	projectile.direction = sign(spawn_point.position.x)
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = spawn_point.global_position
	
	
func freeze(state: bool) -> void:
	animation.play("idle")
	set_physics_process(state)
