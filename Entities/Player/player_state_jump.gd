class_name PlayerStateJump extends PlayerState

var _initial_y: float
var _jump_duration: float = 1
var _elapsed_time: float

func enter() -> void:
    _initial_y = player.global_position.y
    player.velocity = Vector2(240, -120)
    player.animated_sprite_2d.play("dash")
    _elapsed_time = 0.0

func _physics_process(delta: float) -> void:
    _elapsed_time += delta

    if player.dj.get_current_track() == "song2.wav" && _elapsed_time > _jump_duration / 2.0:
        player.velocity.x = 0
        player.change_state(PlayerStateEnum.Type.FALL)
        return
        
    var progress = _elapsed_time / _jump_duration
    player.velocity.x = lerpf(240, 0.0, progress)
    
    if player.global_position.y > _initial_y:
        player.velocity.x = 0
        player.change_state(PlayerStateEnum.Type.FALL)
