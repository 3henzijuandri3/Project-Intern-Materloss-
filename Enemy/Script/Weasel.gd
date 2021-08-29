extends KinematicBody2D

# Variabel state Weasel #
enum {
	IDLE,
	PATROL,
	TRIGGER
}
var state = PATROL 
var move_patrol = true

# Variabel Movement #
#onready var mainChar = get_node("/root/Hutan/Player")
var velocity = Vector2()
var speed = 200
var i = 0

# Variabel Stun untuk signal stun_enemy(value) dari player #
var stun = false


onready var marshall = get_node("/root/Emotional Flare (1)/YSort - Player/Marshall")


func _physics_process(_delta: float) -> void:
	# State PATROL atau TRIGGER akan dijalankan saat stun tidak terjadi #
	if stun == false:
		match state :
			
			# State IDLE #
			IDLE:
				speed = 0
				$AnimatedSprite.stop()
			
			# State PATROL, Weasel bergerak persegi
			PATROL:
				speed = 230
				gerak_persegi()
			
			# State TRIGGER, Weasel bergerak ke arah player sampai player keluar dari Trigger Area 
			TRIGGER:
				speed = 280
				trigger()
	
	# Weasel tidak dapat bergerak saat stun #
	elif stun == true:
		velocity = move_and_slide(Vector2.ZERO)
		$AnimatedSprite.stop()
	
	animasi()



# Function animasi #
func animasi():
	if state == PATROL:
		if velocity.x > 0:
			$AnimatedSprite.play("Kanan")
			$"Body Collision".position = $Kanan.position
		elif velocity.x < 0:
			$AnimatedSprite.play("Kiri")
			$"Body Collision".position = $Kiri.position
		elif velocity.y > 0:
			$AnimatedSprite.play("Bawah")
			$"Body Collision".position = $Depan.position
		elif velocity.y < 0:
			$AnimatedSprite.play("Depan")
			$"Body Collision".position = $Depan.position
	
	elif state == TRIGGER:
		if $"Trigger Kanan".is_colliding():
			$AnimatedSprite.play("Kanan")
			$"Body Collision".position = $Kanan.position
		elif $"Trigger Kiri".is_colliding():
			$AnimatedSprite.play("Kiri")
			$"Body Collision".position = $Kiri.position
		elif $"Trigger Atas".is_colliding():
			$AnimatedSprite.play("Depan")
			$"Body Collision".position = $Depan.position
		elif $"Trigger Bawah".is_colliding():
			$AnimatedSprite.play("Bawah")
			$"Body Collision".position = $Depan.position



# Function PATROL state #
func gerak_persegi():
	var ATAS = Vector2(0, -1)
	var BAWAH = Vector2(0, 1)
	var KANAN = Vector2(1,0)
	var KIRI = Vector2(-1,0)
	var gerak = [KIRI, ATAS, KANAN, BAWAH] # Array gerak
	velocity = move_and_slide(gerak[i]*speed)
	
	if move_patrol == true:
		$"Patrol Timer".start()
		move_patrol = false

func _on_Patrol_Timer_timeout() -> void:
	move_patrol = true
	
	i += 1
	if i > 3:
		i = 0



# Function TRIGGER state #
func trigger():
	if marshall:
		var direction = (marshall.position - position).normalized()
		direction = move_and_slide(direction * speed)

func _on_Trigger_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		state = TRIGGER

func _on_Trigger_Area_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		state = PATROL
		i = 0



# Function Stun signal dari Player #
func _on_Marshall_stun_enemy(value) -> void:
	if value == "Weasel":
		stun = true 
		$"Stun Timer".start()

func _on_Stun_Timer_timeout() -> void:
	stun = false
