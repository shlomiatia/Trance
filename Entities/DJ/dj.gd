class_name DJ extends AudioStreamPlayer

@export var player: Player

enum TrackType {
    ADVANCE_AUTO,
    LOOP_UNTIL_POSITION,
    WAIT_FOR_MOUSE_BUTTONS
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
    Track.new("loop1.wav", TrackType.LOOP_UNTIL_POSITION, preload("res://Music/loop1.wav"), 975.0),
    Track.new("loop1toguitarloop1.wav", TrackType.ADVANCE_AUTO, preload("res://Music/loop1toguitarloop1.wav")),
    Track.new("guitarloop1.wav", TrackType.LOOP_UNTIL_POSITION, preload("res://Music/guitarloop1.wav"), 1800.0),
    Track.new("singer1.wav", TrackType.ADVANCE_AUTO, preload("res://Music/singer1.wav")),
    Track.new("singer1tosong1.wav", TrackType.WAIT_FOR_MOUSE_BUTTONS, preload("res://Music/singer1tosong1.wav")),
    Track.new("song1.wav", TrackType.ADVANCE_AUTO, preload("res://Music/song1.wav"))
]

var current_track_index: int = -1
var waiting_for_mouse_buttons: bool = false

func _ready() -> void:
    finished.connect(_on_finished)
    advance_track()

func _process(_delta: float) -> void:
    if current_track_index >= 0 and current_track_index < tracks.size():
        var current_track = tracks[current_track_index]
        
        match current_track.type:
            TrackType.LOOP_UNTIL_POSITION:
                if player.global_position.x > current_track.position_threshold and not playing:
                    print("Position threshold reached for track: ", current_track.file_name)
                    advance_track()
            
            TrackType.WAIT_FOR_MOUSE_BUTTONS:
                if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
                    if waiting_for_mouse_buttons and not playing:
                        print("Mouse buttons pressed, advancing from track: ", current_track.file_name)
                        waiting_for_mouse_buttons = false
                        advance_track()

func _on_finished() -> void:
    print(player.global_position)
    var current_track = tracks[current_track_index]
    
    match current_track.type:
        TrackType.ADVANCE_AUTO:
            print("Auto advancing from track: ", current_track.file_name)
            advance_track()
        
        TrackType.LOOP_UNTIL_POSITION:
            if player.global_position.x <= current_track.position_threshold:
                play()
            else:
                print("Position threshold reached for track: ", current_track.file_name)
                advance_track()
        
        TrackType.WAIT_FOR_MOUSE_BUTTONS:
            waiting_for_mouse_buttons = true
            if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
                print("Mouse buttons already pressed, advancing from track: ", current_track.file_name)
                waiting_for_mouse_buttons = false
                advance_track()

func advance_track() -> void:
    current_track_index += 1
    if current_track_index >= tracks.size():
        print("Playlist finished!")
        return
        
    var track = tracks[current_track_index]
    print("Playing track: ", track.file_name)
    stream_paused = false
    stream = track.audio_stream
    play()
