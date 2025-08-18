class_name PlayerStateWalk extends PlayerState

func _physics_process(_delta: float) -> void:
	if not player.is_on_floor():
		player.change_state(PlayerStateEnum.Type.FALL)
		return
		
	var direction := Input.get_axis("left", "right")
	if not direction:
		player.change_state(PlayerStateEnum.Type.STAND)
		return
		
	player.velocity.x = direction * Constants.player_speed
