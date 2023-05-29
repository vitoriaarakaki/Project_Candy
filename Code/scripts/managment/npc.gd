extends StaticBody2D
class_name Npc

onready var quest_mark: Sprite = get_node("QuestMark")

var can_interact: bool = false
var is_quest_finished: bool = false

var player_ref: KinematicBody2D = null

export(Array, String) var dialog_text
export(Array, String) var special_text

func _ready() -> void:
	Global.enemies_dict[3] = self
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_interact") and can_interact: #colocar a tecla de interação
		can_interact = false
		player_ref.freeze(false)
		
	if is_quest_finished:
		get_tree().call_group("interface", "dialog", self, special_text)
		return
		
	get_tree().call_group("interface", "dialog", self, dialog_text)
		
func on_body_entered(body) -> void:
	if body.is_in_group("player"):
		player_ref = body
		can_interact = true
		quest_mark.visible = true
		
		
func on_body_exited(body) -> void:
	if body.is_in_group("player"):
		player_ref = null
		can_interact = false
		quest_mark.visible = false

func on_dialog_finished() -> void:
	can_interact = true
	player_ref.freeze(true)

