extends Control

var scene = null

func _on_Play_Button_pressed() -> void:
	$AnimationPlayer.play("Fade_to_black")
	scene = "play"

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Fade_to_black" && scene == "play":
		$AnimationPlayer.play("Fade_to_normal")
		get_tree().change_scene("res://Environment/Scene/Panda House.tscn")
