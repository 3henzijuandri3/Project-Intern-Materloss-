extends Node2D

var dialogue = Dialogic.start("In Village")
var dialogue_2 = Dialogic.start("Level 3 Trigger")

var tujuan = null

func _ready() -> void:
	$"Bg Sound".play()
	$Scary.play()
	
	$"YSort - Player/Marshall".inner_beam = false
	$"YSort - Player/Marshall".dash = false
	$"YSort - Player/Marshall".shriek = false
	
	if Global.front_village == false:
		$"YSort - Player/Marshall".speed = 0
		add_child(dialogue)
		dialogue.connect("dialogic_signal", self, "dialogic_signal")

func _process(_delta: float) -> void:
	if Global.is_talk_to_sam == false:
		if $"YSort - Player/YSort - Ground/Paman Sam/Interact UI".visible == true && Input.is_action_just_pressed("Interact"):
			tujuan = "paman_sam"
			$"Scene Transition".transisi()
	elif Global.is_talk_to_sam == true:
		$"Fragment Trigger".visible = true
		$"Fragment Trigger/CollisionShape2D".disabled = false
	
	if Global.dialogue_trigger_level_3 == true:
		if $"Fragment Trigger/Interact UI".visible == true && Input.is_action_just_pressed("Interact"):
			tujuan = "level_3"
			$"Emo Trigger".play()
	
	if Global.level_3_completed == true:
		$"Fragment Trigger".visible = false
		$"Fragment Trigger/CollisionShape2D".disabled = true
		$"Wall Vilage/Blokade Forest".disabled = true

func dialogic_signal(argument):
	if argument == "done_village":
		$"YSort - Player/Marshall".speed = 400
		Global.front_village = true
	elif argument == "done_level3_trigger":
		$"YSort - Player/Marshall".speed = 400
		Global.dialogue_trigger_level_3 = true



func _on_Fragment_Trigger_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Fragment Trigger/Interact UI".visible = true
		
		if Global.dialogue_trigger_level_3 == false:
			$"YSort - Player/Marshall".speed = 0
			add_child(dialogue_2)
			dialogue_2.connect("dialogic_signal", self, "dialogic_signal")


func _on_Fragment_Trigger_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Fragment Trigger/Interact UI".visible = false



# Area2D ke Forest #
func _on_To_Forest_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		tujuan = "forest"
		$"Scene Transition".transisi()

func _on_Scene_Transition_transisi_berjalan() -> void:
	if tujuan == "paman_sam":
		get_tree().change_scene("res://NPC/Scene/Dialogue With Sam.tscn")
	elif tujuan == "forest":
		Global.player_position = Vector2(7752,1447.5)
		get_tree().change_scene("res://Environment/Scene/Forest.tscn")
	elif tujuan == "level_3":
		get_tree().change_scene("res://Environment/Scene/Pre Level 3.tscn")




func _on_Bg_Sound_finished() -> void:
	$"Bg Sound".play()

func _on_Scary_finished() -> void:
	$Scary.play()

func _on_Emo_Trigger_finished() -> void:
	$"Scene Transition".transisi()
