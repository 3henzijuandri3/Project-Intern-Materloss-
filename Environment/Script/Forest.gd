extends Node2D

onready var marshall = $"YSort - Player/Marshall"
var tujuan = null


func _ready() -> void:
	marshall.inner_beam = false
	marshall.shriek = false
	marshall.dash = false
	
	$Forest.play()
	$Scary.play()

# Area2D untuk ke Front House #
func _on_To_Front_House_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		tujuan = "front_house"
		$"Scene Transition".transisi() 

# Function transisi scene #
func _on_Scene_Transition_transisi_berjalan() -> void: 
	if tujuan == "front_house":
		Global.player_position = Vector2(3176.327, 1687.942)
		get_tree().change_scene("res://Environment/Scene/Front House.tscn")

func _on_Forest_finished() -> void:
	$Forest.play()

func _on_Scary_finished() -> void:
	$Scary.play()
