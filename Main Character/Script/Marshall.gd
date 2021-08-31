extends KinematicBody2D

# Variable Abilities #
var light = true
var dash = true
var inner_beam = true
var shriek = true
signal stun_enemy(value)
signal inner_beam_on
signal shriek_on
signal dash_on

# Variable Movement #
var speed = 400
var velocity = Vector2()
var is_walking = false
var audio = false

# Variable get damage #
signal get_damage
const whiten_duration = 0.15
export (ShaderMaterial) var whiten_material
var is_invincible = false


func _physics_process(_delta: float) -> void:
	movement()
	animasi()
	fix_collision()
	abilities()
	is_light_on()
	invincible()
	walking_sound()


# Func ready untuk setiap awal level #
func _ready() -> void:
	$AnimatedSprite.play("Idle Bawah")
	$"Body Collision".position = $"Posisi Bawah".position
	$"Detection Area/Anim Bawah".disabled = false
	$"Detection Area/Anim Depan".disabled = true
	$"Detection Area/Anim Kiri".disabled = true
	$"Detection Area/Anim Kanan".disabled = true
	
	position = Global.player_position
	#whiten_material.set_shader_param("whiten", false)



# Function jalan #
func walking_sound():
	if velocity != Vector2.ZERO && !$"Walking Sound".playing:
		$"Walking Sound".play()
	else:
		pass


# Function agar light tidak menyala di rumah #
func is_light_on():
	if light == true:
		$Light2D.visible = true
	elif light == false:
		$Light2D.visible = false



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
	
	if velocity != Vector2.ZERO:
		is_walking = true
	elif velocity == Vector2.ZERO:
		is_walking = false

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
			
			emit_signal("inner_beam_on")
			inner_beam = false
			$Light2D.texture_scale = 2.5
			
			$"Inner Beam Timer".start()
			$"Inner Beam Cooldown".start()
	
	if dash == true:
		if Input.is_action_just_pressed("Desperate Dash") && (
			Input.is_action_pressed("ui_right") || 
			Input.is_action_pressed("ui_left") || 
			Input.is_action_pressed("ui_up") || 
			Input.is_action_pressed("ui_down")):
			
			emit_signal("dash_on")
			dash = false
			speed = 700
			
			$"Dash Timer".start()
			$"Dash Cooldown".start()
	
	if shriek == true:
		if Input.is_action_just_pressed("Shriek"):
			
			emit_signal("shriek_on")
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
	speed = 300
	$"Dash Side Effect Timer".start()

func _on_Dash_Side_Effect_Timer_timeout() -> void:
	speed = 400

func _on_Dash_Cooldown_timeout() -> void:
	dash = true


# Timer Shriek #
func _on_Shriek_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Enemy"):
		var nama = body.name
		emit_signal("stun_enemy", nama)

func _on_Shriek_Timer_timeout() -> void:
	$Light2D.color = "ffffff"
	$"Shriek Area/Shriek Collision".disabled = true

func _on_Shriek_Cooldown_timeout() -> void:
	shriek = true



# Function menerima damage dari enemy #
func _on_Detection_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Enemy"):
		$"Get Hit".play()
		is_invincible = true
		emit_signal("get_damage")
		blink_effect()
		
		$"Blink Timer".start()
		$"Blink Duration".start()

func invincible():
	if is_invincible == true:
		$"Detection Area/Anim Bawah".disabled = true
		$"Detection Area/Anim Depan".disabled = true
		$"Detection Area/Anim Kanan".disabled = true
		$"Detection Area/Anim Kiri".disabled = true
	else:
		$"Detection Area/Anim Bawah".disabled = false
		$"Detection Area/Anim Depan".disabled = false
		$"Detection Area/Anim Kanan".disabled = false
		$"Detection Area/Anim Kiri".disabled = false

func blink_effect():
	whiten_material.set_shader_param("whiten", true)
	$"Whiten Duration".start()

func _on_Whiten_Duration_timeout() -> void:
	whiten_material.set_shader_param("whiten", false)

func _on_Blink_Timer_timeout() -> void:
	$AnimatedSprite.visible = !$AnimatedSprite.visible

func _on_Blink_Duration_timeout() -> void:
	$"Blink Timer".stop()
	$AnimatedSprite.visible = true
	is_invincible = false



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


#######################################################

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



