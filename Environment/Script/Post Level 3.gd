extends Node2D

var dialogue = Dialogic.start("Post Level 3")

func _ready() -> void:
	add_child(dialogue)
	dialogue.connect("dialogic_signal",self,"dialogic_signal")

func dialogic_signal(argument):
	if argument == "post_level3_finished":
		$"Scene Transition".transisi()



func _on_Scene_Transition_transisi_berjalan() -> void:
	Global.level_3_completed = true
	Global.player_position = Vector2(54.497,4557.017)
	get_tree().change_scene("res://Environment/Scene/Village.tscn")
