extends KinematicBody2D

onready var marshall = get_node("/root/Emotional Flare (3)/YSort - Player/Marshall")

var stun = false

enum {
	KANAN,
	KIRI,
	ATAS,
	BAWAH,
	PATROL
}
var state = PATROL

# Variable Movement #
var speed = 200
var velocity = Vector2()

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO
	
	if stun == false:
		match state:
			PATROL:
				move_to_marshall()
			KANAN:
				move_to_marshall()
			KIRI:
				move_to_marshall()
			ATAS:
				move_to_marshall()
			BAWAH:
				move_to_marshall()
	elif stun == true:
		velocity = move_and_slide(Vector2.ZERO)
	
	animasi()
	change_state()



# Function animasi #
func animasi():
	
	if state == PATROL:
		$AnimatedSprite.play("Bawah")
	elif state == KIRI:
		$AnimatedSprite.play("Kiri")
	elif state == ATAS:
		$AnimatedSprite.play("Atas")
	elif state == BAWAH:
		$AnimatedSprite.play("Bawah")
	elif state == KANAN:
		$AnimatedSprite.play("Kanan")


# Function movement Demon Panda #
func move_to_marshall():
	if marshall:
		var direction = (marshall.position - position).normalized()
		direction = move_and_slide(direction * speed)

func change_state():
	if $Kanan.is_colliding():
		state = KANAN
	elif $Kiri.is_colliding():
		state = KIRI
	elif $Atas.is_colliding():
		state = ATAS
	elif $Bawah.is_colliding():
		state = BAWAH


# Timer Stun signal dari Player #
func _on_Marshall_stun_enemy(value) -> void:
	if value == "Demon Panda":
		$"Stun Timer".start()
		stun = true

func _on_Stun_Timer_timeout() -> void:
	stun = false
