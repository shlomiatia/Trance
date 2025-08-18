class_name PlayerStateFall extends PlayerState

func enter() -> void:
	player.animated_sprite_2d.animation = "dash"

func _physics_process(_delta: float) -> void:
	if player.is_on_floor():
		player.change_state(PlayerStateEnum.Type.STAND)