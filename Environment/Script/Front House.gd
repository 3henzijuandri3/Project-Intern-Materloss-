extends Node2D

var tujuan = null
var dialogue = Dialogic.start("Front House")
var dialogue_2 = Dialogic.start("Level 1 Trigger")
onready var marshall = $"YSort - Player/Marshall"


func _process(_delta: float) -> void:
	if Global.dialogue_tigger_level_1 == true:
		if $"Fragment Trigger/Interact UI".visible == true && Input.is_action_just_pressed("Interact"):
			$Transisi.play()
	if Global.level_1_completed == true:
		$"Fragment Trigger".visible = false
		$"Fragment Trigger/CollisionShape2D".disabled = true
		$"YSort - Player/YSort - Kanan/Wall Kanan/Blokade ke forest".disabled = true


# Function dialogue yang ada di Front House #
func _ready() -> void:
	marshall.inner_beam = false
	marshall.shriek = false
	marshall.dash = false
	
	if Global.dialogue_front_door == false:
		marshall.speed = 0
		add_child(dialogue)
		dialogue.connect("dialogic_signal",self,"dialogic_signal")
	
	$Forest.play()
	$Scary.play()

func dialogic_signal(argument):
	if argument == "done_front_house":
		Global.dialogue_front_door = true
		$"YSort - Player/Marshall".speed = 400
	elif argument == "done_level_1":
		Global.dialogue_tigger_level_1 = true
		$"YSort - Player/Marshall".speed = 400


# Function Perpindahan maps #
# Area2D untuk ke Emotional Flare #
func _on_Fragment_Trigger_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		tujuan = "level_1"
		$"Fragment Trigger/Interact UI".visible = true
		
		if Global.dialogue_tigger_level_1 == false:
			marshall.speed = 0
			add_child(dialogue_2)
			dialogue_2.connect("dialogic_signal",self,"dialogic_signal")

func _on_Fragment_Trigger_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Fragment Trigger/Interact UI".visible = false

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
	elif tujuan == "level_1":
		get_tree().change_scene("res://Environment/Scene/Pre Level 1 Dialogue.tscn")

func _on_Transisi_finished() -> void:
	$"Scene Transition".transisi()

func _on_Forest_finished() -> void:
	$Forest.play()

func _on_Scary_finished() -> void:
	$Scary.play()
