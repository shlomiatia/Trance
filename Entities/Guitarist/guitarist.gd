class_name Guitarist extends Node2D

@export var dj: DJ
@export var player: Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var last_trigger_point := -1.0

func _ready() -> void:
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func _process(_delta: float) -> void:
    var current_track = dj.tracks[dj.current_track_index]
    
    if animated_sprite_2d.animation.begins_with("default"):
        var playback_pos = dj.get_playback_position()
        
        if playback_pos < last_trigger_point:
            last_trigger_point = -1.0
        
        match current_track.file_name:
            "loop1toguitarloop1.wav":
                if playback_pos >= 0.0 && last_trigger_point < 0.0:
                    last_trigger_point = 0.0
                    global_position.x = player.global_position.x + 320 + 32
                if playback_pos >= 3.0 && last_trigger_point < 3.0:
                    last_trigger_point = 3.0
                    play_animation("left")
            "guitarloop1.wav":
                if playback_pos >= 2.0 && last_trigger_point < 2.0:
                    last_trigger_point = 2.0
                    play_animation("middle")
                elif playback_pos >= 2.5 && last_trigger_point < 2.5:
                    last_trigger_point = 2.5
                    play_animation("middle")
                elif playback_pos >= 3.0 && last_trigger_point < 3.0:
                    last_trigger_point = 3.0
                    play_animation("left")
                elif playback_pos >= 5.5 && last_trigger_point < 5.5:
                    last_trigger_point = 5.5
                    play_animation("right")
                elif playback_pos >= 6.0 && last_trigger_point < 6.0:
                    last_trigger_point = 6.0
                    play_animation("right")
                elif playback_pos >= 6.5 && last_trigger_point < 6.5:
                    last_trigger_point = 6.5
                    play_animation("middle")
                elif playback_pos >= 9.0 && last_trigger_point < 9.0:
                    last_trigger_point = 9.0
                    play_animation("middle")
                elif playback_pos >= 9.5 && last_trigger_point < 9.5:
                    last_trigger_point = 9.5
                    play_animation("middle")
                elif playback_pos >= 10.0 && last_trigger_point < 10.0:
                    last_trigger_point = 10.0
                    play_animation("left")

func play_animation(anim_name: String) -> void:
    animated_sprite_2d.play(anim_name)

func _on_animation_finished() -> void:
    var current_anim = animated_sprite_2d.animation
    if !current_anim.begins_with("default"):
        match current_anim:
            "left": animated_sprite_2d.play("default_left")
            "middle": animated_sprite_2d.play("default_middle")
            "right": animated_sprite_2d.play("default_right")
