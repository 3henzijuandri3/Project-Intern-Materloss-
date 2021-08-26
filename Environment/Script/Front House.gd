extends Node2D

var tujuan = null

func _on_Pintu_Masuk_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		tujuan = "house"
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	if tujuan == "house":
		get_tree().change_scene("res://Environment/Scene/Panda House.tscn")
	elif tujuan == "forest":
		get_tree().change_scene("res://Environment/Scene/Forest.tscn")

func _on_To_Forest_body_entered(body: Node) -> void:
		if body.is_in_group("Player"):
			tujuan = "forest"
			$"Scene Transition".transisi()
