extends Node2D

func _on_Pintu_Masuk_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$CanvasModulate/AnimationPlayer.play("Fade_to_black")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Fade_to_black":
		$CanvasModulate/AnimationPlayer.play("Fade_to_normal")
		get_tree().change_scene("res://Environment/Scene/Panda House.tscn")
