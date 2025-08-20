class_name Guitarist extends Node2D

@export var dj: DJ
@export var player: Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var sequencer: AnimationSequencer

func _ready() -> void:
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)
    
    sequencer = AnimationSequencer.new()
    sequencer.add_position("loop1toguitarloop1.wav", 64)
    sequencer.add_position("singer1.wav", 64)
    
    sequencer.add_trigger("loop1toguitarloop1.wav", "left", 3.0)
    
    sequencer.add_trigger("guitarloop1.wav", "middle", 2.0)
    sequencer.add_trigger("guitarloop1.wav", "middle", 2.2)
    sequencer.add_trigger("guitarloop1.wav", "left", 2.4)
    sequencer.add_trigger("guitarloop1.wav", "right", 5.5)
    sequencer.add_trigger("guitarloop1.wav", "right", 5.7)
    sequencer.add_trigger("guitarloop1.wav", "middle", 5.9)
    sequencer.add_trigger("guitarloop1.wav", "middle", 9.0)
    sequencer.add_trigger("guitarloop1.wav", "middle", 9.2)
    sequencer.add_trigger("guitarloop1.wav", "left", 9.4)
    
    sequencer.add_trigger("singer1.wav", "left", 2.4)
    
    sequencer.add_trigger("singer1.wav", "middle", 0.5)
    sequencer.add_trigger("singer1.wav", "middle", 0.7)
    sequencer.add_trigger("singer1.wav", "left", 0.9)
    sequencer.add_trigger("singer1.wav", "right", 8.4)
    sequencer.add_trigger("singer1.wav", "right", 8.6)
    sequencer.add_trigger("singer1.wav", "middle", 8.8)
    sequencer.add_trigger("singer1.wav", "middle", 12.5)
    sequencer.add_trigger("singer1.wav", "middle", 12.7)
    sequencer.add_trigger("singer1.wav", "left", 12.9)
    
    sequencer.add_trigger("singer1.wav", "left", 16.3)
    
    sequencer.add_trigger("singer1.wav", "middle", 19.5)
    sequencer.add_trigger("singer1.wav", "middle", 19.7)
    sequencer.add_trigger("singer1.wav", "left", 19.9)
    sequencer.add_trigger("singer1.wav", "right", 22.8)
    sequencer.add_trigger("singer1.wav", "right", 23.0)
    sequencer.add_trigger("singer1.wav", "middle", 23.2)
    sequencer.add_trigger("singer1.wav", "middle", 26.4)
    sequencer.add_trigger("singer1.wav", "middle", 26.6)
    sequencer.add_trigger("singer1.wav", "left", 26.8)

func _process(_delta: float) -> void:
    var current_track = dj.tracks[dj.current_track_index]
    var playback_pos = dj.get_playback_position()
    
    var offset = sequencer.get_position(current_track.file_name)
    if offset > 0:
        global_position.x = player.global_position.x + 320 + offset
    
    if animated_sprite_2d.animation.begins_with("default"):
        var animation = sequencer.process_triggers(current_track.file_name, playback_pos)
        if animation != "":
            play_animation(animation)

func play_animation(anim_name: String) -> void:
    animated_sprite_2d.play(anim_name)

func _on_animation_finished() -> void:
    var current_anim = animated_sprite_2d.animation
    if !current_anim.begins_with("default"):
        match current_anim:
            "left": animated_sprite_2d.play("default_left")
            "middle": animated_sprite_2d.play("default_middle")
            "right": animated_sprite_2d.play("default_right")
