extends Node2D

func _ready() -> void:
	$"Bg Sound".play()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Enter") || Input.is_action_just_pressed("Space"):
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	get_tree().change_scene("res://UI/Scene/Main Menu.tscn")

func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://UI/Scene/Main Menu.tscn")
