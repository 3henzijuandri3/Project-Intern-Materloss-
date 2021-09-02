extends KinematicBody2D

# Variabel state Leopard #
enum{
	IDLE,
	TRIGGER
}
var state = IDLE 

# Variabel Movement #
var velocity = Vector2()
var speed = 330
onready var marshall = get_node("/root/Emotional Flare (2)/YSort - Player/Marshall")

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
				speed = 330
				trigger()
	
	# Leopard tidak dapat bergerak saat stun #
	elif stun == true:
		velocity = move_and_slide(Vector2.ZERO)
		$AnimatedSprite.stop()
	
	animasi()



# Function animasi #
func animasi():
	if state == TRIGGER:
		
		if $Kanan.is_colliding():
			$AnimatedSprite.play("Kanan")
			$"Body Collision".position = $"Posisi Kanan".position
		elif $Kiri.is_colliding():
			$AnimatedSprite.play("Kiri")
			$"Body Collision".position = $"Posisi Kiri".position
		elif $Atas.is_colliding():
			$AnimatedSprite.play("Depan")
			$"Body Collision".position = $"Posisi Depan".position
		elif $Bawah.is_colliding():
			$AnimatedSprite.play("Bawah")
			$"Body Collision".position = $"Posisi Bawah".position
	
	elif state == IDLE:
		$AnimatedSprite.stop()

# Function state TRIGGER #
func trigger():
	if marshall:
		var direction = (marshall.position - position).normalized()
		direction = move_and_slide(direction * speed)

func _on_Trigger_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		state = TRIGGER
		$"Trigger Timer".start()

func _on_Trigger_Timer_timeout() -> void:
	state = IDLE



# Function Stun signal dari Player #
func _on_Marshall_stun_enemy(value) -> void:
	if value == "Leopard":
		stun = true
		$"Stun Timer".start()

func _on_Stun_Timer_timeout() -> void:
	stun = false
