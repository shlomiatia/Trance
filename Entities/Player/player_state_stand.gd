class_name PlayerStateStand extends PlayerState

func _physics_process(_delta: float) -> void:
	if not player.is_on_floor():
		player.change_state(PlayerStateEnum.Type.FALL)
		return
		
	var direction := Input.get_axis("left", "right")
	if direction:
		player.change_state(PlayerStateEnum.Type.WALK)
		return
		
	player.velocity.x = move_toward(player.velocity.x, 0, Constants.player_speed)
