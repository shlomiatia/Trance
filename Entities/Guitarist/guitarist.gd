class_name Guitarist extends Node2D

@export var dj: DJ
@export var player: Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var position_set := false
var sequencer: AnimationSequencer

func _ready() -> void:
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)
    
    # Initialize and setup sequencer
    sequencer = AnimationSequencer.new()
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

func _process(_delta: float) -> void:
    var current_track = dj.tracks[dj.current_track_index]
    var playback_pos = dj.get_playback_position()
    
    # Handle position setting
    if current_track.file_name == "loop1toguitarloop1.wav" && playback_pos >= 0.0 && !position_set:
        position_set = true
        global_position.x = player.global_position.x + 320 + 32
    
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
