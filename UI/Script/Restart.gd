extends TextureButton

func _on_Restart_pressed() -> void:
	$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	get_tree().reload_current_scene()
