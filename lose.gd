extends Node2D


func _on_Button_pressed():
	get_tree().get_nodes_in_group("manager")[0].retry()
