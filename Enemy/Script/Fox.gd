extends KinematicBody2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite.play("Kanan")
		$"Body Collision".position = $"Posisi Kanan".position
		$"Body Collision".rotation_degrees = 42.7
	elif Input.is_action_just_pressed("ui_left"):
		$AnimatedSprite.play("Kiri")
		$"Body Collision".position = $"Posisi Kiri".position
		$"Body Collision".rotation_degrees = -42.7 
