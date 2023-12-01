extends KinematicBody2D
var hp = 4
var velocity = Vector2.ZERO
var player
var speed = 0
var seen = false
var hitbox
var died = false
onready var textbubble = preload("res://textbubble.tscn")
var walk = false

func _ready():
	$Timer.start(rand_range(0, 3))
	seen = false
	$attackbox/CollisionShape2D.disabled = true
	player = get_tree().get_nodes_in_group("player")[0]
	speed = rand_range(4000, 10000)
	hitbox = get_tree().get_nodes_in_group("hitbox")[0]
	$walker.start()
	$walker.wait_time = 6.0
	
func _physics_process(delta):
	if died != true:
		if seen == false:
			velocity = velocity.normalized()
			move_and_slide(velocity*speed*delta/5)
			if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding() or $RayCast2D3.is_colliding():
				if $RayCast2D.get_collider() == get_tree().get_nodes_in_group("hitbox")[0] or $RayCast2D2.get_collider() == get_tree().get_nodes_in_group("hitbox")[0] or $RayCast2D3.get_collider() == get_tree().get_nodes_in_group("hitbox")[0]:
					saw()
			if self.global_position.distance_to(get_tree().get_nodes_in_group("player")[0].global_position) < 40:
				saw()
			
		if seen == true:
			look_at(get_tree().get_nodes_in_group("player")[0].global_position)
			velocity = self.global_position.direction_to(get_tree().get_nodes_in_group("player")[0].global_position)
			velocity = velocity.normalized()
			move_and_slide(velocity*speed*delta)
	
	
func saw():
	seen = true
	$hey.play()
	#play sound when detected
	$AnimationPlayer.play("attack")
	$RayCast2D.enabled = false
	$RayCast2D2.enabled = false
	$RayCast2D3.enabled = false
	$RayCast2D.queue_free()
	$RayCast2D2.queue_free()
	$RayCast2D3.queue_free()
	
func _on_hitbox_area_entered(area):
	$hit.play()
	var child = textbubble.instance()
	child.setup("[color=red]" + "-1")
	get_tree().get_nodes_in_group("test")[0].add_child(child)
	child.position = self.position
	hp-=1
	if hp == 0:
		death()
	#play text particle

func _on_attackbox_area_entered(area):
	pass # Replace with function body.
	
func death():
	get_tree().get_nodes_in_group("player")[0].donate(100)
	$hitbox/CollisionShape2D.set_deferred("disabled", true)
	$attackbox/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	$hurt.play()
	$AnimationPlayer.play("death")

func die():
	self.queue_free()
	#YOU SHOULD QUEUE FREE YOURSELF NOW!!!!!


func _on_Timer_timeout():
	$AnimationPlayer.play("look")


func _on_walker_timeout():
	if walk:
		velocity.x = round(rand_range(-200, 200))
		velocity.y = round(rand_range(-200, 200))
		look_at(velocity)
		walk = false
	else:
		velocity = Vector2.ZERO
		walk = true
