extends Area2D

onready var animation: AnimationPlayer = get_node("animation")
onready var sprite: Sprite = get_node("Sprite")

signal enemy_hit

var target
var attack_speed = 1.0
var can_attack = true

func _physics_process(_delta: float) -> void:
	animate1_atk()
	animate2_atk()
	animate3_atk()
	animate_atk()
	
func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		attack()

func attack():
	if !can_attack:
		return
	
	if target != null and target.is_in_group("enemies"):
		target.emit_signal("enemy_hit")
		
		can_attack = false
		yield(get_tree().create_timer(attack_speed), "timeout")
		can_attack = true

func animate_atk() -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		animation.play("attack right")
		
func animate1_atk() -> void:
	if  Input.is_mouse_button_pressed(BUTTON_LEFT):
		animation.play("attack left")
		
func animate2_atk() -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		animation.play("attack up")
		
func animate3_atk() -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		animation.play("attack down")
		
func set_target(new_target):
	target = new_target
