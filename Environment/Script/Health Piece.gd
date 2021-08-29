extends Area2D

signal get_health

func _on_Health_Piece_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		emit_signal("get_health")
		$".".queue_free()
