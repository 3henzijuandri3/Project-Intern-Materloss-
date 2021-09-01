extends Node2D

var dialogue = Dialogic.start("Talk to Sam")

func _ready() -> void:
	add_child(dialogue)
	dialogue.connect("dialogic_signal", self, "dialogic_signal")

func dialogic_signal(argument):
	if argument == "done_talk_to_sam":
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	Global.player_position = Vector2(2157.746, 2822.146)
	get_tree().change_scene("res://Environment/Scene/Village.tscn")
