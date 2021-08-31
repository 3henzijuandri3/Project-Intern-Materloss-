extends Node2D

var dialogue = Dialogic.start("Post Level 2")

func _ready() -> void:
	add_child(dialogue)
	dialogue.connect("dialogic_signal",self,"dialogic_signal")

func dialogic_signal(argument):
	if argument == "post_level2_finished":
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	Global.level_2_completed = true
	Global.player_position = Vector2(4968.88, 952)
	get_tree().change_scene("res://Environment/Scene/Forest.tscn")
