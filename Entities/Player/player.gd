class_name Player extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var dj: DJ

var _states: Dictionary = {}
var _current_state: PlayerState

func _ready() -> void:
    _states = {
        PlayerStateEnum.Type.STAND: PlayerStateStand.new(self),
        PlayerStateEnum.Type.WALK: PlayerStateWalk.new(self),
        PlayerStateEnum.Type.FALL: PlayerStateFall.new(self),
        PlayerStateEnum.Type.SPRINT: PlayerStateSprint.new(self)
    }
    change_state(PlayerStateEnum.Type.STAND)
    print("player.ready", dj)
    dj.track_changed.connect(_on_track_changed)

func change_state(state_type: PlayerStateEnum.Type) -> void:
    if _current_state:
        _current_state.exit()
    _current_state = _states[state_type]
    _current_state.enter()

func _physics_process(delta: float) -> void:
    velocity += get_gravity() * delta
    _current_state._physics_process(delta)
    move_and_slide()

func _on_track_changed(track_name: String) -> void:
    prints(track_name, track_name == "singer1tosong1.wav")
    if track_name == "singer1tosong1.wav":
        change_state(PlayerStateEnum.Type.SPRINT)
