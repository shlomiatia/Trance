class_name Drummer extends Node2D

@export var dj: DJ

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var sequencer: AnimationSequencer

func _ready() -> void:
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)
    
    sequencer = AnimationSequencer.new()
    sequencer.add_trigger("start.wav", "left", 0.5)
    sequencer.add_trigger("loop1.wav", "right", 3.0)
    sequencer.add_trigger("loop1.wav", "left", 6.5)
    sequencer.add_trigger("loop1.wav", "right", 10.0)

func _process(_delta: float) -> void:
    if animated_sprite_2d.animation == "default":
        var current_track = dj.tracks[dj.current_track_index]
        var playback_pos = dj.get_playback_position()
        
        var animation = sequencer.process_triggers(current_track.file_name, playback_pos)
        if animation != "":
            animated_sprite_2d.play(animation)

func _on_animation_finished() -> void:
    if animated_sprite_2d.animation != "default":
        animated_sprite_2d.play("default")
