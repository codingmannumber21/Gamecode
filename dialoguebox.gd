extends CanvasLayer
var showing = 0
#showing text
var total = 0
#total text

var rn = 0
#line on right now
var entire = 0
#how many lines

var complete = false
#when complete with entire dialogue
var lines = 0
var cashamount
func _ready():
	self.add_user_signal("entered")

func _input(event):
	if event.is_action_released("ui_accept"):
		emit_signal("entered")
	
func speak(value, cash):
	cashamount = cash
	$ColorRect/anim/Polygon.visible = false
	lines = value
	rn = 0
	showing = 0
	entire = len(value)
	$ColorRect/text.visible_characters = 0
	$ColorRect/title.visible_characters = 0
	self.visible = true
	$ColorRect/title.bbcode_text = value[rn]
	rn += 1
	$ColorRect/title.visible_characters = -1
	
	$ColorRect/text.bbcode_text = value[rn]
	total = len(value[rn])
	$Timer.start(0.05)
		
func _on_Timer_timeout():
	$ColorRect/text.visible_characters += 1
	showing += 1
	if showing == total:
		$Timer.stop()
		$ColorRect/anim/Polygon.visible = true
		new()
	
func new():
	yield(self, "entered")
	nextline()
	
func nextline():
	$ColorRect/anim/Polygon.visible = false
	rn += 1
	if rn >= entire:
		#WHEN DONE WITH ENTIRE DIALOGUE
		get_tree().get_nodes_in_group("player")[0].unstun()
		self.visible = false
		get_tree().get_nodes_in_group("player")[0].donate(cashamount)
	else:
		$ColorRect/text.visible_characters = 0
		$ColorRect/text.bbcode_text = lines[rn]
		total = len(lines[rn])
		showing = 0
		$Timer.start(0.05)
		
	
