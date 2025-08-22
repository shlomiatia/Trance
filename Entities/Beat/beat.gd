class_name Beat extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var target_time: float

func hit() -> void:
    animated_sprite_2d.modulate = Color("#26854c")
    animated_sprite_2d.play("hit")
