extends Node

var enemies_dict: Dictionary = {
	3: ""
}

var enimies_killed: int = 0

func kill_count() -> void:
	enimies_killed += 1
	if enemies_dict.has(enimies_killed):
		var dict_value = enemies_dict[enimies_killed]
		print(dict_value)
		dict_value.is_quest_finished = true

		
func reset() -> void:
	enimies_killed = 0
