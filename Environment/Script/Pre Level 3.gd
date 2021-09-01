extends Node2D

var dialogue = Dialogic.start("Pre Level 3")

func _ready() -> void:
	add_child(dialogue)
	dialogue.connect("dialogic_signal", self, "dialogic_signal")

func dialogic_signal(argument):
	if argument == "pre_level3_finished":
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	Global.player_position = Vector2(4104,1256)
	get_tree().change_scene("res://Environment/Scene/Emotional Flare (3).tscn")
