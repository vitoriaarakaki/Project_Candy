extends Node2D


func _on_reset_pressed():
	get_tree().change_scene("res://scenes/world.tscn")



func _on_exit_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")
