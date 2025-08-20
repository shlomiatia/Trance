class_name AnimationSequencer

class AnimationTrigger:
    var file_name: String
    var animation: String
    var playback_pos: float
    
    func _init(p_file_name: String, p_animation: String, p_playback_pos: float):
        file_name = p_file_name
        animation = p_animation
        playback_pos = p_playback_pos

class PositionTrigger:
    var file_name: String
    var offset: float
    
    func _init(p_file_name: String, p_offset: float):
        file_name = p_file_name
        offset = p_offset

var character: Node2D
var animated_sprite_2d: AnimatedSprite2D
var player: Player
var triggers: Array[AnimationTrigger] = []
var positions: Array[PositionTrigger] = []
var last_trigger_point := -1.0

func setup(p_character: Node2D, p_animated_sprite_2d: AnimatedSprite2D, p_player: Player) -> void:
    character = p_character
    animated_sprite_2d = p_animated_sprite_2d
    player = p_player

func add_trigger(file_name: String, animation: String, playback_pos: float) -> void:
    triggers.append(AnimationTrigger.new(file_name, animation, playback_pos))

func process_triggers(current_track_name: String, playback_pos: float) -> String:
    if playback_pos < last_trigger_point:
        last_trigger_point = -1.0
    
    # Handle position setting
    if playback_pos >= 0.0 && last_trigger_point < 0.0:
        for position in positions:
            if position.file_name == current_track_name:
                character.global_position.x = player.global_position.x + 320 + position.offset
                last_trigger_point = 0.0
                break
        
    var animation_to_play := ""
    
    for trigger in triggers:
        if trigger.file_name == current_track_name:
            if playback_pos >= trigger.playback_pos && last_trigger_point < trigger.playback_pos:
                last_trigger_point = trigger.playback_pos
                animation_to_play = trigger.animation
                break
    
    return animation_to_play

func add_position(file_name: String, offset: float) -> void:
    positions.append(PositionTrigger.new(file_name, offset))
