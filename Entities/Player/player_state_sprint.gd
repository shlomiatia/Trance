class_name PlayerStateSprint extends PlayerState

var beats = [0.5, 1.6, 2.5, 3.4, 4.3, 5.2, 5.65, 6.1, 6.55, 7.0, 7.45, 7.9, 8.12, 8.34, 8.56, 8.78, 9.00, 9.22, 9.44, 9.66, 9.88, 10.10, 10.32, 10.54, 10.76, 10.98, 11.20, 11.31, 11.42, 11.53, 11.64, 11.75, 11.86, 11.97, 12.08, 12.19, 12.30, 12.41, 12.52, 12.63, 12.74, 12.85, 12.96, 13.07, 13.18, 13.29, 13.40, 13.51, 13.62, 13.73, 13.84, 13.95, 14.06, 14.17]
var beat_circles: Array[Beat] = []
var beat_scene: PackedScene = preload("res://Entities/Beat/beat.tscn")

func _init(p_player: Player) -> void:
    super._init(p_player)

func enter() -> void:
    player.animated_sprite_2d.play("run")
    player.animated_sprite_2d.flip_h = true
    schedule_beats()

func exit() -> void:
    for circle in beat_circles:
        circle.queue_free()
    beat_circles.clear()

func _physics_process(_delta: float) -> void:
    player.velocity.x = Constants.player_sprint_speed
    update_beat_circles()
    handle_input()

func schedule_beats() -> void:
    for beat_time in beats:
        create_beat_circle(beat_time)

func create_beat_circle(target_time: float) -> void:
    var circle = beat_scene.instantiate() as Beat
    
    circle.position = Vector2(320, -8)
    circle.target_time = target_time
    
    player.get_parent().get_node("CanvasLayer").add_child(circle)
    beat_circles.append(circle)

func update_beat_circles() -> void:
    var current_time = player.dj.get_playback_position()
    
    for circle in beat_circles:
        var target_time = circle.target_time
        var start_time = target_time - Constants.beat_appear_time
        var end_time = target_time + Constants.beat_appear_time

        
        if current_time >= start_time && current_time <= end_time:
            var progress = (current_time - start_time) / Constants.beat_appear_time / 2
            circle.position.y = lerp(0.0, 368.0, progress)

func handle_input() -> void:
    if Input.is_action_just_pressed("dash"):
        var current_time = player.dj.get_playback_position()
        
        for circle in beat_circles:
            var target_time = circle.target_time;
            
            if abs(current_time - target_time) <= Constants.beat_click_threshold:
                circle.modulate = Color.GREEN
