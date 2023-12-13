extends Node2D

func _ready():
	var animatedSprite = $AnimatedSprite2D
	animatedSprite.play("Animate")

func _on_animated_sprite_2d_animation_finished():
	queue_free()
