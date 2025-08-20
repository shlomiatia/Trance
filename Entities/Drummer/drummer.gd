class_name Drummer extends Node2D

@export var dj: DJ
@export var player: Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var sequencer: AnimationSequencer

func _ready() -> void:
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)
    
    sequencer = AnimationSequencer.new()
    sequencer.setup(self, animated_sprite_2d, player)
    sequencer.add_position("loop1toguitarloop1.wav", 32)
    sequencer.add_position("singer1.wav", 32)
    
    sequencer.add_trigger("start.wav", "left", 0.5)
    sequencer.add_trigger("loop1.wav", "right", 3.0)
    sequencer.add_trigger("loop1.wav", "left", 6.5)
    sequencer.add_trigger("loop1.wav", "right", 10.0)
    sequencer.add_trigger("guitarloop1.wav", "left", 3)
    sequencer.add_trigger("guitarloop1.wav", "right", 6.5)
    
    sequencer.add_trigger("singer1.wav", "left", 2.9)
    sequencer.add_trigger("singer1.wav", "left_fast", 3.6)
    sequencer.add_trigger("singer1.wav", "right_fast", 4.0)
    sequencer.add_trigger("singer1.wav", "left_fast", 4.2)
    sequencer.add_trigger("singer1.wav", "left", 4.6)
    sequencer.add_trigger("singer1.wav", "left_fast", 5.4)
    sequencer.add_trigger("singer1.wav", "right_fast", 5.9)
    
    sequencer.add_trigger("singer1.wav", "left", 6.4)
    sequencer.add_trigger("singer1.wav", "left_fast", 7.1)
    sequencer.add_trigger("singer1.wav", "right_fast", 7.5)
    sequencer.add_trigger("singer1.wav", "left_fast", 7.7)
    sequencer.add_trigger("singer1.wav", "left", 8.1)
    sequencer.add_trigger("singer1.wav", "left_fast", 8.9)
    sequencer.add_trigger("singer1.wav", "right_fast", 9.4)
    
    sequencer.add_trigger("singer1.wav", "left", 9.8)
    sequencer.add_trigger("singer1.wav", "left_fast", 10.5)
    sequencer.add_trigger("singer1.wav", "right_fast", 10.9)
    sequencer.add_trigger("singer1.wav", "left_fast", 11.1)
    sequencer.add_trigger("singer1.wav", "left", 11.5)
    sequencer.add_trigger("singer1.wav", "left_fast", 12.3)
    sequencer.add_trigger("singer1.wav", "right_fast", 12.8)
    
    sequencer.add_trigger("singer1.wav", "left", 13.4)
    sequencer.add_trigger("singer1.wav", "left_fast", 14.1)
    sequencer.add_trigger("singer1.wav", "right_fast", 14.5)
    sequencer.add_trigger("singer1.wav", "left_fast", 14.7)
    sequencer.add_trigger("singer1.wav", "left", 15.1)
    sequencer.add_trigger("singer1.wav", "left_fast", 15.9)
    sequencer.add_trigger("singer1.wav", "right_fast", 16.4)
    
    sequencer.add_trigger("singer1.wav", "left", 16.7)
    sequencer.add_trigger("singer1.wav", "left_fast", 17.4)
    sequencer.add_trigger("singer1.wav", "right_fast", 17.8)
    sequencer.add_trigger("singer1.wav", "left_fast", 18.0)
    sequencer.add_trigger("singer1.wav", "left", 18.4)
    sequencer.add_trigger("singer1.wav", "left_fast", 19.2)
    sequencer.add_trigger("singer1.wav", "right_fast", 19.7)
    
    sequencer.add_trigger("singer1.wav", "left", 20.3)
    sequencer.add_trigger("singer1.wav", "left_fast", 21.0)
    sequencer.add_trigger("singer1.wav", "right_fast", 21.4)
    sequencer.add_trigger("singer1.wav", "left_fast", 21.6)
    sequencer.add_trigger("singer1.wav", "left", 22.0)
    sequencer.add_trigger("singer1.wav", "left_fast", 22.8)
    sequencer.add_trigger("singer1.wav", "right_fast", 23.3)
    
    sequencer.add_trigger("singer1.wav", "left", 23.7)
    sequencer.add_trigger("singer1.wav", "left_fast", 24.4)
    sequencer.add_trigger("singer1.wav", "right_fast", 24.8)
    sequencer.add_trigger("singer1.wav", "left_fast", 25.0)
    sequencer.add_trigger("singer1.wav", "left", 25.4)
    sequencer.add_trigger("singer1.wav", "left_fast", 26.2)
    sequencer.add_trigger("singer1.wav", "right_fast", 26.7)
    
    sequencer.add_trigger("singer1.wav", "left", 27.3)
    sequencer.add_trigger("singer1.wav", "left_fast", 28.0)
    sequencer.add_trigger("singer1.wav", "right_fast", 28.4)
    sequencer.add_trigger("singer1.wav", "left_fast", 28.6)
    sequencer.add_trigger("singer1.wav", "left", 29.0)
    sequencer.add_trigger("singer1.wav", "left_fast", 29.8)
    sequencer.add_trigger("singer1.wav", "right_fast", 30.3)

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
