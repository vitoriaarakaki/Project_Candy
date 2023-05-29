extends CanvasLayer
class_name Interface

const DIALOG: PackedScene = preload("res://scenes/management/dialog.tscn") #repertorio

func spawn_dialog(npc, dialog_text_list: Array) -> void:
	var dialog: Dialog = DIALOG.instance()
	dialog.dialog_text_list = dilaog_text_list
	var _dialog: bool = dialog.connect("dialog_finished", npc, "on_dialog_finished")
	add_child(dilaog)
