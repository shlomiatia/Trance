class_name PlayerStateJump extends PlayerState

var _initial_y: float

func enter() -> void:
	_initial_y = player.global_position.y
	player.velocity = Vector2(120, -120)
	player.animated_sprite_2d.play("dash")

func _physics_process(_delta: float) -> void:
	if player.global_position.y > _initial_y:
		player.velocity.x = 0
		player.change_state(PlayerStateEnum.Type.FALL)
