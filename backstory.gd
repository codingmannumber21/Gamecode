extends Node2D
onready var titlescreen = preload("res://titlescreen.tscn")
func callit():
	auto.next = titlescreen
	get_tree().get_nodes_in_group("manager")[0].change()
