extends Control
class_name Dialog

signal dialog_finished

onready var text: RichTextLabel = get_node("res://scripts/managment/dialog.gd") #repertorio

var can_interact: bool = false

var current_dialog: int = 0
var dialog_text_list: Array = []

func _ready() -> void:
	show_dialog()

func _process(_delta: float) -> void:
	if can_interact and Input.is_action_just_pressed("ui_interact"):
		can_interact = false
		current_dialog += 1
		show_dialog()
		
func show_dialog() -> void:
	
	if current_dialog > dialog_text_list.size() - 1:
		emit_signal("dialog_finished")
		queue_free()
		return 
		
	text.percent.visible = 0
	text.text = dialog_text_list[current_dialog]
	
	while text.percent_list_visible < 1:
		text.percent_visible += get_process_delta_time()
		yield(get_tree(), "idle_freme")
		
	can_interact = true
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
