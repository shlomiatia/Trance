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
    sequencer.add_trigger("singer1.wav", "left", 3.6)
    sequencer.add_trigger("singer1.wav", "right", 4.0)
    sequencer.add_trigger("singer1.wav", "left", 4.2)
    sequencer.add_trigger("singer1.wav", "left", 4.6)
    sequencer.add_trigger("singer1.wav", "left", 5.4)
    sequencer.add_trigger("singer1.wav", "right", 5.9)
    
    sequencer.add_trigger("singer1.wav", "left", 6.4)
    sequencer.add_trigger("singer1.wav", "left", 7.1)
    sequencer.add_trigger("singer1.wav", "right", 7.5)
    sequencer.add_trigger("singer1.wav", "left", 7.7)
    sequencer.add_trigger("singer1.wav", "left", 8.1)
    sequencer.add_trigger("singer1.wav", "left", 8.9)
    sequencer.add_trigger("singer1.wav", "right", 9.4)
    
    sequencer.add_trigger("singer1.wav", "left", 9.8)
    sequencer.add_trigger("singer1.wav", "left", 10.5)
    sequencer.add_trigger("singer1.wav", "right", 10.9)
    sequencer.add_trigger("singer1.wav", "left", 11.1)
    sequencer.add_trigger("singer1.wav", "left", 11.5)
    sequencer.add_trigger("singer1.wav", "left", 12.3)
    sequencer.add_trigger("singer1.wav", "right", 12.8)
    
    sequencer.add_trigger("singer1.wav", "left", 13.4)
    sequencer.add_trigger("singer1.wav", "left", 14.1)
    sequencer.add_trigger("singer1.wav", "right", 14.5)
    sequencer.add_trigger("singer1.wav", "left", 14.7)
    sequencer.add_trigger("singer1.wav", "left", 15.1)
    sequencer.add_trigger("singer1.wav", "left", 15.9)
    sequencer.add_trigger("singer1.wav", "right", 16.4)
    
    sequencer.add_trigger("singer1.wav", "left", 16.7)
    sequencer.add_trigger("singer1.wav", "left", 17.4)
    sequencer.add_trigger("singer1.wav", "right", 17.8)
    sequencer.add_trigger("singer1.wav", "left", 18.0)
    sequencer.add_trigger("singer1.wav", "left", 18.4)
    sequencer.add_trigger("singer1.wav", "left", 19.2)
    sequencer.add_trigger("singer1.wav", "right", 19.7)
    
    sequencer.add_trigger("singer1.wav", "left", 20.3)
    sequencer.add_trigger("singer1.wav", "left", 21.0)
    sequencer.add_trigger("singer1.wav", "right", 21.4)
    sequencer.add_trigger("singer1.wav", "left", 21.6)
    sequencer.add_trigger("singer1.wav", "left", 22.0)
    sequencer.add_trigger("singer1.wav", "left", 22.8)
    sequencer.add_trigger("singer1.wav", "right", 23.3)
    
    sequencer.add_trigger("singer1.wav", "left", 23.7)
    sequencer.add_trigger("singer1.wav", "left", 24.4)
    sequencer.add_trigger("singer1.wav", "right", 24.8)
    sequencer.add_trigger("singer1.wav", "left", 25.0)
    sequencer.add_trigger("singer1.wav", "left", 25.4)
    sequencer.add_trigger("singer1.wav", "left", 26.2)
    sequencer.add_trigger("singer1.wav", "right", 26.7)
    
    sequencer.add_trigger("singer1.wav", "left", 27.3)
    sequencer.add_trigger("singer1.wav", "left", 28.0)
    sequencer.add_trigger("singer1.wav", "right", 28.4)
    sequencer.add_trigger("singer1.wav", "left", 28.6)
    sequencer.add_trigger("singer1.wav", "left", 29.0)
    sequencer.add_trigger("singer1.wav", "left", 29.8)
    sequencer.add_trigger("singer1.wav", "right", 30.3)

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
