class_name Guitarist extends Node2D

@export var dj: DJ
@export var player: Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var sequencer: AnimationSequencer

func _ready() -> void:
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)
    
    sequencer = AnimationSequencer.new()
    sequencer.setup(self, animated_sprite_2d, player)
    sequencer.add_position("loop1toguitarloop1.wav", 64, 300)
    sequencer.add_position("singer1.wav", 64, 300)
    sequencer.add_position("song2toguitarloop2.wav", 0, -472612)
    sequencer.add_position("singer2.wav", 32, -472612)
    
    sequencer.add_trigger("loop1toguitarloop1.wav", "left", 3.0)
    
    sequencer.add_trigger("guitarloop1.wav", "middle", 2.0)
    sequencer.add_trigger("guitarloop1.wav", "middle_fast", 2.2)
    sequencer.add_trigger("guitarloop1.wav", "middle_fast", 2.35)
    sequencer.add_trigger("guitarloop1.wav", "left_fast", 2.6)
    sequencer.add_trigger("guitarloop1.wav", "right", 5.5)
    sequencer.add_trigger("guitarloop1.wav", "right_fast", 5.7)
    sequencer.add_trigger("guitarloop1.wav", "right_fast", 5.85)
    sequencer.add_trigger("guitarloop1.wav", "middle_fast", 6)
    sequencer.add_trigger("guitarloop1.wav", "middle", 9.0)
    sequencer.add_trigger("guitarloop1.wav", "middle_fast", 9.2)
    sequencer.add_trigger("guitarloop1.wav", "middle_fast", 9.35)
    sequencer.add_trigger("guitarloop1.wav", "left_fast", 9.5)
    
    sequencer.add_trigger("singer1.wav", "left", 2.9)
    
    sequencer.add_trigger("singer1.wav", "middle", 5.4)
    sequencer.add_trigger("singer1.wav", "middle_fast", 5.6)
    sequencer.add_trigger("singer1.wav", "middle_fast", 5.75)
    sequencer.add_trigger("singer1.wav", "left_fast", 6.0)
    sequencer.add_trigger("singer1.wav", "right", 8.9)
    sequencer.add_trigger("singer1.wav", "right_fast", 9.1)
    sequencer.add_trigger("singer1.wav", "right_fast", 9.25)
    sequencer.add_trigger("singer1.wav", "middle_fast", 9.4)
    sequencer.add_trigger("singer1.wav", "middle", 12.4)
    sequencer.add_trigger("singer1.wav", "middle_fast", 12.6)
    sequencer.add_trigger("singer1.wav", "middle_fast", 12.75)
    sequencer.add_trigger("singer1.wav", "left_fast", 12.9)
    
    sequencer.add_trigger("singer1.wav", "left", 16.9)
    
    sequencer.add_trigger("singer1.wav", "middle", 19.4)
    sequencer.add_trigger("singer1.wav", "middle_fast", 19.6)
    sequencer.add_trigger("singer1.wav", "middle_fast", 19.75)
    sequencer.add_trigger("singer1.wav", "left_fast", 20.0)
    sequencer.add_trigger("singer1.wav", "right", 22.9)
    sequencer.add_trigger("singer1.wav", "right_fast", 23.1)
    sequencer.add_trigger("singer1.wav", "right_fast", 23.25)
    sequencer.add_trigger("singer1.wav", "middle_fast", 23.4)
    sequencer.add_trigger("singer1.wav", "middle", 26.4)
    sequencer.add_trigger("singer1.wav", "middle_fast", 26.6)
    sequencer.add_trigger("singer1.wav", "middle_fast", 26.75)
    sequencer.add_trigger("singer1.wav", "left_fast", 26.9)

    sequencer.add_trigger("song2toguitarloop2.wav", "left", 1.5)
    
    sequencer.add_trigger("guitarloop2.wav", "middle", 0.7)
    sequencer.add_trigger("guitarloop2.wav", "middle_fast", 0.9)
    sequencer.add_trigger("guitarloop2.wav", "middle_fast", 1.05)
    sequencer.add_trigger("guitarloop2.wav", "left_fast", 1.3)
    sequencer.add_trigger("guitarloop2.wav", "right", 4.2)
    sequencer.add_trigger("guitarloop2.wav", "right_fast", 4.4)
    sequencer.add_trigger("guitarloop2.wav", "right_fast", 4.55)
    sequencer.add_trigger("guitarloop2.wav", "middle_fast", 4.7)
    sequencer.add_trigger("guitarloop2.wav", "middle", 7.7)
    sequencer.add_trigger("guitarloop2.wav", "middle_fast", 7.9)
    sequencer.add_trigger("guitarloop2.wav", "middle_fast", 8.05)
    sequencer.add_trigger("guitarloop2.wav", "left_fast", 8.2)

    sequencer.add_trigger("singer2.wav", "left", 2)

    sequencer.add_trigger("singer2.wav", "middle", 4.5)
    sequencer.add_trigger("singer2.wav", "middle_fast", 4.7)
    sequencer.add_trigger("singer2.wav", "middle_fast", 4.85)
    sequencer.add_trigger("singer2.wav", "left_fast", 5.1)
    sequencer.add_trigger("singer2.wav", "right", 8.0)
    sequencer.add_trigger("singer2.wav", "right_fast", 8.2)
    sequencer.add_trigger("singer2.wav", "right_fast", 8.35)
    sequencer.add_trigger("singer2.wav", "middle_fast", 8.5)
    sequencer.add_trigger("singer2.wav", "middle", 11.5)
    sequencer.add_trigger("singer2.wav", "middle_fast", 11.7)
    sequencer.add_trigger("singer2.wav", "middle_fast", 11.85)
    sequencer.add_trigger("singer2.wav", "left_fast", 12.0)

    sequencer.add_trigger("singer2.wav", "left", 16.0)

    sequencer.add_trigger("singer2.wav", "middle", 18.5)
    sequencer.add_trigger("singer2.wav", "middle_fast", 18.7)
    sequencer.add_trigger("singer2.wav", "middle_fast", 18.85)
    sequencer.add_trigger("singer2.wav", "left_fast", 19.1)
    sequencer.add_trigger("singer2.wav", "right", 22.0)
    sequencer.add_trigger("singer2.wav", "right_fast", 22.2)
    sequencer.add_trigger("singer2.wav", "right_fast", 22.35)
    sequencer.add_trigger("singer2.wav", "middle_fast", 22.5)
    sequencer.add_trigger("singer2.wav", "middle", 25.5)
    sequencer.add_trigger("singer2.wav", "middle_fast", 25.7)
    sequencer.add_trigger("singer2.wav", "middle_fast", 25.85)
    sequencer.add_trigger("singer2.wav", "left_fast", 26.0)
    

func _process(_delta: float) -> void:
    var playback_pos = dj.get_current_playback_time()
    
    if animated_sprite_2d.animation.begins_with("default"):
        var animation = sequencer.process_triggers(dj.get_current_track(), playback_pos)
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
            "left_fast": animated_sprite_2d.play("default_left")
            "middle_fast": animated_sprite_2d.play("default_middle")
            "right_fast": animated_sprite_2d.play("default_right")
