extends KinematicBody2D
var description = "test"
var zero = {
	0:"Metal man",
	1:"i require the goods"
}
var one = {
	0:"robot",
	1:"SYSTEM OVERRIDE KILLING ALL HUMANS"
}
var two = {
	0:"robot",
	1:"OH SHI- NIWYBUQY TVUS AY JXZBV HGICVY OSDAJ KLb JHBD JBHQWI QBW Uhb jABSKJH gSAUD",
}
var velocity = Vector2.ZERO
var speed = 4000
var dollar = round(rand_range(101,1010))
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
