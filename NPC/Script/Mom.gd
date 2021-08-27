extends StaticBody2D

func _on_Detection_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Interact UI".visible = true

func _on_Detection_Area_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		$"Interact UI".visible = false
