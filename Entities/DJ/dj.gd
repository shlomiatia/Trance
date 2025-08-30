class_name DJ extends AudioStreamPlayer

@export var player: Player
@export var rhythm: Rhythm
@export var is_tutorial: bool

signal track_changed(track_name: String)
signal playlist_finished()

enum TrackType {
    ADVANCE_AUTO,
    LOOP_UNTIL_POSITION,
    WAIT_FOR_JUMP,
    WAIT_UNTIL_POSITION,
    LOOP_UNTIL_TUTORIAL,
}

class Track:
    var file_name: String
    var type: TrackType
    var position_threshold: float
    var audio_stream: AudioStream
    
    func _init(p_file_name: String, p_type: TrackType, p_audio_stream: AudioStream, p_position_threshold: float = 0.0):
        file_name = p_file_name
        type = p_type
        position_threshold = p_position_threshold
        audio_stream = p_audio_stream

var tracks: Array[Track] = [
    Track.new("start.wav", TrackType.ADVANCE_AUTO, preload("res://Music/start.wav")),
    Track.new("loop1.wav", TrackType.LOOP_UNTIL_POSITION, preload("res://Music/loop1.wav"), 900.0),
    Track.new("loop1toguitarloop1.wav", TrackType.ADVANCE_AUTO, preload("res://Music/loop1toguitarloop1.wav")),
    Track.new("guitarloop1.wav", TrackType.LOOP_UNTIL_POSITION, preload("res://Music/guitarloop1.wav"), 1700.0),
    Track.new("singer1.wav", TrackType.ADVANCE_AUTO, preload("res://Music/singer1.wav")),
    Track.new("singer1tosong1.wav", TrackType.WAIT_FOR_JUMP, preload("res://Music/singer1tosong1.wav")),
    Track.new("song1.wav", TrackType.ADVANCE_AUTO, preload("res://Music/song1.wav")),
    Track.new("song1tosahi.wav", TrackType.WAIT_UNTIL_POSITION, preload("res://Music/song1tosahi.wav"), 6700.0),
    Track.new("sahi1.wav", TrackType.ADVANCE_AUTO, preload("res://Music/sahi1.wav")),
    Track.new("sahi2.wav", TrackType.WAIT_FOR_JUMP, preload("res://Music/sahi2.wav")),
    Track.new("song2.wav", TrackType.ADVANCE_AUTO, preload("res://Music/song2.wav")),
    Track.new("song2toguitarloop2.wav", TrackType.ADVANCE_AUTO, preload("res://Music/song2toguitarloop2.wav")),
    Track.new("guitarloop2.wav", TrackType.LOOP_UNTIL_POSITION, preload("res://Music/guitarloop2.wav"), 700.0),
    Track.new("singer2.wav", TrackType.ADVANCE_AUTO, preload("res://Music/singer2.wav")),
    Track.new("singer2tosong3.wav", TrackType.ADVANCE_AUTO, preload("res://Music/singer2tosong3.wav")),
    Track.new("song3.wav", TrackType.ADVANCE_AUTO, preload("res://Music/song3.wav")),
    Track.new("song4.wav", TrackType.ADVANCE_AUTO, preload("res://Music/song4.wav")),
]

var tutorial_tracks: Array[Track] = [
    Track.new("tutorial1.wav", TrackType.LOOP_UNTIL_TUTORIAL, preload("res://Music/tutorial1.wav")),
    Track.new("tutorial1.5.wav", TrackType.WAIT_FOR_JUMP, preload("res://Music/tutorial1.5.wav")),
    Track.new("tutorial2.wav", TrackType.LOOP_UNTIL_TUTORIAL, preload("res://Music/tutorial2.wav")),
]

var current_track_index: int = -1
var waiting_for_jump: bool = false

func _ready() -> void:
    finished.connect(_on_finished)
    if is_tutorial:
        tracks = tutorial_tracks
    else:
        advance_track()
    
func _process(_delta: float) -> void:
    if current_track_index >= 0 and current_track_index < tracks.size():
        var current_track = tracks[current_track_index]
        
        match current_track.type:
            TrackType.LOOP_UNTIL_POSITION:
                if player.global_position.x > current_track.position_threshold && !playing:
                    advance_track()

            TrackType.WAIT_UNTIL_POSITION:
                if player.global_position.x > current_track.position_threshold && !playing:
                    advance_track()
            
            TrackType.WAIT_FOR_JUMP:
                if waiting_for_jump && !playing:
                    get_tree().paused = true
                if Input.is_action_just_pressed("jump"):
                    if waiting_for_jump && !playing:
                        get_tree().paused = false
                        waiting_for_jump = false
                        advance_track()

func _on_finished() -> void:
    var current_track = tracks[current_track_index]
    
    match current_track.type:
        TrackType.ADVANCE_AUTO:
            advance_track()
        
        TrackType.LOOP_UNTIL_POSITION:
            if player.global_position.x <= current_track.position_threshold:
                play()
            else:
                advance_track()
        
        TrackType.WAIT_FOR_JUMP:
            waiting_for_jump = true
            
        TrackType.LOOP_UNTIL_TUTORIAL:
            var track_name = current_track.file_name
            var total_beats = rhythm.get_total_beats(track_name)
            var hit_beats = rhythm.track_stats[track_name]

            if hit_beats >= total_beats:
                advance_track()
            else:
                rhythm.create_track_beats(track_name)
                play()

func get_playback_position_relative_to(track_name: String) -> float:
    var track_index = -1
    for i in range(tracks.size()):
        if tracks[i].file_name == track_name:
            track_index = i
            break
    if track_index == -1:
        return -INF
    
    if current_track_index == track_index:
        return get_playback_position()
    elif current_track_index == track_index - 1:
        return -stream.get_length() + get_playback_position()
    elif current_track_index == track_index + 1:
        return tracks[track_index].audio_stream.get_length() + get_playback_position()
    else:
        return -INF

func advance_track() -> void:
    current_track_index += 1
    if current_track_index >= tracks.size():
        playlist_finished.emit()
        return
        
    var track = tracks[current_track_index]
    stream_paused = false
    stream = track.audio_stream
    play()
    track_changed.emit(track.file_name)

func get_current_track() -> String:
    if current_track_index < 0 or current_track_index >= tracks.size():
        return ""
    return tracks[current_track_index].file_name
