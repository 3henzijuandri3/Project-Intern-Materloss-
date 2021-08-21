extends KinematicBody2D

var speed = 200
var velocity = Vector2()


func _ready() -> void:
	$AnimatedSprite.play("Idle Bawah")
	$"Body Collision".position = $"Posisi Bawah".position
	$"Detection Area/Anim Bawah".disabled = false
	$"Detection Area/Anim Depan".disabled = true
	$"Detection Area/Anim Kiri".disabled = true
	$"Detection Area/Anim Kanan".disabled = true
	

func _physics_process(_delta: float) -> void:
	movement()
	animasi()
	fix_collision()
	#debug()


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


func debug():
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
