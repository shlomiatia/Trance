class_name Drummer extends Node2D

@export var dj: DJ

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var next_animation := "left"
var last_trigger_point := -1.0

func _ready() -> void:
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func _process(_delta: float) -> void:
    if animated_sprite_2d.animation == "default":
        var current_track = dj.tracks[dj.current_track_index]
        var playback_pos = dj.get_playback_position()
        
        if playback_pos < last_trigger_point:
            last_trigger_point = -1.0
        
        match current_track.file_name:
            "start.wav":
                if playback_pos >= 0.5 && last_trigger_point < 0.5:
                    last_trigger_point = 0.5
                    play_side_animation()
            "loop1.wav":
                if playback_pos >= 10.0 && last_trigger_point < 10.0:
                    last_trigger_point = 10.0
                    play_side_animation()
                elif playback_pos >= 6.5 && last_trigger_point < 6.5:
                    last_trigger_point = 6.5
                    play_side_animation()
                elif playback_pos >= 3.0 && last_trigger_point < 3.0:
                    last_trigger_point = 3.0
                    play_side_animation()

func play_side_animation() -> void:
    animated_sprite_2d.play(next_animation)
    next_animation = "right" if next_animation == "left" else "left"

func _on_animation_finished() -> void:
    if animated_sprite_2d.animation != "default":
        animated_sprite_2d.play("default")
