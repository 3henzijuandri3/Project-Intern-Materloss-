extends Control

var dialogue = Dialogic.start("Talk to Mom")

func _ready() -> void:
	add_child(dialogue)
	dialogue.connect("dialogic_signal",self,"dialogic_signal")

func dialogic_signal(argument):
	if argument == "done_talking":
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	Global.player_position = Vector2(273.337,712)
	get_tree().change_scene("res://Environment/Scene/Panda House.tscn")
