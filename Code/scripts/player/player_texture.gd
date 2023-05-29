extends Node
class_name PlayerTexture

onready var animation: AnimationPlayer = get_node("%Animation")
onready var spawn_point: Position2D = get_node("%SpawnPoint")

onready var parent: KinematicBody2D = get_parent()

#func _ready() -> void:
	#animation.play("idle") #nome da animação
var on_action: bool = false

func animate(velocity: Vector2) -> void:
	verify_orientation(velocity.x)
	
	if on_action:
		return
		
	if velocity.y != 0:
		vertical_behavior(velocity.y)
		return
	
	horizontal_behavior(velocity.x)

func verify_orientation(speed: float) -> void:
	if speed > 0:
		flip_h = false
		spawn_point.position = Vector2(9, 6) #posição do position2D - direita
	
	if speed < 0:
		flip_h = true
		spawn_point.position = Vector2(-9, -6) #posição do position2D - esquerda
	
func action_behavior(action: String) -> void:
	on_action = true
	animation.play(action)
	
func vertical_behavior(speed: float) -> void:
	if speed > 0:
		animation.play("fall")
		
	if speed < 0:
		animation.play("jump")
		
func horizontal_behavior(speed: float) -> void:
	if speed != 0:
		animation.play("run")
		return
	
	animation.play("idle")

func on_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		on_action = false
		parent.can_attack = true
		parent.set_physics_process(true)
