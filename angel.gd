extends KinematicBody2D
var description = "test"
var zero = {
	0:"Angel",
	1:"take my money and don't tell god"
}
var one = {
	0:"Angel",
	1:"do you want the good book",
	2:"no?",
	3:"ok i want the good stuff",
	4:"have some money",
}
var two = {
	0:"Angel",
	1:"i would like to be enlightened sir",
	2:"have some cash for a good cause"
}
var velocity = Vector2.ZERO
var speed = 4000
var dollar = round(rand_range(69, 420))
var walk = true
func interacted():
	$Timer.stop()
	velocity = Vector2.ZERO
	get_tree().get_nodes_in_group("dialogue")[0].speak(description, dollar)
	look_at(get_tree().get_nodes_in_group("player")[0].global_position)
	self.collision_layer = 4
	self.modulate = Color(0.25, 0.25, 0.25, 1.0)
	$CollisionShape2D.set_deferred("disabled", true)
	
func _physics_process(delta):
	velocity = velocity.normalized()
	move_and_slide(velocity*speed*delta)


func _ready():
	$Timer.start()
	$Timer.wait_time = 6.0
	var chose = round(rand_range(0, 2))
	if chose == 0:
		description = zero
	elif chose == 1:
		description = one
	else: 
		description = two
	
func _on_Timer_timeout():
	if walk:
		velocity.x = round(rand_range(-200, 200))
		velocity.y = round(rand_range(-200, 200))
		look_at(velocity)
		walk = false
	else:
		velocity = Vector2.ZERO
		walk = true
