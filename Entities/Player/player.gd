class_name Player extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var camera_2d: Camera2D = $Camera2D

@export var dj: DJ

var _states: Dictionary = {}
var _current_state: PlayerState

func _ready() -> void:
    _states = {
        PlayerStateEnum.Type.STAND: PlayerStateStand.new(self),
        PlayerStateEnum.Type.WALK: PlayerStateWalk.new(self),
        PlayerStateEnum.Type.FALL: PlayerStateFall.new(self),
        PlayerStateEnum.Type.SPRINT: PlayerStateSprint.new(self),
        PlayerStateEnum.Type.JUMP: PlayerStateJump.new(self),
    }
    change_state(PlayerStateEnum.Type.STAND)
    dj.track_changed.connect(_on_track_changed)
    animated_sprite_2d.flip_h = true

func change_state(state_type: PlayerStateEnum.Type) -> void:
    if _current_state:
        _current_state.exit()
    _current_state = _states[state_type]
    _current_state.enter()

func _physics_process(delta: float) -> void:
    var gravity = Vector2(0, 250)
    var current_track = dj.get_current_track()
    collision_shape_2d.disabled = (current_track == "song3.wav" || current_track == "tutorial2.wav") && dj.get_playback_position() < 1

    if current_track == "singer2tosong3.wav":
        if dj.get_playback_position() <= 1:
            var progress = dj.get_playback_position()
            if progress > 1:
                progress = 1
            camera_2d.offset = lerp(Vector2(0, -90), Vector2(90, 0), progress)
            rotation_degrees = lerpf(0, 90.0, progress)
            animated_sprite_2d.rotation_degrees = lerpf(0, -90.0, progress)
        elif dj.get_playback_position() > dj.stream.get_length() - 1:
            var progress = dj.get_playback_position() - (dj.stream.get_length() - 1)
            if progress > 1:
                progress = 1
            
            camera_2d.offset = lerp(Vector2(90, 0), Vector2(0, -90), progress)
            rotation_degrees = lerpf(90, 0.0, progress)
            animated_sprite_2d.rotation_degrees = lerpf(-90, 0.0, progress)
        else:
            camera_2d.offset = Vector2(90, 0)
            rotation_degrees = 90
            animated_sprite_2d.rotation_degrees = -90
    else:
        camera_2d.offset = Vector2(0, -90)
        rotation_degrees = 0
        animated_sprite_2d.rotation_degrees = 0
    
    if current_track == "song2.wav":
        gravity = Vector2(0, -250)
    if current_track == "song3.wav":
        gravity = Vector2(0, 230)
    velocity += gravity * delta
    _current_state._physics_process(delta)
    move_and_slide()

func _on_track_changed(track_name: String) -> void:
    if track_name == "singer1tosong1.wav" || track_name == "sahi2.wav" || track_name == "singer2tosong3.wav":
        change_state(PlayerStateEnum.Type.SPRINT)
    elif track_name == "song1.wav" || track_name == "song2.wav":
        change_state(PlayerStateEnum.Type.JUMP)
    elif track_name == "song1tosahi.wav":
        global_position = Vector2(6320, 0)
        velocity.y = 125
    elif track_name == "song2toguitarloop2.wav":
        global_position = Vector2(0, -472750)
        velocity.y = 125
    elif track_name == "song3.wav" || track_name == "tutorial2.wav":
        change_state(PlayerStateEnum.Type.FALL)
    elif track_name == "song4.wav":
        velocity.y = 125
        
        
func get_beat() -> Beat:
    var beats = get_tree().get_nodes_in_group("beats").filter(func(b): return b.can_hit())
    beats.sort_custom(func(a: Beat, b: Beat): return a.target_time < b.target_time)
    if beats.size() > 0:
        return beats[0]
    return null
