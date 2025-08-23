class_name PlayerStateFall extends PlayerState

const DASH_DURATION := 0.05
const DIRECTION_BUFFER_TIME := 0.2

var target_beats: Array[Beat] = []
var dash_timer: float = 0.0
var initial_dash_x: float = 0.0
var last_direction: float = 0.0
var last_direction_time: float = 0.0

func _init(p_player: Player) -> void:
    super._init(p_player)

func enter() -> void:
    player.animated_sprite_2d.play("dash")
    target_beats.clear()
    dash_timer = 0.0

func _physics_process(delta: float) -> void:
    if player.is_on_floor():
        player.change_state(PlayerStateEnum.Type.STAND)
        return
        
    if !target_beats.is_empty():
        dash_timer += delta
        player.global_position.x = lerp(initial_dash_x, target_beats[0].global_position.x, dash_timer / DASH_DURATION)
        if dash_timer >= DASH_DURATION:
            target_beats[0].hit()
            target_beats.pop_front()
            dash_timer = 0.0
            initial_dash_x = player.global_position.x
                
    handle_input()

func handle_input() -> void:
    var current_direction := Input.get_axis("left", "right")
    var time := Time.get_ticks_msec() / 1000.0
    
    if current_direction != 0:
        last_direction = current_direction
        last_direction_time = time
        
    if Input.is_action_just_pressed("dash"):
        var direction := current_direction
        if direction == 0 && time - last_direction_time <= DIRECTION_BUFFER_TIME:
            direction = last_direction
            
        var beat = player.get_beat()
        if beat && ((direction < 0 && beat.global_position.x < player.global_position.x) || (direction > 0 && beat.global_position.x > player.global_position.x)):
            if target_beats.is_empty():
                initial_dash_x = player.global_position.x
                dash_timer = 0.0
            target_beats.append(beat)