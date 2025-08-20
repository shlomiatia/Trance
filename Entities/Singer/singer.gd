class_name Singer extends Node2D

@export var dj: DJ
@export var player: Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var sequencer: AnimationSequencer

func _ready() -> void:
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)
    
    sequencer = AnimationSequencer.new()
    sequencer.add_position("singer1.wav", 96)
    
    sequencer.add_trigger("singer1.wav", "start_sing", 3.0)
    sequencer.add_trigger("singer1.wav", "continue_sing", 7.0)
    sequencer.add_trigger("singer1.wav", "continue_sing", 11.0)
    sequencer.add_trigger("singer1.wav", "end_sing", 16.5)
    sequencer.add_trigger("singer1.wav", "start_sing", 18.0)
    sequencer.add_trigger("singer1.wav", "end_sing", 24.5)
    sequencer.add_trigger("singer1.wav", "start_sing", 25.0)
    sequencer.add_trigger("singer1.wav", "end_sing", 29.5)

func _process(_delta: float) -> void:
    var current_track = dj.tracks[dj.current_track_index]
    var playback_pos = dj.get_playback_position()
    
    var offset = sequencer.get_position(current_track.file_name)
    if offset > 0:
        global_position.x = player.global_position.x + 320 + offset
    
    if animated_sprite_2d.animation in ["default", "sing"]:
        var animation = sequencer.process_triggers(current_track.file_name, playback_pos)
        if animation != "":
            play_animation(animation)

func play_animation(anim_name: String) -> void:
    animated_sprite_2d.play(anim_name)

func _on_animation_finished() -> void:
    var current_anim = animated_sprite_2d.animation
    match current_anim:
        "start_sing": animated_sprite_2d.play("sing")
        "continue_sing": animated_sprite_2d.play("sing")
        "end_sing": animated_sprite_2d.play("default")
