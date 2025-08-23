class_name PlayerStateDash extends PlayerState

const DASH_SPEED := 2400.0
const DASH_DURATION := 0.1
var target_beat: Beat

var _dash_timer: float = 0.0

func _init(p_player: Player) -> void:
    super._init(p_player)

func enter() -> void:
    player.animated_sprite_2d.play("dash")
    _dash_timer = 0.0
    target_beat = player.get_beat()

func _physics_process(delta: float) -> void:
    _dash_timer += delta
    
    var direction = (target_beat.global_position - player.global_position).normalized()
    player.velocity.x = direction.x * DASH_SPEED
    
    if _dash_timer >= DASH_DURATION:
        player.velocity.x = 0
        player.change_state(PlayerStateEnum.Type.FALL)
