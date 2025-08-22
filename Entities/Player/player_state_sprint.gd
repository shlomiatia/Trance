class_name PlayerStateSprint extends PlayerState

var beats = [1.6, 2.5, 3.4, 4.3, 5.2, 6.1, 7.0, 7.9]
var beat_circles: Array[Node2D] = []
var line: Line2D

func _init(p_player: Player) -> void:
    super._init(p_player)

func enter() -> void:
    player.animated_sprite_2d.play("run")
    player.animated_sprite_2d.flip_h = true
    setup_line()
    schedule_beats()

func exit() -> void:
    if line:
        line.queue_free()
    for circle in beat_circles:
        circle.queue_free()
    beat_circles.clear()

func _physics_process(delta: float) -> void:
    player.velocity.x = Constants.player_sprint_speed
    update_beat_circles()
    handle_input()

func setup_line() -> void:
    line = Line2D.new()
    line.add_point(Vector2(0, 300))
    line.add_point(Vector2(1152, 300))
    line.width = 2
    line.default_color = Color.WHITE
    player.add_sibling.call_deferred(line)

func schedule_beats() -> void:
    for beat_time in beats:
        var appear_time = beat_time - Constants.circle_appear_time
        create_beat_circle(appear_time)

func create_beat_circle(appear_time: float) -> void:
    var circle = Node2D.new()
    var collision_shape = Area2D.new()
    var shape = CircleShape2D.new()
    shape.radius = 20
    
    var circle_sprite = Sprite2D.new()
    circle_sprite.texture = CircleShape2D.new()
    circle_sprite.scale = Vector2(40, 40)
    
    collision_shape.add_child(circle_sprite)
    circle.add_child(collision_shape)
    
    circle.position = Vector2(576, 0)
    circle.set_meta("start_time", appear_time)
    circle.set_meta("hit", false)
    circle.set_meta("sprite", circle_sprite)
    
    player.add_sibling.call_deferred(circle)
    beat_circles.append(circle)

func update_beat_circles() -> void:
    var current_time = player.dj.get_playback_position()
    
    for circle in beat_circles:
        var start_time = circle.get_meta("start_time")
        var target_time = start_time + Constants.circle_appear_time
        
        if current_time >= start_time and current_time <= target_time:
            var progress = (current_time - start_time) / Constants.circle_appear_time
            circle.position.y = lerp(0.0, 300.0, progress)
            
            if not circle.get_meta("hit"):
                circle.get_meta("sprite").modulate = Color.WHITE

func handle_input() -> void:
    if Input.is_action_just_pressed("dash"):
        var current_time = player.dj.get_playback_position()
        
        for circle in beat_circles:
            var target_time = circle.get_meta("start_time") + Constants.circle_appear_time
            
            if abs(current_time - target_time) <= Constants.beat_click_threshold and not circle.get_meta("hit"):
                circle.set_meta("hit", true)
                circle.get_meta("sprite").modulate = Color.GREEN
                return
            
            if current_time >= target_time - Constants.beat_click_threshold and not circle.get_meta("hit"):
                circle.set_meta("hit", true)
                circle.get_meta("sprite").modulate = Color.RED
