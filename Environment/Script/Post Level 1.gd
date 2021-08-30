extends Node2D

onready var dialogue = Dialogic.start("Post Level 1")

func _ready() -> void:
	add_child(dialogue)
	dialogue.connect("dialogic_signal",self,"dialogic_signal")

func dialogic_signal(argument):
	if argument == "post_level1_finished":
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	Global.player_position = Vector2(2560, 1672)
	Global.level_1_completed = true
	get_tree().change_scene("res://Environment/Scene/Front House.tscn")
