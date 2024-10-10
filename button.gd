extends Button

signal click_end()

func _on_mouse_entered():
	$snd_hover.play()
	
	
func _on_pressed():
	$snd_click.play()
	


func _on_snd_click_finished() -> void:
	emit_signal("click_end")
