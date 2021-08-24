extends KinematicBody2D

# Variable Abilities #
var dash = true
var inner_beam = true
var shriek = true

# Variable Movement #
var speed = 350
var velocity = Vector2()



func _physics_process(_delta: float) -> void:
	movement()
	animasi()
	fix_collision()
	abilities()

# Func ready untuk setiap awal level #
func _ready() -> void:
	$AnimatedSprite.play("Idle Bawah")
	$"Body Collision".position = $"Posisi Bawah".position
	$"Detection Area/Anim Bawah".disabled = false
	$"Detection Area/Anim Depan".disabled = true
	$"Detection Area/Anim Kiri".disabled = true
	$"Detection Area/Anim Kanan".disabled = true


# Func pergerakan Marshall #
func movement():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * speed)


# Func animasi Marshall #
func animasi():
	
	if velocity != Vector2.ZERO:
		if velocity.x > 0:
			$AnimatedSprite.play("Kanan")
		elif velocity.x < 0:
			$AnimatedSprite.play("Kiri")
		elif velocity.y > 0:
			$AnimatedSprite.play("Bawah")
		elif velocity.y < 0:
			$AnimatedSprite.play("Depan")
	
	else:
		if Input.is_action_just_released("ui_up"):
			$AnimatedSprite.play("Idle Depan")
		elif Input.is_action_just_released("ui_down"):
			$AnimatedSprite.play("Idle Bawah")
		elif Input.is_action_just_released("ui_right"):
			$AnimatedSprite.play("Idle Kanan")
		elif Input.is_action_just_released("ui_left"):
			$AnimatedSprite.play("Idle Kiri")


# Func abilities Marshall #
func abilities():
	
	if inner_beam == true:
		if Input.is_action_just_pressed("Inner Beam"):
			
			inner_beam = false
			$Light2D.texture_scale = 2.2
			
			$"Inner Beam Timer".start()
			$"Inner Beam Cooldown".start()
	
	if dash == true:
		if Input.is_action_just_pressed("Desperate Dash") && (
			Input.is_action_pressed("ui_right") || 
			Input.is_action_pressed("ui_left") || 
			Input.is_action_pressed("ui_up") || 
			Input.is_action_pressed("ui_down")):
			
			dash = false
			speed = 600
			
			$"Dash Timer".start()
			$"Dash Cooldown".start()
	
	if shriek == true:
		if Input.is_action_just_pressed("Shriek"):
			
			shriek = false
			$Light2D.color = "0194ff"
			$"Shriek Area/Shriek Collision".disabled = false
			$"Shriek Timer".start()
			$"Shriek Cooldown".start()


# Timer Inner Beam #
func _on_Inner_Beam_Timer_timeout() -> void:
	$Light2D.texture_scale = 1.5

func _on_Inner_Beam_Cooldown_timeout() -> void:
	inner_beam = true


# Timer Desperate Dash #
func _on_Dash_Timer_timeout() -> void:
	speed = 200
	$"Dash Side Effect Timer".start()

func _on_Dash_Side_Effect_Timer_timeout() -> void:
	speed = 300

func _on_Dash_Cooldown_timeout() -> void:
	dash = true


# Timer Shriek #
func _on_Shriek_Timer_timeout() -> void:
	$Light2D.color = "ffffff"
	$"Shriek Area/Shriek Collision".disabled = true

func _on_Shriek_Cooldown_timeout() -> void:
	shriek = true


# Func memperbaiki collision saat player bergerak #
func fix_collision():
	if velocity.x > 0:
		$"Body Collision".position = $"Posisi Samping".position
		$"Detection Area/Anim Kanan".disabled = false
		$"Detection Area/Anim Bawah".disabled = true
		$"Detection Area/Anim Kiri".disabled = true
		$"Detection Area/Anim Depan".disabled = true
			
	elif velocity.x < 0:
		$"Body Collision".position = $"Posisi Samping".position
		$"Detection Area/Anim Kiri".disabled = false
		$"Detection Area/Anim Depan".disabled = true
		$"Detection Area/Anim Bawah".disabled = true
		$"Detection Area/Anim Kanan".disabled = true
			
	elif velocity.y > 0:
		$"Body Collision".position = $"Posisi Bawah".position
		$"Detection Area/Anim Bawah".disabled = false
		$"Detection Area/Anim Depan".disabled = true
		$"Detection Area/Anim Kiri".disabled = true
		$"Detection Area/Anim Kanan".disabled = true
			
	elif velocity.y < 0:
		$"Body Collision".position = $"Posisi Bawah".position
		$"Detection Area/Anim Depan".disabled = false
		$"Detection Area/Anim Bawah".disabled = true
		$"Detection Area/Anim Kiri".disabled = true
		$"Detection Area/Anim Kanan".disabled = true

# Unused Function #
func debug_collision():
	if $"Detection Area/Anim Bawah".disabled == false :
		$"Detection Area/Anim Bawah".visible = true
		$"Detection Area/Anim Depan".visible = false
		$"Detection Area/Anim Kiri".visible = false
		$"Detection Area/Anim Kanan".visible = false
		print("Bawah berjalan")
		
	if $"Detection Area/Anim Depan".disabled == false :
		$"Detection Area/Anim Depan".visible = true
		$"Detection Area/Anim Bawah".visible = false
		$"Detection Area/Anim Kiri".visible = false
		$"Detection Area/Anim Kanan".visible = false
		print("Depan berjalan")
		
	if $"Detection Area/Anim Kanan".disabled == false :
		$"Detection Area/Anim Kanan".visible = true
		$"Detection Area/Anim Bawah".visible = false
		$"Detection Area/Anim Depan".visible = false
		$"Detection Area/Anim Kiri".visible = false
		print("Kanan berjalan")
		
	if $"Detection Area/Anim Kiri".disabled == false:
		$"Detection Area/Anim Kiri".visible = true
		$"Detection Area/Anim Bawah".visible = false
		$"Detection Area/Anim Depan".visible = false
		$"Detection Area/Anim Kanan".visible = false
		print("Kiri berjalan")


