extends KinematicBody2D

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		$AnimatedSprite.play("Bawah")
	elif Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite.play("Kanan")
	elif Input.is_action_just_pressed("ui_left"):
		$AnimatedSprite.play("Kiri")
	elif Input.is_action_just_pressed("ui_up"):
		$AnimatedSprite.play("Atas")

