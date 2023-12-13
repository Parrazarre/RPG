extends Node2D

func create_grass_effect():
	var GrassEffet = load("res://Effects/grass_effect.tscn")
	var grassEffect = GrassEffet.instantiate()
	get_parent().add_child(grassEffect)
	grassEffect.position = self.position

func _on_hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
