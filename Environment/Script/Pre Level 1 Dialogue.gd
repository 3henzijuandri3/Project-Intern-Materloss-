extends Node2D

var dialogue = Dialogic.start("Pre Level 1")

func _ready() -> void:
	add_child(dialogue)
	dialogue.connect("dialogic_signal",self,"dialogic_signal")

func dialogic_signal(argument):
	if argument == "pre_level1_finished":
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	Global.player_position = Vector2(2025, 1184)
	get_tree().change_scene("res://Environment/Scene/Emotional Flare (1).tscn")
