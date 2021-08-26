extends KinematicBody2D

var active = false
var dialogNew = preload("res://UI/Scene/Dialogue.tscn")

onready var question = get_node("Question")
func _process(delta):
	question.visible = active 

func _input(event):
	if event.is_action_pressed("Interact") and active:
		var dialog = dialogNew.instance()
		get_tree().get_root().get_node("Hutan/NPC/CanvasLayer").add_child(dialog)
		Global.paused = true

func _on_DetectPlayer_body_entered(body):
	if body.name == "Player":
		active = true


func _on_NPC_body_extited(body):
	if body.name == "Player":
		active = false


func _on_DetectPlayer_body_exited(body):
	if body.name == "Player":
		active = false
