extends Node2D

var velocity: Vector2
onready var animation: AnimationPlayer = get_node("animation")


func _on_play_pressed():
	get_tree().change_scene("res://scenes/world.tscn")


func _on_options_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
