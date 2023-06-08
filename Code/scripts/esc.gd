extends Node2D


func _ready():
	pass # Replace with function body.


func _on_esc2_pressed():
  get_tree().change_scene("res://scenes/world.tscn")

func _on_exit_pressed():
	get_tree().quit()
	


func _on_options_pressed():
	pass # Replace with function body.
