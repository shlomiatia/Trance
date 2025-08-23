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
        var current_time = player.dj.get_playback_position()
        var beats = player.get_tree().get_nodes_in_group("beats")
        beats.sort_custom(func(a: Beat, b: Beat): return a.target_time < b.target_time)
        
        for beat in beats:
            if abs(current_time - beat.target_time) <= Constants.beat_click_threshold && ((direction < 0 && beat.global_position.x < player.global_position.x) || (direction > 0 && beat.global_position.x > player.global_position.x)):
                    var beat_pos = beat.global_position
                    var player_pos = player.global_position