class_name Bystander extends Node2D


@export var dj: DJ
@export var player: Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var sequencer: AnimationSequencer

func _ready() -> void:
    dj = get_node("/root/Main/DJ")
    player = get_node("/root/Main/Player")
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)
    
    sequencer = AnimationSequencer.new()
    sequencer.setup(self, animated_sprite_2d, player)
    
    sequencer.add_trigger("sahi1.wav", "shout_fast", 2.8)
    sequencer.add_trigger("sahi1.wav", "shout", 6)
    sequencer.add_trigger("sahi2.wav", "shout_fast", 3.6)

func _process(_delta: float) -> void:
    var current_track = dj.tracks[dj.current_track_index]
    var playback_pos = dj.get_playback_position()
    
    if animated_sprite_2d.animation in ["default", "shout"]:
        var animation = sequencer.process_triggers(current_track.file_name, playback_pos)
        if animation != "":
            play_animation(animation)

func play_animation(anim_name: String) -> void:
    animated_sprite_2d.play(anim_name)

func _on_animation_finished() -> void:
    var current_anim = animated_sprite_2d.animation
    match current_anim:
        "shout_fast": animated_sprite_2d.play("default")
        "shout": animated_sprite_2d.play("default")
