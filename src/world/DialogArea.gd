extends Area2D

@export var dialog_key = "" #Chooses the dialog to display
var area_active = false

func _process(_delta):
	if area_active and Input.is_action_just_pressed("cs_interact"):
		SignalBus.emit_signal("display_dialog", dialog_key)

func _on_area_entered(area): #Allows you to play the dialog when you are near the target npc's area
	area_active = true

func _on_area_exited(area): #Resets the current area
	area_active = false
