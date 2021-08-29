extends TextureButton

func _on_Restart_pressed() -> void:
	get_tree().reload_current_scene()
