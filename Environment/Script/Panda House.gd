extends Node2D

onready var marshall = get_node("/root/Panda House/YSort/Marshall")


func _ready() -> void:
	marshall.light = false
	
func _on_Pintu_Keluar_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	get_tree().change_scene("res://Environment/Scene/Front House.tscn")
