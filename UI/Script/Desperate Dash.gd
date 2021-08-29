extends TextureButton

onready var time_label = $Counter/Value

var cooldown = 8.0

func _ready():
	$"Desperate Dash Cooldown".wait_time = cooldown
	time_label.hide()
	$Sweep.texture_progress = texture_normal
	$Sweep.value = 0
	set_process(false)

func _process(_delta):
	time_label.text = "%3.1f" % $"Desperate Dash Cooldown".time_left
	$Sweep.value = int(($"Desperate Dash Cooldown".time_left / cooldown) * 100)

func _on_Desperate_Dash_Cooldown_timeout() -> void:
	$Sweep.value = 0
	disabled = false
	time_label.hide()
	set_process(false)

func _on_Marshall_dash_on() -> void:
	disabled = true
	set_process(true)
	$"Desperate Dash Cooldown".start()
	time_label.show()
