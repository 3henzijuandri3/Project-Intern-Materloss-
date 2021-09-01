extends Control

var scene = null

func _ready() -> void:
	$"Bg Sound".play()

func _on_Play_Button_pressed() -> void:
	$AnimationPlayer.play("Fade_to_black")
	scene = "play"

func _on_Exit_Button_pressed() -> void:
	get_tree().quit()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Fade_to_black" && scene == "play":
		$"Bg Sound".stop()
		$AnimationPlayer.play("Fade_to_normal")
		get_tree().change_scene("res://Environment/Scene/Panda House.tscn")

func _on_Bg_Sound_finished() -> void:
	$"Bg Sound".play()



