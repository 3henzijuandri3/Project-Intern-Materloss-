extends Node2D


func _on_Pintu_Keluar_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Scene Transition/AnimationPlayer".play("Fade_To_black")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$"Scene Transition/AnimationPlayer".play("Fade_to_normal")
	get_tree().change_scene("res://@Testing/Testing.tscn")
