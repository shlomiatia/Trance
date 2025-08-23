class_name PlayerStateDash extends PlayerState

const DASH_DURATION := 0.05
var target_beat: Beat
var timer: float = 0.0
var initial_x: float = 0.0

func _init(p_player: Player) -> void:
    super._init(p_player)

func enter() -> void:
    player.animated_sprite_2d.play("dash")
    timer = 0.0
    initial_x = player.global_position.x
    target_beat = player.get_beat()

func _physics_process(delta: float) -> void:
    timer += delta
    player.global_position.x = lerp(initial_x, target_beat.global_position.x, timer / DASH_DURATION)
    if timer >= DASH_DURATION:
        target_beat.hit()
        player.change_state(PlayerStateEnum.Type.FALL)
