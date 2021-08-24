extends CanvasLayer

func transisi() -> void:
	$AnimationPlayer.play("Fade_to_black")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Fade_to_black":
		$AnimationPlayer.play("Fade_to_normal")
