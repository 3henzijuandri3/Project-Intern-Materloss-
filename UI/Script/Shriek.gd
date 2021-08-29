extends TextureButton

onready var time_label = $Counter/Value

var cooldown = 20.0

func _ready():
	$"Shriek Timer".wait_time = cooldown
	time_label.hide()
	$Sweep.texture_progress = texture_normal
	$Sweep.value = 0
	set_process(false)

func _process(_delta):
	time_label.text = "%3.1f" % $"Shriek Timer".time_left
	$Sweep.value = int(($"Shriek Timer".time_left / cooldown) * 100)

func _on_Shriek_Timer_timeout() -> void:
	$Sweep.value = 0
	disabled = false
	time_label.hide()
	set_process(false)

func _on_Marshall_shriek_on() -> void:
	disabled = true
	set_process(true)
	$"Shriek Timer".start()
	time_label.show()
