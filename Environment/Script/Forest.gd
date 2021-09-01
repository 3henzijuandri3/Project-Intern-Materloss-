extends Node2D

onready var marshall = $"YSort - Player/Marshall"
var tujuan = null
var dialogue = Dialogic.start("Level 2 Trigger")

func _ready() -> void:
	marshall.inner_beam = false
	marshall.shriek = false
	marshall.dash = false
	
	$Forest.play()
	$Scary.play()

func _process(_delta: float) -> void:
	if Global.dialogue_trigger_level_2 == true:
		if $"Fragment Trigger/Interact UI".visible == true && Input.is_action_just_pressed("Interact"):
			$Transisi.play()
	if Global.level_2_completed == true:
		$"YSort - Player/YSort - Atas/Wall Atas/Blokade Village".disabled = true
		$"Fragment Trigger".visible = false
		$"Fragment Trigger/CollisionShape2D".disabled = true


func dialogic_signal(argument):
	if argument == "done_level2_trigger":
		$"YSort - Player/Marshall".speed = 400
		Global.dialogue_trigger_level_2 = true

# Area2D untuk ke Emotional Flare (2) #
func _on_Fragment_Trigger_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Fragment Trigger/Interact UI".visible = true
		tujuan = "level_2"
		
		if Global.dialogue_trigger_level_2 == false:
			$"YSort - Player/Marshall".speed = 0
			add_child(dialogue)
			dialogue.connect("dialogic_signal",self,"dialogic_signal")

func _on_Fragment_Trigger_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Fragment Trigger/Interact UI".visible = false


# Area2D untuk ke Front House #
func _on_To_Front_House_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		tujuan = "front_house"
		$"Scene Transition".transisi()

# Area2D ke Village #
func _on_To_Village_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		tujuan = "village"
		$"Scene Transition".transisi()


# Function transisi scene #
func _on_Scene_Transition_transisi_berjalan() -> void: 
	if tujuan == "front_house":
		Global.player_position = Vector2(3176.327, 1687.942)
		get_tree().change_scene("res://Environment/Scene/Front House.tscn")
	elif tujuan == "level_2":
		get_tree().change_scene("res://Environment/Scene/Pre Level 2.tscn")
	elif tujuan == "village":
		Global.player_position = Vector2(104,6595.605)
		get_tree().change_scene("res://Environment/Scene/Village.tscn")

func _on_Forest_finished() -> void:
	$Forest.play()

func _on_Scary_finished() -> void:
	$Scary.play()

func _on_Transisi_finished() -> void:
	$"Scene Transition".transisi()


