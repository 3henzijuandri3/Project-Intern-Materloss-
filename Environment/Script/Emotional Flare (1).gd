extends Node2D

onready var needed = $"UI/Level UI/Fragment/Fragment Needed"
onready var score = $"UI/Level UI/Fragment/Fragment Score"
onready var health_bar = $"UI/Level UI/Health"
onready var dialogue = Dialogic.start("In Level 1")

var health = 2
var fragment_piece = 0


func _ready() -> void:
	needed.text = "/ 3"
	score.text = "0"
	
	$"YSort - Player/Marshall".speed = 0
	$"YSort - Player/Marshall".inner_beam = false
	$"YSort - Player/Marshall".shriek = false
	$"YSort - Player/Marshall".dash = false
	
	add_child(dialogue)
	dialogue.connect("dialogic_signal", self, "dialogic_signal")

func _process(_delta: float) -> void:
	health_system()
	fragment_system()



func health_system():
	if health == 0:
		$"UI/Level UI/Restart".visible = true
		$"YSort - Player/Marshall/AnimatedSprite".visible = false
		$"YSort - Player/Marshall".speed = 0
		
		$"YSort - Player/Fox".speed = 0
		$"YSort - Player/Weasel".speed = 0
		$"YSort - Player/Fox/AnimatedSprite".stop()
		$"YSort - Player/Weasel/AnimatedSprite".stop()
		
	elif health == 1:
		health_bar.margin_right = 95
	elif health == 2:
		health_bar.margin_right = 190
	elif health == 3:
		health_bar.margin_right = 290
	elif health == 0:
		health_bar.margin_right = 0
	
func _on_Health_Piece_get_health() -> void:
	health += 1
	
func _on_Marshall_get_damage() -> void:
	health -= 1
	if health < 0:
		health = 0


func fragment_system():
	score.text = str(fragment_piece)
	
	if fragment_piece == 3:
		$"Scene Transition".transisi()
	
func _on_Fragment_Piece_get_fragment() -> void:
	fragment_piece += 1


func dialogic_signal(argument):
	if argument == "done_in_level1":
		$"YSort - Player/Marshall".speed = 400

func _on_Scene_Transition_transisi_berjalan() -> void:
	get_tree().change_scene("res://Environment/Scene/Post Level 1.tscn")
