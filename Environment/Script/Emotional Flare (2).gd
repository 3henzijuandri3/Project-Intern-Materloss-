extends Node2D

onready var needed = $"CanvasLayer/Level UI/Fragment/Fragment Needed"
onready var score = $"CanvasLayer/Level UI/Fragment/Fragment Score"
onready var health_bar = $"CanvasLayer/Level UI/Health"

var health = 2
var fragment_piece = 0
var dialogue = Dialogic.start("In Level 2")

func _ready() -> void:
	$"Bg Sound".play()
	needed.text = "/ 4"
	score.text = "0"
	
	$"YSort - Player/Marshall".speed = 0
	$"YSort - Player/Marshall".inner_beam = false
	$"YSort - Player/Marshall".dash = false
	$"YSort - Player/Marshall".shriek = false
	
	add_child(dialogue)
	dialogue.connect("dialogic_signal", self, "dialogic_signal")

func dialogic_signal(argument):
	if argument == "done_in_level2":
		$"YSort - Player/Marshall".speed = 400
		$"YSort - Player/Marshall".inner_beam = true
		$"YSort - Player/Marshall".dash = true
		$"YSort - Player/Marshall".shriek = true

func _process(_delta: float) -> void:
	health_system()
	fragment_system()




func health_system():
	if health == 0:
		health_bar.margin_right = 0
		
		$"CanvasLayer/Level UI/Restart".visible = true
		$"YSort - Player/Marshall".speed = 0
		$"YSort - Player/Marshall/AnimatedSprite".visible = false
		$"YSort - Player/Marshall/Detection Area/Anim Bawah".disabled = true
		$"YSort - Player/Marshall/Detection Area/Anim Depan".disabled = true
		$"YSort - Player/Marshall/Detection Area/Anim Kanan".disabled = true
		$"YSort - Player/Marshall/Detection Area/Anim Kiri".disabled = true
		
		$"YSort - Player/Weasel".speed = 0
		$"YSort - Player/Fox".speed = 0
		$"YSort - Player/Leopard".speed = 0
		$"YSort - Player/Weasel/AnimatedSprite".stop()
		$"YSort - Player/Fox/AnimatedSprite".stop()
		$"YSort - Player/Leopard/AnimatedSprite".stop()
		
	elif health == 1:
		health_bar.margin_right = 95
	elif health == 2:
		health_bar.margin_right = 190
	elif health == 3:
		health_bar.margin_right = 290


func _on_Health_Piece_get_health() -> void:
	health += 1
	$"Pickup Items".play()
	
func _on_Marshall_get_damage() -> void:
	health -= 1
	if health <=0:
		health = 0



func fragment_system():
	score.text = str(fragment_piece)
	if fragment_piece == 4:
		$"Scene Transition".transisi()
		$"YSort - Player/Weasel".speed = 0
		$"YSort - Player/Fox".speed = 0
		$"YSort - Player/Leopard".speed = 0
	
func _on_Fragment_Piece_get_fragment() -> void:
	fragment_piece += 1
	$"Pickup Items".play()



func _on_AudioStreamPlayer_finished() -> void:
	$"Bg Sound".play()

func _on_Scene_Transition_transisi_berjalan() -> void:
	get_tree().change_scene("res://Environment/Scene/Post Level 2.tscn")
