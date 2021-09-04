extends Node2D

onready var marshall = get_node("/root/Panda House/YSort/Marshall")

var tujuan = null
var dialogue = Dialogic.start("Epilog")

func _ready() -> void:
	marshall.light = false
	marshall.inner_beam = false
	marshall.shriek = false
	marshall.dash = false
	
	if Global.level_1_completed == true && Global.level_2_completed == true && Global.level_3_completed == true:
		$"Bloody Screen".muncul_darah()
		$"Final Detection/Detection area".disabled = false
		
		$"Tempat Tidur/Mayat".visible = true
		$"Tempat Tidur/blood_c_0001-removebg-preview".visible = true
		$"Tempat Tidur/blood_c_0001-removebg-preview2".visible = true
		
		$YSort/Mom.visible = false
		$"YSort/Mom/Detection Area/CollisionShape2D".disabled = true
		$YSort/Mom/CollisionShape2D.disabled = true


func _process(_delta: float) -> void:
	if $"YSort/Mom/Interact UI".visible == true:
		if Input.is_action_just_pressed("Interact"):
			tujuan = "dialog"
			Global.is_talk_to_mom = true
			$"Scene Transition".transisi()



func _on_Final_Detection_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$YSort/Marshall.speed = 0
		add_child(dialogue)
		dialogue.connect("dialogic_signal",self,"dialogic_signal")
		$Final.play()


func dialogic_signal(argument):
	if argument == "the_end":
		if Global.turnips != 3:
			tujuan = "credits"
			$"Scene Transition".transisi()
		elif Global.turnips == 3:
			tujuan = "explain"
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
	elif tujuan == "credits":
		get_tree().change_scene("res://UI/Scene/Credits.tscn")
	elif tujuan == "explain":
		get_tree().change_scene("res://Environment/Scene/Explain.tscn")







