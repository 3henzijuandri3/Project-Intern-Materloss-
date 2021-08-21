extends KinematicBody2D

var speed = 200
var velocity = Vector2()


func _physics_process(_delta: float) -> void:
	movement()
	animasi()


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
			$AnimatedSprite.play("Samping")
			$AnimatedSprite.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite.play("Samping")
			$AnimatedSprite.flip_h = true
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
			$AnimatedSprite.play("Idle Samping")
			$AnimatedSprite.flip_h = false
		elif Input.is_action_just_released("ui_left"):
			$AnimatedSprite.play("Idle Samping")
			$AnimatedSprite.flip_h = true
			
