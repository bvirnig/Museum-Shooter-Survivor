extends Control

var level = "res://Scenes/main.tscn"

func _on_btn_play_click_end():
	print("Play button clicked")
	var _level = get_tree().change_scene_to_file(level)

func _on_btn_exit_click_end():
	print("Exit button clicked")
	get_tree().quit()
