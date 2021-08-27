extends Node2D

onready var marshall = get_node("/root/Panda House/YSort/Marshall")

var tujuan = null

func _ready() -> void:
	marshall.light = false

func _process(_delta: float) -> void:
	if $"YSort/Mom/Interact UI".visible == true:
		if Input.is_action_just_pressed("Interact"):
			tujuan = "dialog"
			Global.is_talk_to_mom = true
			$"Scene Transition".transisi()

func _on_Pintu_Keluar_body_entered(body: Node) -> void:
	if Global.is_talk_to_mom == true:
		if body.is_in_group("Player"):
			tujuan = "front_house"
			$"Scene Transition".transisi()
	else:
		if body.is_in_group("Player"):
			$"Mom Pop Out".visible = true

func _on_Pintu_Keluar_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Mom Pop Out".visible = false

func _on_Scene_Transition_transisi_berjalan() -> void:
	if tujuan == "front_house":
		Global.player_position = Vector2(839.294, 1786.11)
		get_tree().change_scene("res://Environment/Scene/Front House.tscn")
	elif tujuan == "dialog":
		get_tree().change_scene("res://NPC/Scene/Dialogue With Mom.tscn")


