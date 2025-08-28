class_name PlayerStateSprint extends PlayerState

func _init(p_player: Player) -> void:
    super._init(p_player)

func enter() -> void:
    var track_name = player.dj.tracks[player.dj.current_track_index].file_name
    var track_length = player.dj.stream.get_length()
    var flat_end_position
    if track_name == "singer1tosong1.wav":
        flat_end_position = 4448
    elif track_name == "sahi2.wav":
        flat_end_position = 7440
    elif track_name == "singer2tosong3.wav":
        flat_end_position = 2944 - 944 * sqrt(2)
    player.animated_sprite_2d.play("run")
    player.animated_sprite_2d.flip_h = true
    var starting_position = player.position.x
    var flat_distance = max(0, flat_end_position - starting_position)
    var inclined_distance = 944 * sqrt(2)
    var total_distance = flat_distance + inclined_distance
    var required_velocity = total_distance / track_length
    player.velocity.x = required_velocity

func _physics_process(_delta: float) -> void:
    handle_input()

func handle_input() -> void:
    if Input.is_action_just_pressed("dash"):
        var beat = player.get_beat()
        if beat:
            beat.hit()