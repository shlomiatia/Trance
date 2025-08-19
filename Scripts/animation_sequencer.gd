class_name AnimationSequencer

class AnimationTrigger:
    var file_name: String
    var animation: String
    var playback_pos: float
    
    func _init(p_file_name: String, p_animation: String, p_playback_pos: float):
        file_name = p_file_name
        animation = p_animation
        playback_pos = p_playback_pos

var triggers: Array[AnimationTrigger] = []
var last_trigger_point := -1.0

func add_trigger(file_name: String, animation: String, playback_pos: float) -> void:
    triggers.append(AnimationTrigger.new(file_name, animation, playback_pos))

func process_triggers(current_track_name: String, playback_pos: float) -> String:
    if playback_pos < last_trigger_point:
        last_trigger_point = -1.0
        
    var animation_to_play := ""
    
    for trigger in triggers:
        if trigger.file_name == current_track_name:
            if playback_pos >= trigger.playback_pos && last_trigger_point < trigger.playback_pos:
                last_trigger_point = trigger.playback_pos
                animation_to_play = trigger.animation
                break
    
    return animation_to_play
