extends Node2D

var tujuan = null

signal from_place(value)

func _on_To_Front_House_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		var from = "forest"
		
		emit_signal("from_place", from)
		tujuan = "front_house"
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	if tujuan == "front_house":
		get_tree().change_scene("res://Environment/Scene/Front House.tscn")
