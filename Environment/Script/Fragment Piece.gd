extends Area2D

signal get_fragment

func _on_Fragment_Piece_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		emit_signal("get_fragment")
		$".".queue_free()
