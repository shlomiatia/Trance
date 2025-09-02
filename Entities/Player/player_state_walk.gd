class_name PlayerStateWalk extends PlayerState

func enter() -> void:
    player.animated_sprite_2d.animation = "walk"

func _physics_process(_delta: float) -> void:
    if !player.is_on_floor():
        player.change_state(PlayerStateEnum.Type.FALL)
        return
        
    var direction := Input.get_axis("left", "right")
    
    if Input.is_action_pressed("dash"):
        var touch_pos = player.get_viewport().get_mouse_position()
        direction = 1.0 if touch_pos.x > player.get_viewport().get_visible_rect().size.x / 2.0 else -1.0
    
    
    if not direction:
        player.change_state(PlayerStateEnum.Type.STAND)
        return
        
    player.velocity.x = direction * Constants.player_speed
    player.animated_sprite_2d.flip_h = player.velocity.x > 0
