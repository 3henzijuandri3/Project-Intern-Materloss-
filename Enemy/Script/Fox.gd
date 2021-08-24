extends KinematicBody2D

# Variabel state Fox #
enum {
	HORIZONTAL,
	TRIGGER
}
var state = HORIZONTAL 
var move_horizontal = true


# Variabel Movement #
#onready var mainChar = get_node("/root/Hutan/Player")
var velocity = Vector2()
var speed = 150
var i = 0


# Variabel Stun untuk signal stun_enemy(value) dari player #
var stun = false


func _physics_process(_delta: float) -> void:
	
	# State BAWAH, ATAS,  atau TRIGGER akan dijalankan saat stun tidak terjadi #
	if stun == false :
		match state:
			
			# State Horizontal, Fox bergerak kanan kiri #
			HORIZONTAL:
				horizontal()
			
			# State TRIGGER, Fox bergerak ke arah player
			TRIGGER:
				pass
				#trigger_move()
		
		# Menjalankan function Animasi
		animasi()
	
	# Fox tidak dapat bergerak saat stun #
	elif stun == true:
		velocity = move_and_slide(Vector2.ZERO)
		$AnimatedSprite.stop()


# Function Animasi
func animasi():
	if state == HORIZONTAL:
		if velocity.x < 0:
			$AnimatedSprite.play("Kiri")
		elif velocity.x > 0: 
			$AnimatedSprite.play("Kanan")
			
	elif state == TRIGGER:
		if $Kanan.is_colliding():
			$AnimatedSprite.play("Kanan")
		elif $Kiri.is_colliding():
			$AnimatedSprite.play("Kiri")


# Function HORIZONTAL state #
func horizontal():
	var KANAN = Vector2(1,0)
	var KIRI = Vector2(-1,0)
	var horizontal_move = [KANAN, KIRI]
	velocity = move_and_slide(horizontal_move[i]*speed)
	
	if move_horizontal == true:
		$"Horizontal Timer".start()
		move_horizontal = false

func _on_Horizontal_Timer_timeout() -> void:
	move_horizontal = true
	
	i += 1
	if i > 1:
		i = 0


# Function Trigger #
func trigger():
	pass
