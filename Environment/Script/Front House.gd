extends Node2D

var tujuan = null

var spawn = null

func _ready() -> void:
	
	if spawn == "dari_forest":
		$"YSort - Player/Marshall".position.x = 3137.859
		$"YSort - Player/Marshall".position.y = 1671.12
		
	elif spawn == "dari rumah":
		$"YSort - Player/Marshall".position.x = 835.519
		$"YSort - Player/Marshall".position.y = 1823.86


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


func _on_Scene_Transition_transisi_berjalan() -> void:
	if tujuan == "house":
		get_tree().change_scene("res://Environment/Scene/Panda House.tscn")
	elif tujuan == "forest":
		get_tree().change_scene("res://Environment/Scene/Forest.tscn")


func _on_Marshall_to_front_house() -> void:
	spawn = "dari_forest"
	print("aaaaaaaaaaaaaaaaaaaaaaa")
