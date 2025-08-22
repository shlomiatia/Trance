class_name Beat extends Node2D

@export var dj: DJ
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var target_time: float
var start_time: float
var end_time: float

func _ready() -> void:
    position = Vector2(320, -8)
    start_time = target_time - Constants.beat_appear_time
    end_time = target_time + Constants.beat_appear_time

func _process(_delta: float) -> void:
    var current_time = dj.get_playback_position()
    
    if current_time >= start_time && current_time <= end_time:
        var progress = (current_time - start_time) / Constants.beat_appear_time / 2
        position.y = lerp(0.0, 368.0, progress)
    elif current_time > end_time:
        queue_free()

func hit() -> void:
    animated_sprite_2d.modulate = Color("#26854c")
    animated_sprite_2d.play("hit")
