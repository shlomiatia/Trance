class_name PlayerStateFall extends PlayerState

func _init(p_player: Player) -> void:
    super._init(p_player)

func enter() -> void:
    player.animated_sprite_2d.play("dash")

func _physics_process(_delta: float) -> void:
    if player.is_on_floor():
        player.change_state(PlayerStateEnum.Type.STAND)
    handle_input()

func handle_input() -> void:
    if Input.is_action_just_pressed("dash"):
        var direction := Input.get_axis("left", "right")
        var beat = player.get_beat()
        
        if ((direction < 0 && beat.global_position.x < player.global_position.x) || (direction > 0 && beat.global_position.x > player.global_position.x)):
            pass