extends Node2D

onready var needed = $"UI/Level UI/Fragment/Fragment Needed"
onready var score = $"UI/Level UI/Fragment/Fragment Score"
onready var health_bar = $"UI/Level UI/Health"

var health = 2
var fragment_piece = 0
var finish = false


func _ready() -> void: 
	needed.text = "/ 3"
	score.text = "0"

func _process(_delta: float) -> void:
	health_system()
	fragment_system()




func health_system():
	if health == 0:
		$"UI/Level UI/Restart".visible = true
		
	if health == 1:
		health_bar.margin_right = 95
	elif health == 2:
		health_bar.margin_right = 190
	elif health == 3:
		health_bar.margin_right = 290

func fragment_system():
	score.text = str(fragment_piece)
	
	if fragment_piece == 3:
		finish = true

func _on_Health_Piece_get_health() -> void:
	health += 1

func _on_Fragment_Piece_get_fragment() -> void:
	fragment_piece += 1
