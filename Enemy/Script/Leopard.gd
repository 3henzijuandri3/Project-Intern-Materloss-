extends KinematicBody2D


# NOTE : SIGNAL STUN DAN TRIGGER BELUM


# Variabel state Leopard #
enum{
	IDLE,
	TRIGGER
}
var state = IDLE 

# Variabel Movement #
#onready var mainChar = get_node("/root/Hutan/Player")
var velocity = Vector2()
var speed = 0

# Variabel Stun untuk signal stun_enemy(value) dari player #
var stun = false



func _physics_process(_delta: float) -> void:
	# State IDLE atau TRIGGER akan dijalankan saat stun tidak terjadi #
	if stun == false:
		match state:
			
			# State IDLE, Leopard diam
			IDLE:
				$".".velocity = Vector2.ZERO
			
			# State TRIGGER, Leopard bergerak ke arah player selama 5 dtk, lalu Leopard akan diam
			TRIGGER:
				speed = 180
				pass
				#trigger()
	
	# Leopard tidak dapat bergerak saat stun #
	elif stun == true:
		velocity = move_and_slide(Vector2.ZERO)



# Function state TRIGGER #
func trigger():
	pass

func _on_Trigger_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		state = TRIGGER
		$"Trigger Timer".start()

func _on_Trigger_Timer_timeout() -> void:
	state = IDLE



# Function Stun signal dari Player #
func _on_Stun_Timer_timeout() -> void:
	pass # Replace with function body.
