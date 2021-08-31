extends Node2D

var dialogue = Dialogic.start("Pre Level 2")

func _ready() -> void:
	add_child(dialogue)
	dialogue.connect("dialogic_signal", self, "dialogic_signal")

func dialogic_signal(argument):
	if argument == "pre_level2_finished":
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	Global.player_position = Vector2(472, 696)
	get_tree().change_scene("res://Environment/Scene/Emotional Flare (2).tscn")
