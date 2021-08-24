extends Node2D

onready var marshall = get_node("/root/Panda House/YSort/Marshall")


func _ready() -> void:
	marshall.light = false
	
func _on_Pintu_Keluar_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Scene Transition/AnimationPlayer".play("Fade_To_black")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Fade_To_black":
		$"Scene Transition/AnimationPlayer".play("Fade_to_normal")
		get_tree().change_scene("res://Environment/Scene/Front House.tscn")
