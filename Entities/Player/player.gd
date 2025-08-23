class_name Player extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

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
        PlayerStateEnum.Type.DASH: PlayerStateDash.new(self)
    }
    change_state(PlayerStateEnum.Type.STAND)
    dj.track_changed.connect(_on_track_changed)
    area_2d.body_entered.connect(_on_area_2d_body_entered)

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
    if track_name == "singer1tosong1.wav":
        global_position.x = 4080
        change_state(PlayerStateEnum.Type.SPRINT)
    if track_name == "song1.wav":
        change_state(PlayerStateEnum.Type.JUMP)

func get_beat() -> Beat:
    var beats = get_tree().get_nodes_in_group("beats").filter(func(b): return b.can_hit())
    beats.sort_custom(func(a: Beat, b: Beat): return a.target_time < b.target_time)
    if beats.size() > 0:
        return beats[0]
    return null

func _on_area_2d_body_entered(body: Node2D) -> void:
    body.get_parent().hit()