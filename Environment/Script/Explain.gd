extends Node2D

var dialogue = Dialogic.start("Ending Explanation")

func _ready() -> void:
	add_child(dialogue)
	dialogue.connect("dialogic_signal", self, "dialogic_signal")

func dialogic_signal(argument):
	if argument == "done_ending":
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	get_tree().change_scene("res://UI/Scene/Credits.tscn")
