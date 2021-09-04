extends Area2D

func _on_Turnips_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		Global.turnips += 1
	queue_free()
