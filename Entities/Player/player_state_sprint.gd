class_name PlayerStateSprint extends PlayerState

func _init(p_player: Player) -> void:
    super._init(p_player)

func enter() -> void:
    player.animated_sprite_2d.play("run")
    player.animated_sprite_2d.flip_h = true

func _physics_process(_delta: float) -> void:
    player.velocity.x = Constants.player_sprint_speed
    handle_input()

func handle_input() -> void:
    if Input.is_action_just_pressed("dash"):
        var current_time = player.dj.get_playback_position()
        var beats = player.get_tree().get_nodes_in_group("beats")
        beats.sort_custom(func(a: Beat, b: Beat): return a.target_time < b.target_time)
        
        for beat in beats:
            if abs(current_time - beat.target_time) <= Constants.beat_click_threshold:
                beat.hit()
                return
