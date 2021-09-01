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
var speed = 300
var i = 0
onready var marshall = get_node("/root/Emotional Flare (3)/YSort - Player/Marshall")


# Variabel Stun untuk signal stun_enemy(value) dari player #
var stun = false



func _physics_process(_delta: float) -> void:
	
	# State BAWAH, ATAS,  atau TRIGGER akan dijalankan saat stun tidak terjadi #
	if stun == false :
		match state:
			
			# State Horizontal, Fox bergerak kanan kiri #
			HORIZONTAL:
				speed = 250
				horizontal()
			
			# State TRIGGER, Fox bergerak ke arah player
			TRIGGER:
				speed = 300
				trigger()
				
		
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
			
			$"Body Collision".position = $"Posisi Kiri".position
			$"Body Collision".rotation_degrees = -43
		
		elif velocity.x > 0: 
			$AnimatedSprite.play("Kanan")
			
			$"Body Collision".position = $"Posisi Kanan".position
			$"Body Collision".rotation_degrees = 43
	
	elif state == TRIGGER:
		if $Kanan.is_colliding():
			$AnimatedSprite.play("Kanan")
			
			$"Body Collision".position = $"Posisi Kanan".position
			$"Body Collision".rotation = 42.7
		
		elif $Kiri.is_colliding():
			$AnimatedSprite.play("Kiri")
			$"Body Collision".position = $"Posisi Kiri".position
			$"Body Collision".rotation = -42.7



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
	if marshall:
		var direction = (marshall.position - position).normalized()
		direction = move_and_slide(direction * speed)

func _on_Trigger_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		state = TRIGGER

func _on_Trigger_Area_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		state = HORIZONTAL
		i = 0



# Function Stun signal dari player #
func _on_Marshall_stun_enemy(value) -> void:
	if value == "Fox":
		stun = true 
		$"Stun Timer".start()
	
func _on_Stun_Timer_timeout() -> void:
	stun = false
