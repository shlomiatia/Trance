class_name PlayerStateSprint extends PlayerState

var beat_times = [1.6, 2.5, 3.4, 4.3, 5.2, 5.65, 6.1, 6.55, 7.0, 7.45, 7.9, 8.12, 8.34, 8.56, 8.78, 9.00, 9.22, 9.44, 9.66, 9.88, 10.10, 10.32, 10.54, 10.76, 10.98, 11.20, 11.35, 11.50, 11.65, 11.80, 11.95, 12.10, 12.25, 12.40, 12.55, 12.70, 12.85, 13.00, 13.15, 13.30, 13.45, 13.60, 13.75, 13.90, 14.05, 14.20]
var beats: Array[Beat] = []
var beat_scene: PackedScene = preload("res://Entities/Beat/beat.tscn")

func _init(p_player: Player) -> void:
    super._init(p_player)

func enter() -> void:
    player.animated_sprite_2d.play("run")
    player.animated_sprite_2d.flip_h = true
    schedule_beats()


func _physics_process(_delta: float) -> void:
    player.velocity.x = Constants.player_sprint_speed
    update_beat_circles()
    handle_input()

func schedule_beats() -> void:
    for beat_time in beat_times:
        create_beat(beat_time)

func create_beat(target_time: float) -> void:
    var beat = beat_scene.instantiate() as Beat
    
    beat.position = Vector2(320, -8)
    beat.target_time = target_time
    
    player.get_parent().get_node("CanvasLayer").add_child(beat)
    beats.append(beat)

func update_beat_circles() -> void:
    var current_time = player.dj.get_playback_position()
    
    for beat in beats:
        var target_time = beat.target_time
        var start_time = target_time - Constants.beat_appear_time
        var end_time = target_time + Constants.beat_appear_time

        
        if current_time >= start_time && current_time <= end_time:
            var progress = (current_time - start_time) / Constants.beat_appear_time / 2
            beat.position.y = lerp(0.0, 368.0, progress)

func handle_input() -> void:
    if Input.is_action_just_pressed("dash"):
        var current_time = player.dj.get_playback_position()
        
        for beat in beats:
            var target_time = beat.target_time;
            
            if abs(current_time - target_time) <= Constants.beat_click_threshold:
                beat.hit()
                return
