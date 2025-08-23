class_name Beat extends Node2D

@export var dj: DJ
@export var player: Player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var target_time: float
var start_time: float
var end_time: float
var track_name: String
var direction: String

func init(p_track_name: String, p_target_time: float, p_direction: String) -> void:
    track_name = p_track_name
    target_time = p_target_time
    start_time = target_time - Constants.beat_appear_time
    end_time = target_time + Constants.beat_appear_time
    direction = p_direction

func _ready() -> void:
    position = Vector2(320, -8)

func _process(_delta: float) -> void:
    var current_time = dj.get_playback_position_relative_to(track_name)
    
    if is_playing():
        var progress = (current_time - start_time) / Constants.beat_appear_time / 2
        var y = lerp(0.0, 368.0, progress)
        if direction == "none":
            position.y = y
        else:
            if global_position.x == 320:
                set_initial_position()
            global_position.y = player.global_position.y - 188 + y
            
    elif current_time > end_time:
        queue_free()

func is_playing() -> bool:
    var current_time = dj.get_playback_position_relative_to(track_name)
    return current_time >= start_time && current_time <= end_time

func set_initial_position() -> void:
    var beats = get_tree().get_nodes_in_group("beats").filter(func(b): return b.track_name == track_name && b.target_time < target_time)
    beats.sort_custom(func(a: Beat, b: Beat): return a.target_time < b.target_time)
    
    var center_x
    if beats.size() == 0:
        center_x = 5400
    else:
        center_x = beats[-1].global_position.x

    if direction == "left":
        global_position.x = center_x - 160
    else:
        global_position.x = center_x + 160
    
    global_position.y = player.global_position.y - 188

func hit() -> void:
    animated_sprite_2d.modulate = Color("#26854c")
    animated_sprite_2d.play("hit")
