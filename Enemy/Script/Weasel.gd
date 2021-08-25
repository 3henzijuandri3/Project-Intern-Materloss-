extends KinematicBody2D


# NOTE : SIGNAL STUN DAN TRIGGER BELUM


# Variabel state Weasel #
enum {
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


func _physics_process(_delta: float) -> void:
	# State PATROL atau TRIGGER akan dijalankan saat stun tidak terjadi #
	if stun == false:
		match state :
			
			# State PATROL, Weasel bergerak persegi
			PATROL:
				gerak_persegi()
			
			# State TRIGGER, Weasel bergerak ke arah player sampai player keluar dari Trigger Area 
			TRIGGER:
				speed = 200
				pass
				#trigger()
	
	# Weasel tidak dapat bergerak saat stun #
	elif stun == true:
		velocity = move_and_slide(Vector2.ZERO)



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
	pass

func _on_Trigger_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		state = TRIGGER

func _on_Trigger_Area_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		state = PATROL
		i = 0



# Function Stun signal dari Player #
func _on_Stun_Timer_timeout() -> void:
	pass # Replace with function body.




