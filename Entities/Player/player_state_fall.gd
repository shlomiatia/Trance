class_name PlayerStateFall extends PlayerState

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	
	if player.is_on_floor():
		if direction:
			player.change_state(PlayerStateEnum.Type.WALK)
		else:
			player.change_state(PlayerStateEnum.Type.STAND)
		return
		
	if direction:
		player.velocity.x = direction * Constants.player_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Constants.player_speed)
