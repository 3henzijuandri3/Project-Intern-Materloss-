extends Node2D

onready var needed = $"CanvasLayer/Level UI/Fragment/Fragment Needed"
onready var score = $"CanvasLayer/Level UI/Fragment/Fragment Score"
onready var health_bar = $"CanvasLayer/Level UI/Health"

var health = 2
var fragment_piece = 0

func _ready() -> void:
	needed.text = "/ 4"
	score.text = "0"

func _process(_delta: float) -> void:
	health_system()
	fragment_system()


func health_system():
	if health == 0:
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
	elif health == 0:
		health_bar.margin_right = 0
	
func _on_Health_Piece_get_health() -> void:
	health += 1
	
func _on_Marshall_get_damage() -> void:
	health -= 1
	if health <=0:
		health = 0


func fragment_system():
	score.text = str(fragment_piece)
	if fragment_piece == 4:
		pass
	
func _on_Fragment_Piece_get_fragment() -> void:
	fragment_piece += 1


