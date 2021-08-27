extends Node2D

var tujuan = null
var dialogue = Dialogic.start("Front House")


## Function dialogue di Front House #
func _ready() -> void:
	if Global.dialogue_front_door == true:
		add_child(dialogue)
		dialogue.connect("dialogic_signal",self,"dialogic_signal")

func dialogic_signal(argument):
	if argument == "done_front_house":
		Global.dialogue_front_door = false


# Function Perpindahan maps #
# Area2D untuk ke Panda House #
func _on_Pintu_Masuk_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		tujuan = "house"
		$"Scene Transition".transisi()

# Area2D untuk ke Forest #
func _on_To_Forest_body_entered(body: Node) -> void:
		if body.is_in_group("Player"):
			tujuan = "forest"
			$"Scene Transition".transisi()

# Function perpindahan scene sesuai tujuan #
func _on_Scene_Transition_transisi_berjalan() -> void:
	if tujuan == "house":
		Global.player_position = Vector2(1456, 824)
		get_tree().change_scene("res://Environment/Scene/Panda House.tscn")
	elif tujuan == "forest":
		Global.player_position = Vector2(1384, 1464)
		get_tree().change_scene("res://Environment/Scene/Forest.tscn")



