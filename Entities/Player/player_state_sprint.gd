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
        var beat = player.get_beat()
        if beat:
            beat.hit()