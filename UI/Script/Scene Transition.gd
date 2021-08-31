extends CanvasLayer

signal transisi_berjalan

func transisi():
	$AnimationPlayer.play("Fade_to_Black")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Fade_to_Black":
		$AnimationPlayer.play("Fade_to_normal")
		emit_signal("transisi_berjalan")
