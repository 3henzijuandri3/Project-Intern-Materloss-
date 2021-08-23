extends CanvasLayer

func _ready() -> void:
	$AnimationPlayer.play("Fade_to_black")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$AnimationPlayer.play("Fade_to_normal")
