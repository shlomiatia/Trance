class_name Bystander extends Node2D


@export var dj: DJ
@export var player: Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var sequencer: AnimationSequencer

const COLOR_SETS = {
    "black": ["000000", "10121c", "2c1e31"],
    "red": ["6b2643", "ac2847", "ec273f"],
    "orange": ["94493a", "de5d3a", "e98537", "f3a833"],
    "brown": ["4d3533", "6e4c30", "a26d3f", "ce9248", "dab163", "e8d282", "f7f3b7"],
    "green": ["1e4044", "006554", "26854c", "5ab552", "9de64e"],
    "teal": ["008b8b", "62a477", "a6cb96", "d3eed3"],
    "blue": ["3e3b65", "3859b3", "3388de", "36c5f4", "6dead6"],
    "purple": ["5e5b8c", "8c78a5", "deceed"],
    "purple2": ["9a4d76", "c878af", "cc99ff"],
    "pink": ["fa6e79", "ffa2ac", "ffd1d5", "f6d0d2", "f1e6de", "ffffff"],
    "grey": ["b0a7b8", "f6e8e0", "ffffff"]
}

const HAIR_COLOR_SETS = ["black", "orange", "brown", "grey"]
const SKIN_COLOR_SETS = ["brown", "pink"]

func get_random_color_sequence(shade_name: String, count: int = 3) -> Array:
    var colors = COLOR_SETS[shade_name]
    if colors.size() < count:
        return colors
    var start_idx = randi() % (colors.size() - count + 1)
    return colors.slice(start_idx, start_idx + count)

func pick_unique_shade() -> String:
    var available_shades = COLOR_SETS.keys()
    return available_shades[randi() % available_shades.size()]

func setup_palette_swap() -> void:
    var shader_material = animated_sprite_2d.material as ShaderMaterial
    
    shader_material.set_shader_parameter("original_0", Color("000000"))
    shader_material.set_shader_parameter("original_1", Color("191a21"))
    shader_material.set_shader_parameter("original_2", Color("2e2533"))
    
    shader_material.set_shader_parameter("original_3", Color("f6d0d2"))
    shader_material.set_shader_parameter("original_4", Color("f1e6de"))
    shader_material.set_shader_parameter("original_5", Color("ffffff"))
    
    shader_material.set_shader_parameter("original_6", Color("633043"))
    shader_material.set_shader_parameter("original_7", Color("9d3949"))
    shader_material.set_shader_parameter("original_8", Color("d84345"))
    
    shader_material.set_shader_parameter("original_9", Color("d84345"))
    shader_material.set_shader_parameter("original_10", Color("3e5caa"))
    shader_material.set_shader_parameter("original_11", Color("4688d5"))
    
    var hair_shade = HAIR_COLOR_SETS[randi() % HAIR_COLOR_SETS.size()]
    if global_position.y < 0:
        hair_shade = pick_unique_shade()
    var hair_colors = get_random_color_sequence(hair_shade)
    
    var skin_shade = SKIN_COLOR_SETS[randi() % SKIN_COLOR_SETS.size()]
    if global_position.y < 0:
        skin_shade = pick_unique_shade()
    var skin_colors = get_random_color_sequence(skin_shade)
    
    var shirt_shade = pick_unique_shade()
    var shirt_colors = get_random_color_sequence(shirt_shade)
    
    var pants_shade = pick_unique_shade()
    var pants_colors = get_random_color_sequence(pants_shade)
    
    shader_material.set_shader_parameter("replace_0", Color(hair_colors[0]))
    shader_material.set_shader_parameter("replace_1", Color(hair_colors[1]))
    shader_material.set_shader_parameter("replace_2", Color(hair_colors[2]))
    
    shader_material.set_shader_parameter("replace_3", Color(skin_colors[0]))
    shader_material.set_shader_parameter("replace_4", Color(skin_colors[1]))
    shader_material.set_shader_parameter("replace_5", Color(skin_colors[2]))
    
    shader_material.set_shader_parameter("replace_6", Color(shirt_colors[0]))
    shader_material.set_shader_parameter("replace_7", Color(shirt_colors[1]))
    shader_material.set_shader_parameter("replace_8", Color(shirt_colors[2]))
    
    shader_material.set_shader_parameter("replace_9", Color(pants_colors[0]))
    shader_material.set_shader_parameter("replace_10", Color(pants_colors[1]))
    shader_material.set_shader_parameter("replace_11", Color(pants_colors[2]))
    
    shader_material.set_shader_parameter("is_disabled", false)

func _ready() -> void:
    dj = get_node("/root/Main/DJ")
    player = get_node("/root/Main/Player")
    animated_sprite_2d.animation_finished.connect(_on_animation_finished)
    play_animation("default")
    setup_palette_swap()
    
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
    if anim_name == "default":
        animated_sprite_2d.frame = randi() % animated_sprite_2d.sprite_frames.get_frame_count("default")

func _on_animation_finished() -> void:
    var current_anim = animated_sprite_2d.animation
    match current_anim:
        "shout_fast": play_animation("default")
        "shout": play_animation("default")
