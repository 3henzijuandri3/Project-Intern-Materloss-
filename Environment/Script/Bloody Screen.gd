extends CanvasLayer

func muncul_darah():
	$AnimationPlayer.play("AA")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "AA":
		pass
