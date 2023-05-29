extends Node
class_name Arrow

onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

var direction: float = 1.0

export(int) var speed = 180

func _ready() -> void:
	if direction == -1.0:
		sprite.flip_h = true
		
func _physics_process(delta: float) -> void:
	translate(Vector2(delta * direction * speed, 0))
	
func on_body_entered(body) -> void:
	if body is TileMap:
		animation.play("stuck")
		set_physics_process(false)
		
func on_animation_finished(_anim_name: String) -> void:
	queue_free()
	
func on_screen_exited() -> void:
	queue_free()
