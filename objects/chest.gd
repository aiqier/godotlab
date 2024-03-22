extends StaticBody2D

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func chest_open():
	state_machine.travel('open')
	
func chest_close():
	state_machine.travel('close')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_near_chara_2d_area_entered(area):
	chest_open()


func _on_near_chara_2d_area_exited(area):
	chest_close() # Replace with function body.
